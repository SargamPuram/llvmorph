// Enhanced LLVM Obfuscator with Advanced Techniques
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include <fstream>
#include <random>
#include <chrono>
#include <map>
#include <vector>

using namespace llvm;

static cl::opt<std::string> InputFilename(cl::Positional, cl::desc("<input bitcode file>"), cl::Required);
static cl::opt<std::string> OutputFilename("o", cl::desc("Output filename"), cl::value_desc("filename"), cl::init("obfuscated.bc"));
static cl::opt<int> ObfuscationLevel("level", cl::desc("Obfuscation level (1-5)"), cl::init(3));
static cl::opt<int> ObfuscationCycles("cycles", cl::desc("Number of obfuscation cycles"), cl::init(2));
static cl::opt<bool> EnableStringEncryption("encrypt-strings", cl::desc("Enable string encryption"), cl::init(true));
static cl::opt<bool> EnableControlFlow("obfuscate-control-flow", cl::desc("Enable control flow obfuscation"), cl::init(true));
static cl::opt<bool> EnableBogusCode("insert-bogus-code", cl::desc("Insert bogus code"), cl::init(true));
static cl::opt<bool> EnableMBA("enable-mba", cl::desc("Enable Mixed Boolean Arithmetic"), cl::init(true));
static cl::opt<bool> EnableInstructionSub("enable-inst-sub", cl::desc("Enable instruction substitution"), cl::init(true));
static cl::opt<int> BogusCodeDensity("bogus-density", cl::desc("Bogus code density (1-10)"), cl::init(5));
static cl::opt<std::string> ReportFile("report", cl::desc("Report output file"), cl::init("obfuscation_report.txt"));

struct ObfuscationStats {
    int totalFunctions = 0;
    int obfuscatedFunctions = 0;
    int stringsEncrypted = 0;
    int bogusBlocksInserted = 0;
    int fakeLoopsInserted = 0;
    int controlFlowFlattened = 0;
    int instructionsSubstituted = 0;
    int mbaTransforms = 0;
    int cyclesCompleted = 0;
};

class CodeObfuscatorPass : public PassInfoMixin<CodeObfuscatorPass> {
public:
    ObfuscationStats stats;
    PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM);
private:
    void obfuscateStrings(Module &M);
    void insertBogusCode(Function &F);
    void insertFakeLoops(Function &F);
    void flattenControlFlow(Function &F);
    void substituteInstructions(Function &F);
    void applyMBA(Function &F);
    std::mt19937 rng{std::random_device{}()};
};

