#!/bin/bash
set -e

echo "==================================================="
echo "  LLVM Code Obfuscator - Build & Test Script"
echo "==================================================="
echo ""

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}[1/6] Building obfuscator...${NC}"
mkdir -p build
cd build
cmake .. && make -j$(nproc)
cd ..
echo -e "${GREEN}✓ Obfuscator built${NC}\n"

echo -e "${YELLOW}[2/6] Compiling test.c to LLVM IR...${NC}"
clang -emit-llvm -S test.c -o test.ll
llvm-as test.ll -o test.bc
echo -e "${GREEN}✓ Generated test.bc${NC}\n"

echo -e "${YELLOW}[3/6] Running obfuscator (Level 3)...${NC}"
./build/obfuscator test.bc -o obfuscated_level3.bc -level=3 -cycles=2 -encrypt-strings -obfuscate-control-flow -insert-bogus-code -bogus-density=5 -report=report_level3.txt
echo -e "${GREEN}✓ Level 3 completed${NC}\n"

echo -e "${YELLOW}[4/6] Running obfuscator (Level 5)...${NC}"
./build/obfuscator test.bc -o obfuscated_level5.bc -level=5 -cycles=3 -encrypt-strings -obfuscate-control-flow -insert-bogus-code -bogus-density=8 -report=report_level5.txt
echo -e "${GREEN}✓ Level 5 completed${NC}\n"

echo -e "${YELLOW}[5/6] Generating executables...${NC}"
llc obfuscated_level3.bc -o obfuscated_level3.s
clang obfuscated_level3.s -o obfuscated_level3 -no-pie
llc obfuscated_level5.bc -o obfuscated_level5.s
clang obfuscated_level5.s -o obfuscated_level5 -no-pie
clang test.c -o original -no-pie
echo -e "${GREEN}✓ Executables generated${NC}\n"

echo -e "${YELLOW}[6/6] File sizes:${NC}"
ls -lh original obfuscated_level3 obfuscated_level5 | awk '{print "  "$9" → "$5}'

echo ""
echo -e "${GREEN}=== BUILD COMPLETE ===${NC}"
echo ""
echo "Test executables:"
echo "  ./original"
echo "  ./obfuscated_level3"
echo "  ./obfuscated_level5"
echo ""
echo "View reports:"
echo "  cat report_level3.txt"
echo "  cat report_level5.txt"
echo ""
