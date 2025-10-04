	.file	"test.c"
	.text
	.globl	greet                           # -- Begin function greet
	.p2align	4
	.type	greet,@function
greet:                                  # @greet
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$10, -16(%rbp)
	movl	$10, -12(%rbp)
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rsi
	movabsq	$.L.str, %rdi
	movb	$0, %al
	callq	printf@PLT
	movabsq	$.L.str.1, %rdi
	movb	$0, %al
	callq	printf@PLT
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	greet, .Lfunc_end0-greet
	.cfi_endproc
                                        # -- End function
	.globl	calculate                       # -- Begin function calculate
	.p2align	4
	.type	calculate,@function
calculate:                              # @calculate
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	$10, -20(%rbp)
	movl	$10, -16(%rbp)
	movl	%edi, -8(%rbp)
	movl	%esi, -4(%rbp)
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jle	.LBB1_2
# %bb.1:
	movl	-8(%rbp), %eax
	addl	-4(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB1_5
.LBB1_2:
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	.LBB1_4
# %bb.3:
	movl	-8(%rbp), %eax
	imull	-4(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB1_5
.LBB1_4:
	movl	-8(%rbp), %eax
	subl	-4(%rbp), %eax
	movl	%eax, -12(%rbp)
.LBB1_5:
	movl	-12(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	calculate, .Lfunc_end1-calculate
	.cfi_endproc
                                        # -- End function
	.globl	factorial                       # -- Begin function factorial
	.p2align	4
	.type	factorial,@function
factorial:                              # @factorial
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	$10, -20(%rbp)
	movl	$10, -16(%rbp)
	movl	%edi, -12(%rbp)
	movl	$1, -8(%rbp)
	movl	$1, -4(%rbp)
.LBB2_1:                                # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jg	.LBB2_4
# %bb.2:                                #   in Loop: Header=BB2_1 Depth=1
	movl	-4(%rbp), %eax
	imull	-8(%rbp), %eax
	movl	%eax, -8(%rbp)
# %bb.3:                                #   in Loop: Header=BB2_1 Depth=1
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB2_1
.LBB2_4:
	movl	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	factorial, .Lfunc_end2-factorial
	.cfi_endproc
                                        # -- End function
	.globl	complex_logic                   # -- Begin function complex_logic
	.p2align	4
	.type	complex_logic,@function
complex_logic:                          # @complex_logic
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	$10, -24(%rbp)
	movl	$10, -20(%rbp)
	movl	%edi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	$0, -4(%rbp)
	cmpl	$10, -8(%rbp)
	jle	.LBB3_5
# %bb.1:
	cmpl	$5, -12(%rbp)
	jge	.LBB3_3
# %bb.2:
	movl	-8(%rbp), %eax
	addl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB3_4
.LBB3_3:
	movl	-8(%rbp), %eax
	subl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB3_4:
	jmp	.LBB3_9
.LBB3_5:
	cmpl	$0, -16(%rbp)
	jne	.LBB3_7
# %bb.6:
	movl	-8(%rbp), %eax
	imull	-12(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB3_8
.LBB3_7:
	movl	-8(%rbp), %eax
	cltd
	idivl	-16(%rbp)
	movl	%eax, -4(%rbp)
.LBB3_8:
	jmp	.LBB3_9
.LBB3_9:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	complex_logic, .Lfunc_end3-complex_logic
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	$10, -28(%rbp)
	movl	$10, -24(%rbp)
	movl	$0, -20(%rbp)
	movabsq	$.L.str.2, %rax
	movq	%rax, -16(%rbp)
	movabsq	$.L.str.3, %rdi
	callq	greet
	movl	$15, -8(%rbp)
	movl	$20, -4(%rbp)
	movl	-8(%rbp), %edi
	movl	-4(%rbp), %esi
	callq	calculate
	movabsq	$.L.str.4, %rdi
	movl	%eax, %esi
	movb	$0, %al
	callq	printf@PLT
	movl	$5, %edi
	callq	factorial
	movabsq	$.L.str.5, %rdi
	movl	%eax, %esi
	movb	$0, %al
	callq	printf@PLT
	movl	$12, %edi
	movl	$3, %esi
	movl	$2, %edx
	callq	complex_logic
	movabsq	$.L.str.6, %rdi
	movl	%eax, %esi
	movb	$0, %al
	callq	printf@PLT
	movq	-16(%rbp), %rdi
	movl	$.L.str.2, %esi
	callq	strcmp@PLT
	cmpl	$0, %eax
	jne	.LBB4_2
# %bb.1:
	movabsq	$.L.str.7, %rdi
	movb	$0, %al
	callq	printf@PLT
	jmp	.LBB4_3
.LBB4_2:
	movabsq	$.L.str.8, %rdi
	movb	$0, %al
	callq	printf@PLT
.LBB4_3:
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Hello, %s!\n"
	.size	.L.str, 12

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"Welcome to the obfuscation test.\n"
	.size	.L.str.1, 34

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"SecretPassword123"
	.size	.L.str.2, 18

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"User"
	.size	.L.str.3, 5

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"Calculation result: %d\n"
	.size	.L.str.4, 24

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"Factorial of 5: %d\n"
	.size	.L.str.5, 20

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"Complex logic: %d\n"
	.size	.L.str.6, 19

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"Access granted!\n"
	.size	.L.str.7, 17

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"Access denied!\n"
	.size	.L.str.8, 16

	.type	.L.str.enc,@object              # @.str.enc
	.section	.rodata,"a",@progbits
.L.str.enc:
	.ascii	"\267\232\223\223\220\323\337\332\214\336\365\377\377"
	.size	.L.str.enc, 13

	.type	.L.str.1.enc,@object            # @.str.1.enc
	.p2align	4, 0x0
.L.str.1.enc:
	.ascii	"]ofiego*~e*~bo*ehl\177yik~ced*~oy~$\000\n\n"
	.size	.L.str.1.enc, 35

	.type	.L.str.2.enc,@object            # @.str.2.enc
	.p2align	4, 0x0
.L.str.2.enc:
	.ascii	"Oy\177nyhL}ooksnx-./\034\034"
	.size	.L.str.2.enc, 19

	.type	.L.str.3.enc,@object            # @.str.3.enc
.L.str.3.enc:
	.ascii	"tRDS!!"
	.size	.L.str.3.enc, 6

	.type	.L.str.4.enc,@object            # @.str.4.enc
	.p2align	4, 0x0
.L.str.4.enc:
	.ascii	"\361\323\336\321\307\336\323\306\333\335\334\222\300\327\301\307\336\306\210\222\227\326\270\262\262"
	.size	.L.str.4.enc, 25

	.type	.L.str.5.enc,@object            # @.str.5.enc
	.p2align	4, 0x0
.L.str.5.enc:
	.ascii	"\375\332\330\317\324\311\322\332\327\233\324\335\233\216\201\233\236\337\261\273\273"
	.size	.L.str.5.enc, 21

	.type	.L.str.6.enc,@object            # @.str.6.enc
	.p2align	4, 0x0
.L.str.6.enc:
	.ascii	"\354\300\302\337\303\312\327\217\303\300\310\306\314\225\217\212\313\245\257\257"
	.size	.L.str.6.enc, 20

	.type	.L.str.7.enc,@object            # @.str.7.enc
	.p2align	4, 0x0
.L.str.7.enc:
	.ascii	"\255\217\217\211\237\237\314\213\236\215\202\230\211\210\315\346\354\354"
	.size	.L.str.7.enc, 18

	.type	.L.str.8.enc,@object            # @.str.8.enc
	.p2align	4, 0x0
.L.str.8.enc:
	.ascii	"\322\360\360\366\340\340\263\367\366\375\372\366\367\262\231\223\223"
	.size	.L.str.8.enc, 17

	.type	.L.str.enc.1,@object            # @.str.enc.1
.L.str.enc.1:
	.ascii	"\n'..-nbg1cHBB"
	.size	.L.str.enc.1, 13

	.type	.L.str.1.enc.2,@object          # @.str.1.enc.2
	.p2align	4, 0x0
.L.str.1.enc.2:
	.ascii	"wELCOME\000TO\000THE\000OBFUSCATION\000TEST\016*  "
	.size	.L.str.1.enc.2, 35

	.type	.L.str.2.enc.3,@object          # @.str.2.enc.3
	.p2align	4, 0x0
.L.str.2.enc.3:
	.ascii	"RdbsduQ`rrvnse032\001\001"
	.size	.L.str.2.enc.3, 19

	.type	.L.str.3.enc.4,@object          # @.str.3.enc.4
.L.str.3.enc.4:
	.ascii	"\310\356\370\357\235\235"
	.size	.L.str.3.enc.4, 6

	.type	.L.str.4.enc.5,@object          # @.str.4.enc.5
	.p2align	4, 0x0
.L.str.4.enc.5:
	.ascii	"\255\217\202\215\233\202\217\232\207\201\200\316\234\213\235\233\202\232\324\316\313\212\344\356\356"
	.size	.L.str.4.enc.5, 25

	.type	.L.str.5.enc.6,@object          # @.str.5.enc.6
	.p2align	4, 0x0
.L.str.5.enc.6:
	.ascii	"\273\234\236\211\222\217\224\234\221\335\222\233\335\310\307\335\330\231\367\375\375"
	.size	.L.str.5.enc.6, 21

	.type	.L.str.6.enc.7,@object          # @.str.6.enc.7
	.p2align	4, 0x0
.L.str.6.enc.7:
	.ascii	"\236\262\260\255\261\270\245\375\261\262\272\264\276\347\375\370\271\327\335\335"
	.size	.L.str.6.enc.7, 20

	.type	.L.str.7.enc.8,@object          # @.str.7.enc.8
	.p2align	4, 0x0
.L.str.7.enc.8:
	.ascii	"\336\374\374\372\354\354\277\370\355\376\361\353\372\373\276\225\237\237"
	.size	.L.str.7.enc.8, 18

	.type	.L.str.8.enc.9,@object          # @.str.8.enc.9
	.p2align	4, 0x0
.L.str.8.enc.9:
	.ascii	"jHHNXX\013ONEBNO\n!++"
	.size	.L.str.8.enc.9, 17

	.type	.L.str.enc.enc,@object          # @.str.enc.enc
.L.str.enc.enc:
	.ascii	"\256\203\212\212\211\312\306\303\225\307\354\346\346\031"
	.size	.L.str.enc.enc, 14

	.type	.L.str.1.enc.enc,@object        # @.str.1.enc.enc
	.p2align	4, 0x0
.L.str.1.enc.enc:
	.ascii	"L~wxtv~;ot;os~;ty}nhxzortu;o~ho5\021\033\033\021"
	.size	.L.str.1.enc.enc, 36

	.type	.L.str.2.enc.enc,@object        # @.str.2.enc.enc
	.p2align	4, 0x0
.L.str.2.enc.enc:
	.ascii	"\332\354\352\373\354\375\331\350\372\372\376\346\373\355\270\273\272\211\211\225"
	.size	.L.str.2.enc.enc, 20

	.type	.L.str.3.enc.enc,@object        # @.str.3.enc.enc
.L.str.3.enc.enc:
	.ascii	"\f*<+YYx"
	.size	.L.str.3.enc.enc, 7

	.type	.L.str.4.enc.enc,@object        # @.str.4.enc.enc
	.p2align	4, 0x0
.L.str.4.enc.enc:
	.ascii	"xZWXNWZORTU\033I^HNWO\001\033\036_1;;\211"
	.size	.L.str.4.enc.enc, 26

	.type	.L.str.5.enc.enc,@object        # @.str.5.enc.enc
	.p2align	4, 0x0
.L.str.5.enc.enc:
	.ascii	"x_]JQLW_R\036QX\036\013\004\036\033Z4>>\205"
	.size	.L.str.5.enc.enc, 22

	.type	.L.str.6.enc.enc,@object        # @.str.6.enc.enc
	.p2align	4, 0x0
.L.str.6.enc.enc:
	.ascii	"\027;9$81,t8;3=7ntq0^TT\373"
	.size	.L.str.6.enc.enc, 21

	.type	.L.str.7.enc.enc,@object        # @.str.7.enc.enc
	.p2align	4, 0x0
.L.str.7.enc.enc:
	.ascii	"\275\237\237\231\217\217\334\233\216\235\222\210\231\230\335\366\374\374\020"
	.size	.L.str.7.enc.enc, 19

	.type	.L.str.8.enc.enc,@object        # @.str.8.enc.enc
	.p2align	4, 0x0
.L.str.8.enc.enc:
	.ascii	"'\005\005\003\025\025F\002\003\b\017\003\002Glff\365"
	.size	.L.str.8.enc.enc, 18

	.ident	"clang version 20.1.8"
	.section	".note.GNU-stack","",@progbits