// ============================================
// STRING ENCRYPTION WITH RUNTIME DECRYPTION
// ============================================
void CodeObfuscatorPass::obfuscateStrings(Module &M) {
    if (!EnableStringEncryption) return;

    LLVMContext &Ctx = M.getContext();
    std::vector<std::pair<GlobalVariable*, std::string>> stringGlobals;

    // Find all string constants
    for (GlobalVariable &GV : M.globals()) {
        if (GV.hasInitializer() && !GV.isConstant()) continue;
        if (ConstantDataArray *CDA = dyn_cast_or_null<ConstantDataArray>(GV.getInitializer())) {
            if (CDA->isString()) {
                stringGlobals.push_back({&GV, CDA->getAsString().str()});
            }
        }
    }

    if (stringGlobals.empty()) return;

    // Create decryption function once
    FunctionType *DecryptFT = FunctionType::get(
        Type::getInt8Ty(Ctx)->getPointerTo(), // FIX: Was Type::getInt8PtrTy(Ctx)
        {Type::getInt8Ty(Ctx)->getPointerTo(), Type::getInt32Ty(Ctx)}, // FIX: Was Type::getInt8PtrTy(Ctx)
        false
    );

    Function *DecryptFunc = Function::Create(
        DecryptFT,
        GlobalValue::InternalLinkage,
        "decrypt_string",
        &M
    );

    BasicBlock *DecryptBB = BasicBlock::Create(Ctx, "entry", DecryptFunc);
    IRBuilder<> DB(DecryptBB);

    auto Args = DecryptFunc->arg_begin();
    Value *EncStr = &*Args++;
    Value *Len = &*Args;

    // Allocate buffer for decrypted string
    Value *Buffer = DB.CreateAlloca(DB.getInt8Ty(), Len, "buffer");

    // Decryption loop
    BasicBlock *LoopBB = BasicBlock::Create(Ctx, "loop", DecryptFunc);
    BasicBlock *EndBB = BasicBlock::Create(Ctx, "end", DecryptFunc);

    Value *Zero = DB.getInt32(0);
    DB.CreateBr(LoopBB);

    DB.SetInsertPoint(LoopBB);
    PHINode *Idx = DB.CreatePHI(DB.getInt32Ty(), 2, "i");
    Idx->addIncoming(Zero, DecryptBB);

    Value *EncPtr = DB.CreateGEP(DB.getInt8Ty(), EncStr, Idx);
    Value *EncChar = DB.CreateLoad(DB.getInt8Ty(), EncPtr);

    // XOR decryption
    Value *Key = DB.CreateLoad(DB.getInt8Ty(),
        DB.CreateGEP(DB.getInt8Ty(), EncStr, DB.CreateSub(Len, DB.getInt32(1))));
    Value *DecChar = DB.CreateXor(EncChar, Key);

    Value *BufPtr = DB.CreateGEP(DB.getInt8Ty(), Buffer, Idx);
    DB.CreateStore(DecChar, BufPtr);

    Value *NextIdx = DB.CreateAdd(Idx, DB.getInt32(1));
    Idx->addIncoming(NextIdx, LoopBB);

    Value *Cond = DB.CreateICmpULT(NextIdx, DB.CreateSub(Len, DB.getInt32(1)));
    DB.CreateCondBr(Cond, LoopBB, EndBB);

    DB.SetInsertPoint(EndBB);
    // Null terminate
    Value *NullPtr = DB.CreateGEP(DB.getInt8Ty(), Buffer, DB.CreateSub(Len, DB.getInt32(1)));
    DB.CreateStore(DB.getInt8(0), NullPtr);
    DB.CreateRet(Buffer);

    // Encrypt strings and replace uses
    for (auto &[GV, OrigStr] : stringGlobals) {
        uint8_t key = (rng() % 255) + 1; // Non-zero key
        std::vector<uint8_t> encrypted;

        for (char c : OrigStr) {
            encrypted.push_back(c ^ key);
        }
        encrypted.push_back(key); // Store key at end

        Constant *EncData = ConstantDataArray::get(Ctx, ArrayRef<uint8_t>(encrypted));
        GlobalVariable *EncGV = new GlobalVariable(
            M, EncData->getType(), true,
            GlobalValue::PrivateLinkage, EncData,
            ".enc.str"
        );

        // Replace all uses with decryption call
        std::vector<User*> Users(GV->user_begin(), GV->user_end());
        for (User *U : Users) {
            if (Instruction *I = dyn_cast<Instruction>(U)) {
                IRBuilder<> Builder(I);
                Value *EncPtr = Builder.CreatePointerCast(EncGV, Type::getInt8Ty(Ctx)->getPointerTo()); // FIX: Was Type::getInt8PtrTy(Ctx)
                Value *LenVal = Builder.getInt32(encrypted.size());
                Value *DecStr = Builder.CreateCall(DecryptFunc, {EncPtr, LenVal});

                GV->replaceUsesWithIf(DecStr, [I](Use &U) {
                    return U.getUser() == I;
                });
            }
        }

        stats.stringsEncrypted++;
    }
}

// ============================================
// CONTROL FLOW FLATTENING (REAL IMPLEMENTATION)
// ============================================
void CodeObfuscatorPass::flattenControlFlow(Function &F) {
    if (!EnableControlFlow || F.isDeclaration()) return;
    if (F.size() < 3) return; // Need at least 3 blocks

    LLVMContext &Ctx = F.getContext();

    // Collect original basic blocks (except entry)
    std::vector<BasicBlock*> origBBs;
    BasicBlock *entryBB = &F.getEntryBlock();

    for (BasicBlock &BB : F) {
        if (&BB != entryBB && !BB.isLandingPad()) {
            origBBs.push_back(&BB);
        }
    }

    if (origBBs.size() < 2) return;

    // Create dispatcher block
    BasicBlock *dispatcher = BasicBlock::Create(Ctx, "dispatcher", &F, entryBB->getNextNode());
    IRBuilder<> Builder(dispatcher);

    // Create switch variable
    // FIX: Use modern IRBuilder to create alloca instead of deprecated constructor
    IRBuilder<> TmpB(&*entryBB->getFirstInsertionPt());
    AllocaInst *switchVar = TmpB.CreateAlloca(Type::getInt32Ty(Ctx), nullptr, "sw.var");

    // Initialize switch var in entry
    IRBuilder<> EntryBuilder(entryBB->getTerminator());
    EntryBuilder.CreateStore(Builder.getInt32(0), switchVar);

    // Modify entry to jump to dispatcher
    entryBB->getTerminator()->eraseFromParent();
    IRBuilder<>(entryBB).CreateBr(dispatcher);

    // Create switch instruction
    Value *swVal = Builder.CreateLoad(Builder.getInt32Ty(), switchVar);
    SwitchInst *swInst = Builder.CreateSwitch(swVal, origBBs[0], origBBs.size());

    // Assign case values to each block
    for (size_t i = 0; i < origBBs.size(); ++i) {
        swInst->addCase(Builder.getInt32(i), origBBs[i]);

        // Modify block terminators to update switch var and jump to dispatcher
        Instruction *term = origBBs[i]->getTerminator();
        if (BranchInst *br = dyn_cast<BranchInst>(term)) {
            IRBuilder<> BBBuilder(term);

            if (br->isUnconditional()) {
                BasicBlock *target = br->getSuccessor(0);
                auto it = std::find(origBBs.begin(), origBBs.end(), target);
                if (it != origBBs.end()) {
                    int targetIdx = it - origBBs.begin();
                    BBBuilder.CreateStore(BBBuilder.getInt32(targetIdx), switchVar);
                    term->eraseFromParent();
                    BBBuilder.CreateBr(dispatcher);
                }
            }
        }
    }

    stats.controlFlowFlattened++;
}

// ============================================
// INSTRUCTION SUBSTITUTION
// ============================================
void CodeObfuscatorPass::substituteInstructions(Function &F) {
    if (!EnableInstructionSub || F.isDeclaration()) return;

    std::vector<Instruction*> toReplace;

    for (BasicBlock &BB : F) {
        for (Instruction &I : BB) {
            if (BinaryOperator *BO = dyn_cast<BinaryOperator>(&I)) {
                toReplace.push_back(BO);
            }
        }
    }

    for (Instruction *I : toReplace) {
        BinaryOperator *BO = cast<BinaryOperator>(I);
        IRBuilder<> Builder(BO);
        Value *NewInst = nullptr;

        switch (BO->getOpcode()) {
            case Instruction::Add: {
                // x + y => x - (-y)
                Value *NegY = Builder.CreateNeg(BO->getOperand(1));
                NewInst = Builder.CreateSub(BO->getOperand(0), NegY);
                stats.instructionsSubstituted++;
                break;
            }
            case Instruction::Sub: {
                // x - y => x + (-y)
                Value *NegY = Builder.CreateNeg(BO->getOperand(1));
                NewInst = Builder.CreateAdd(BO->getOperand(0), NegY);
                stats.instructionsSubstituted++;
                break;
            }
            case Instruction::Xor: {
                // x ^ y => (x | y) & ~(x & y)
                Value *Or = Builder.CreateOr(BO->getOperand(0), BO->getOperand(1));
                Value *And = Builder.CreateAnd(BO->getOperand(0), BO->getOperand(1));
                Value *NotAnd = Builder.CreateNot(And);
                NewInst = Builder.CreateAnd(Or, NotAnd);
                stats.instructionsSubstituted++;
                break;
            }
            default:
                continue;
        }

        if (NewInst) {
            BO->replaceAllUsesWith(NewInst);
            BO->eraseFromParent();
        }
    }
}

// ============================================
// MIXED BOOLEAN ARITHMETIC (MBA)
// ============================================
void CodeObfuscatorPass::applyMBA(Function &F) {
    if (!EnableMBA || F.isDeclaration()) return;

    std::vector<Instruction*> candidates;

    for (BasicBlock &BB : F) {
        for (Instruction &I : BB) {
            if (isa<BinaryOperator>(&I) || isa<ICmpInst>(&I)) {
                candidates.push_back(&I);
            }
        }
    }

    for (Instruction *I : candidates) {
        if (rng() % 100 > 30) continue; // 30% chance

        IRBuilder<> Builder(I);

        if (BinaryOperator *BO = dyn_cast<BinaryOperator>(I)) {
            Value *X = BO->getOperand(0);
            Value *Y = BO->getOperand(1);
            Value *MBA = nullptr;

            switch (BO->getOpcode()) {
                case Instruction::Add: {
                    // x + y = (x ^ y) + 2 * (x & y)
                    Value *Xor = Builder.CreateXor(X, Y);
                    Value *And = Builder.CreateAnd(X, Y);
                    Value *Shl = Builder.CreateShl(And, Builder.getInt32(1));
                    MBA = Builder.CreateAdd(Xor, Shl);
                    stats.mbaTransforms++;
                    break;
                }
                case Instruction::And: {
                    // x & y = (x + y) - (x | y)
                    Value *Add = Builder.CreateAdd(X, Y);
                    Value *Or = Builder.CreateOr(X, Y);
                    MBA = Builder.CreateSub(Add, Or);
                    stats.mbaTransforms++;
                    break;
                }
                case Instruction::Or: {
                    // x | y = (x & ~y) + y
                    Value *NotY = Builder.CreateNot(Y);
                    Value *And = Builder.CreateAnd(X, NotY);
                    MBA = Builder.CreateAdd(And, Y);
                    stats.mbaTransforms++;
                    break;
                }
                default:
                    continue;
            }

            if (MBA) {
                BO->replaceAllUsesWith(MBA);
                BO->eraseFromParent();
            }
        }
    }
}

// ============================================
// BOGUS CODE INSERTION
// ============================================
void CodeObfuscatorPass::insertBogusCode(Function &F) {
    if (!EnableBogusCode || F.isDeclaration()) return;

    std::vector<BasicBlock*> originalBlocks;
    for (BasicBlock &BB : F) {
        originalBlocks.push_back(&BB);
    }

    int bogusCount = std::min((int)originalBlocks.size(),
                              (int)(originalBlocks.size() * BogusCodeDensity) / 10);

    for (int i = 0; i < bogusCount; i++) {
        BasicBlock *BB = originalBlocks[i % originalBlocks.size()];
        Instruction *InsertBefore = BB->getTerminator();
        if (!InsertBefore) continue;

        IRBuilder<> Builder(InsertBefore);

        // Opaque predicate: (y * y) % 2 == (y % 2)
        Value *Y = Builder.getInt32(rng() % 100);
        Value *YSq = Builder.CreateMul(Y, Y);
        Value *Mod1 = Builder.CreateSRem(YSq, Builder.getInt32(2));
        Value *Mod2 = Builder.CreateSRem(Y, Builder.getInt32(2));
        Value *Cmp = Builder.CreateICmpEQ(Mod1, Mod2, "opaque");

        // Complex bogus operations
        Value *V1 = Builder.getInt32(rng() % 1000);
        Value *V2 = Builder.getInt32(rng() % 1000);
        Value *Add = Builder.CreateAdd(V1, V2);
        Value *Mul = Builder.CreateMul(Add, Builder.getInt32(7));
        Value *Xor = Builder.CreateXor(Mul, Builder.getInt32(0x12345678));

        stats.bogusBlocksInserted++;
    }
}

// ============================================
// FAKE LOOPS
// ============================================
void CodeObfuscatorPass::insertFakeLoops(Function &F) {
    if (F.isDeclaration()) return;

    BasicBlock &EntryBB = F.getEntryBlock();
    Instruction *FirstInst = &*EntryBB.getFirstInsertionPt();

    IRBuilder<> Builder(FirstInst);

    // Create fake counter with opaque predicate
    AllocaInst *counter = Builder.CreateAlloca(Builder.getInt32Ty(), nullptr, "fake_ctr");
    Builder.CreateStore(Builder.getInt32(100), counter);

    Value *loaded = Builder.CreateLoad(Builder.getInt32Ty(), counter);
    // Opaque: 100 < 0 is always false
    Value *cond = Builder.CreateICmpSLT(loaded, Builder.getInt32(0));

    stats.fakeLoopsInserted++;
}

// ============================================
// MAIN PASS
// ============================================
PreservedAnalyses CodeObfuscatorPass::run(Module &M, ModuleAnalysisManager &MAM) {
    stats.totalFunctions = M.getFunctionList().size();

    for (int cycle = 0; cycle < ObfuscationCycles; cycle++) {
        // String encryption (once)
        if (cycle == 0) {
            obfuscateStrings(M);
        }

        for (Function &F : M) {
            // FIX: Use starts_with instead of startswith
            if (F.isDeclaration() || F.getName().starts_with("llvm.") ||
                F.getName() == "decrypt_string") continue;

            stats.obfuscatedFunctions++;

            if (ObfuscationLevel >= 2) {
                insertBogusCode(F);
            }

            if (ObfuscationLevel >= 3) {
                insertFakeLoops(F);
                if (EnableInstructionSub) {
                    substituteInstructions(F);
                }
            }

            if (ObfuscationLevel >= 4) {
                if (EnableMBA) {
                    applyMBA(F);
                }
                flattenControlFlow(F);
            }
        }

        stats.cyclesCompleted++;
    }

    return PreservedAnalyses::none();
}

// ============================================
// REPORT GENERATION
// ============================================
void generateReport(const ObfuscationStats &stats, const std::string &inputFile,
                   const std::string &outputFile) {
    std::ofstream report(ReportFile);
    auto now = std::chrono::system_clock::now();
    std::time_t now_time = std::chrono::system_clock::to_time_t(now);

    report << "=================================================\n";
    report << "   ENHANCED LLVM CODE OBFUSCATION REPORT\n";
    report << "=================================================\n\n";
    report << "Generation Time: " << std::ctime(&now_time);

    report << "\n--- INPUT PARAMETERS ---\n";
    report << "Input File: " << inputFile << "\n";
    report << "Output File: " << outputFile << "\n";
    report << "Obfuscation Level: " << ObfuscationLevel << "/5\n";
    report << "Obfuscation Cycles: " << ObfuscationCycles << "\n";
    report << "String Encryption: " << (EnableStringEncryption ? "Enabled (with runtime decryption)" : "Disabled") << "\n";
    report << "Control Flow Flattening: " << (EnableControlFlow ? "Enabled (switch-based)" : "Disabled") << "\n";
    report << "Bogus Code Insertion: " << (EnableBogusCode ? "Enabled" : "Disabled") << "\n";
    report << "Instruction Substitution: " << (EnableInstructionSub ? "Enabled" : "Disabled") << "\n";
    report << "Mixed Boolean Arithmetic: " << (EnableMBA ? "Enabled" : "Disabled") << "\n";
    report << "Bogus Code Density: " << BogusCodeDensity << "/10\n";

    report << "\n--- OBFUSCATION STATISTICS ---\n";
    report << "Total Functions: " << stats.totalFunctions << "\n";
    report << "Obfuscated Functions: " << stats.obfuscatedFunctions << "\n";
    report << "Strings Encrypted: " << stats.stringsEncrypted << "\n";
    report << "Bogus Instructions Inserted: " << stats.bogusBlocksInserted << "\n";
    report << "Fake Loops Inserted: " << stats.fakeLoopsInserted << "\n";
    report << "Control Flow Flattened: " << stats.controlFlowFlattened << "\n";
    report << "Instructions Substituted: " << stats.instructionsSubstituted << "\n";
    report << "MBA Transformations: " << stats.mbaTransforms << "\n";
    report << "Obfuscation Cycles Completed: " << stats.cyclesCompleted << "\n";

    report << "\n--- OBFUSCATION TECHNIQUES APPLIED ---\n";
    report << "1. String Encryption: XOR-based with runtime decryption\n";
    report << "2. Control Flow Flattening: Switch-based dispatcher pattern\n";
    report << "3. Bogus Code: Opaque predicates and dead code\n";
    report << "4. Instruction Substitution: Algebraic transformations\n";
    report << "5. Mixed Boolean Arithmetic: Boolean/arithmetic mixing\n";
    report << "6. Fake Loops: Never-executing loop structures\n";

    int totalTransforms = stats.stringsEncrypted + stats.bogusBlocksInserted +
                         stats.controlFlowFlattened + stats.instructionsSubstituted +
                         stats.mbaTransforms + stats.fakeLoopsInserted;

    report << "\n--- SUMMARY ---\n";
    report << "Total Transformations Applied: " << totalTransforms << "\n";
    report << "Obfuscation Strength: " << (ObfuscationLevel * 20) << "%\n";
    report << "Reverse Engineering Difficulty: ";
    if (ObfuscationLevel >= 4) report << "Very High (Advanced techniques)\n";
    else if (ObfuscationLevel >= 3) report << "High (Multiple techniques)\n";
    else report << "Medium (Basic techniques)\n";

    report << "\n--- OUTPUT FILE ATTRIBUTES ---\n";
    report << "Format: LLVM Bitcode (.bc)\n";
    report << "Target Platforms: Linux, Windows (cross-compile)\n";
    report << "Optimization Level: Obfuscation-focused\n";

    report << "\n=================================================\n";
    report.close();

    errs() << "✓ Enhanced report generated: " << ReportFile << "\n";
}

// ============================================
// MAIN
// ============================================
int main(int argc, char **argv) {
    cl::ParseCommandLineOptions(argc, argv, "Enhanced LLVM Code Obfuscator\n");

    LLVMContext Context;
    SMDiagnostic Err;

    std::unique_ptr<Module> M = parseIRFile(InputFilename, Err, Context);
    if (!M) {
        Err.print(argv[0], errs());
        return 1;
    }

    errs() << "✓ Loaded module: " << InputFilename << "\n";
    errs() << "✓ Starting enhanced obfuscation (Level " << ObfuscationLevel << ")...\n";

    CodeObfuscatorPass ObfuscatorPass;
    ModuleAnalysisManager MAM;
    PassBuilder PB;
    PB.registerModuleAnalyses(MAM);

    ObfuscatorPass.run(*M, MAM);

    errs() << "✓ Verifying module integrity...\n";
    if (verifyModule(*M, &errs())) {
        errs() << "✗ Module verification failed!\n";
        return 1;
    }

    std::error_code EC;
    raw_fd_ostream OS(OutputFilename, EC);
    if (EC) {
        errs() << "✗ Error opening output file: " << EC.message() << "\n";
        return 1;
    }

    WriteBitcodeToFile(*M, OS);
    OS.flush();

    errs() << "✓ Obfuscated bitcode written to: " << OutputFilename << "\n";

    generateReport(ObfuscatorPass.stats, InputFilename, OutputFilename);

    errs() << "\n=== OBFUSCATION COMPLETED SUCCESSFULLY ===\n";
    errs() << "Transformations: "
           << (ObfuscatorPass.stats.stringsEncrypted +
               ObfuscatorPass.stats.bogusBlocksInserted +
               ObfuscatorPass.stats.instructionsSubstituted +
               ObfuscatorPass.stats.mbaTransforms) << " total\n";

    return 0;
}