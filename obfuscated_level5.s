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
	subq	$32, %rsp
	movl	$10, -20(%rbp)
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
	addq	$32, %rsp
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
	movl	$10, -24(%rbp)
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
	movl	$10, -24(%rbp)
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
	movl	$10, -28(%rbp)
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
	movl	$10, -32(%rbp)
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
	.ascii	"\345\310\301\301\302\201\215\210\336\214\247\255\255"
	.size	.L.str.enc, 13

	.type	.L.str.1.enc,@object            # @.str.1.enc
	.p2align	4, 0x0
.L.str.1.enc:
	.ascii	"zHANB@H\rYB\rYEH\rBOKX^NLYDBC\rYH^Y\003'--"
	.size	.L.str.1.enc, 35

	.type	.L.str.2.enc,@object            # @.str.2.enc
	.p2align	4, 0x0
.L.str.2.enc:
	.ascii	"\223\245\243\262\245\264\220\241\263\263\267\257\262\244\361\362\363\300\300"
	.size	.L.str.2.enc, 19

	.type	.L.str.3.enc,@object            # @.str.3.enc
.L.str.3.enc:
	.ascii	")\017\031\016||"
	.size	.L.str.3.enc, 6

	.type	.L.str.4.enc,@object            # @.str.4.enc
	.p2align	4, 0x0
.L.str.4.enc:
	.ascii	"\352\310\305\312\334\305\310\335\300\306\307\211\333\314\332\334\305\335\223\211\214\315\243\251\251"
	.size	.L.str.4.enc, 25

	.type	.L.str.5.enc,@object            # @.str.5.enc
	.p2align	4, 0x0
.L.str.5.enc:
	.ascii	"\361\326\324\303\330\305\336\326\333\227\330\321\227\202\215\227\222\323\275\267\267"
	.size	.L.str.5.enc, 21

	.type	.L.str.6.enc,@object            # @.str.6.enc
	.p2align	4, 0x0
.L.str.6.enc:
	.ascii	"\016\" =!(5m!\"*$.wmh)GMM"
	.size	.L.str.6.enc, 20

	.type	.L.str.7.enc,@object            # @.str.7.enc
	.p2align	4, 0x0
.L.str.7.enc:
	.ascii	"!\003\003\005\023\023@\007\022\001\016\024\005\004Aj``"
	.size	.L.str.7.enc, 18

	.type	.L.str.8.enc,@object            # @.str.8.enc
	.p2align	4, 0x0
.L.str.8.enc:
	.ascii	"$\006\006\000\026\026E\001\000\013\f\000\001Doee"
	.size	.L.str.8.enc, 17

	.type	.L.str.enc.1,@object            # @.str.enc.1
.L.str.enc.1:
	.ascii	"Zw~~}>27a3\030\022\022"
	.size	.L.str.enc.1, 13

	.type	.L.str.1.enc.2,@object          # @.str.1.enc.2
	.p2align	4, 0x0
.L.str.1.enc.2:
	.ascii	"\036,%*&$,i=&i=!,i&+/<:*(= &'i=,:=gCII"
	.size	.L.str.1.enc.2, 35

	.type	.L.str.2.enc.3,@object          # @.str.2.enc.3
	.p2align	4, 0x0
.L.str.2.enc.3:
	.ascii	"tBDUBSwFTTPHUC\026\025\024''"
	.size	.L.str.2.enc.3, 19

	.type	.L.str.3.enc.4,@object          # @.str.3.enc.4
.L.str.3.enc.4:
	.ascii	"\313\355\373\354\236\236"
	.size	.L.str.3.enc.4, 6

	.type	.L.str.4.enc.5,@object          # @.str.4.enc.5
	.p2align	4, 0x0
.L.str.4.enc.5:
	.ascii	"-\017\002\r\033\002\017\032\007\001\000N\034\013\035\033\002\032TNK\ndnn"
	.size	.L.str.4.enc.5, 25

	.type	.L.str.5.enc.6,@object          # @.str.5.enc.6
	.p2align	4, 0x0
.L.str.5.enc.6:
	.ascii	"+\f\016\031\002\037\004\f\001M\002\013MXWMH\tgmm"
	.size	.L.str.5.enc.6, 21

	.type	.L.str.6.enc.7,@object          # @.str.6.enc.7
	.p2align	4, 0x0
.L.str.6.enc.7:
	.ascii	"\343\317\315\320\314\305\330\200\314\317\307\311\303\232\200\205\304\252\240\240"
	.size	.L.str.6.enc.7, 20

	.type	.L.str.7.enc.8,@object          # @.str.7.enc.8
	.p2align	4, 0x0
.L.str.7.enc.8:
	.ascii	"\215\257\257\251\277\277\354\253\276\255\242\270\251\250\355\306\314\314"
	.size	.L.str.7.enc.8, 18

	.type	.L.str.8.enc.9,@object          # @.str.8.enc.9
	.p2align	4, 0x0
.L.str.8.enc.9:
	.ascii	"rPPV@@\023WV]ZVW\022933"
	.size	.L.str.8.enc.9, 17

	.type	.L.str.enc.enc,@object          # @.str.enc.enc
.L.str.enc.enc:
	.ascii	"\342\317\306\306\305\206\212\217\331\213\240\252\252\007"
	.size	.L.str.enc.enc, 14

	.type	.L.str.1.enc.enc,@object        # @.str.1.enc.enc
	.p2align	4, 0x0
.L.str.1.enc.enc:
	.ascii	"\202\260\271\266\272\270\260\365\241\272\365\241\275\260\365\272\267\263\240\246\266\264\241\274\272\273\365\241\260\246\241\373\337\325\325\370"
	.size	.L.str.1.enc.enc, 36

	.type	.L.str.2.enc.enc,@object        # @.str.2.enc.enc
	.p2align	4, 0x0
.L.str.2.enc.enc:
	.ascii	"dRTERCgVDD@XES\006\005\00477\367"
	.size	.L.str.2.enc.enc, 20

	.type	.L.str.3.enc.enc,@object        # @.str.3.enc.enc
.L.str.3.enc.enc:
	.ascii	"\317\351\377\350\232\232\346"
	.size	.L.str.3.enc.enc, 7

	.type	.L.str.4.enc.enc,@object        # @.str.4.enc.enc
	.p2align	4, 0x0
.L.str.4.enc.enc:
	.ascii	"\f.#,:#.;& !o=*<:#;uoj+EOO\346"
	.size	.L.str.4.enc.enc, 26

	.type	.L.str.5.enc.enc,@object        # @.str.5.enc.enc
	.p2align	4, 0x0
.L.str.5.enc.enc:
	.ascii	"Cdfqjwldi%jc%0?% a\017\005\005\262"
	.size	.L.str.5.enc.enc, 22

	.type	.L.str.6.enc.enc,@object        # @.str.6.enc.enc
	.p2align	4, 0x0
.L.str.6.enc.enc:
	.ascii	"\267\233\231\204\230\221\214\324\230\233\223\235\227\316\324\321\220\376\364\364\271"
	.size	.L.str.6.enc.enc, 21

	.type	.L.str.7.enc.enc,@object        # @.str.7.enc.enc
	.p2align	4, 0x0
.L.str.7.enc.enc:
	.ascii	"\"\000\000\006\020\020C\004\021\002\r\027\006\007Bicc\003"
	.size	.L.str.7.enc.enc, 19

	.type	.L.str.8.enc.enc,@object        # @.str.8.enc.enc
	.p2align	4, 0x0
.L.str.8.enc.enc:
	.ascii	"\256\214\214\212\234\234\317\213\212\201\206\212\213\316\345\357\357\212"
	.size	.L.str.8.enc.enc, 18

	.type	.L.str.enc.10,@object           # @.str.enc.10
.L.str.enc.10:
	.ascii	"\020=447tx}+yRXX"
	.size	.L.str.enc.10, 13

	.type	.L.str.1.enc.11,@object         # @.str.1.enc.11
	.p2align	4, 0x0
.L.str.1.enc.11:
	.ascii	"n\\UZVT\\\031MV\031MQ\\\031V[_LJZXMPVW\031M\\JM\027399"
	.size	.L.str.1.enc.11, 35

	.type	.L.str.2.enc.12,@object         # @.str.2.enc.12
	.p2align	4, 0x0
.L.str.2.enc.12:
	.ascii	"\256\230\236\217\230\211\255\234\216\216\212\222\217\231\314\317\316\375\375"
	.size	.L.str.2.enc.12, 19

	.type	.L.str.3.enc.13,@object         # @.str.3.enc.13
.L.str.3.enc.13:
	.ascii	";\035\013\034nn"
	.size	.L.str.3.enc.13, 6

	.type	.L.str.4.enc.14,@object         # @.str.4.enc.14
	.p2align	4, 0x0
.L.str.4.enc.14:
	.ascii	"\034>3<*3>+601\177-:,*3+e\177z;U__"
	.size	.L.str.4.enc.14, 25

	.type	.L.str.5.enc.15,@object         # @.str.5.enc.15
	.p2align	4, 0x0
.L.str.5.enc.15:
	.ascii	"\031><+0-6>3\17709\177je\177z;U__"
	.size	.L.str.5.enc.15, 21

	.type	.L.str.6.enc.16,@object         # @.str.6.enc.16
	.p2align	4, 0x0
.L.str.6.enc.16:
	.ascii	"\202\256\254\261\255\244\271\341\255\256\246\250\242\373\341\344\245\313\301\301"
	.size	.L.str.6.enc.16, 20

	.type	.L.str.7.enc.17,@object         # @.str.7.enc.17
	.p2align	4, 0x0
.L.str.7.enc.17:
	.ascii	"\346\304\304\302\324\324\207\300\325\306\311\323\302\303\206\255\247\247"
	.size	.L.str.7.enc.17, 18

	.type	.L.str.8.enc.18,@object         # @.str.8.enc.18
	.p2align	4, 0x0
.L.str.8.enc.18:
	.ascii	"\341\303\303\305\323\323\200\304\305\316\311\305\304\201\252\240\240"
	.size	.L.str.8.enc.18, 17

	.type	.L.str.enc.enc.19,@object       # @.str.enc.enc.19
.L.str.enc.enc.19:
	.ascii	"\333\366\377\377\374\277\263\266\340\262\231\223\223>"
	.size	.L.str.enc.enc.19, 14

	.type	.L.str.1.enc.enc.20,@object     # @.str.1.enc.enc.20
	.p2align	4, 0x0
.L.str.1.enc.enc.20:
	.ascii	"\t;2=13;~*1~*6;~1<8+-=?*710~*;-*pT^^s"
	.size	.L.str.1.enc.enc.20, 36

	.type	.L.str.2.enc.enc.21,@object     # @.str.2.enc.enc.21
	.p2align	4, 0x0
.L.str.2.enc.enc.21:
	.ascii	"Cusbud@qccg\177bt!\"#\020\020\320"
	.size	.L.str.2.enc.enc.21, 20

	.type	.L.str.3.enc.enc.22,@object     # @.str.3.enc.enc.22
.L.str.3.enc.enc.22:
	.ascii	"\232\274\252\275\317\317\263"
	.size	.L.str.3.enc.enc.22, 7

	.type	.L.str.4.enc.enc.23,@object     # @.str.4.enc.enc.23
	.p2align	4, 0x0
.L.str.4.enc.enc.23:
	.ascii	"\310\352\347\350\376\347\352\377\342\344\345\253\371\356\370\376\347\377\261\253\256\357\201\213\213\""
	.size	.L.str.4.enc.enc.23, 26

	.type	.L.str.5.enc.enc.24,@object     # @.str.5.enc.enc.24
	.p2align	4, 0x0
.L.str.5.enc.enc.24:
	.ascii	"vQSD_BYQ\\\020_V\020\005\n\020\025T:00\207"
	.size	.L.str.5.enc.enc.24, 22

	.type	.L.str.6.enc.enc.25,@object     # @.str.6.enc.enc.25
	.p2align	4, 0x0
.L.str.6.enc.enc.25:
	.ascii	"\313\347\345\370\344\355\360\250\344\347\357\341\353\262\250\255\354\202\210\210\305"
	.size	.L.str.6.enc.enc.25, 21

	.type	.L.str.7.enc.enc.26,@object     # @.str.7.enc.enc.26
	.p2align	4, 0x0
.L.str.7.enc.enc.26:
	.ascii	"\214\256\256\250\276\276\355\252\277\254\243\271\250\251\354\307\315\315\255"
	.size	.L.str.7.enc.enc.26, 19

	.type	.L.str.8.enc.enc.27,@object     # @.str.8.enc.enc.27
	.p2align	4, 0x0
.L.str.8.enc.enc.27:
	.ascii	"Qssucc0tu~yut1\032\020\020u"
	.size	.L.str.8.enc.enc.27, 18

	.type	.L.str.enc.1.enc,@object        # @.str.enc.1.enc
.L.str.enc.1.enc:
	.ascii	"/\002\013\013\bKGB\024Fmggu"
	.size	.L.str.enc.1.enc, 14

	.type	.L.str.1.enc.2.enc,@object      # @.str.1.enc.2.enc
	.p2align	4, 0x0
.L.str.1.enc.2.enc:
	.ascii	"\311\373\362\375\361\363\373\276\352\361\276\352\366\373\276\361\374\370\353\355\375\377\352\367\361\360\276\352\373\355\352\260\224\236\236\327"
	.size	.L.str.1.enc.2.enc, 36

	.type	.L.str.2.enc.3.enc,@object      # @.str.2.enc.3.enc
	.p2align	4, 0x0
.L.str.2.enc.3.enc:
	.ascii	"\347\321\327\306\321\300\344\325\307\307\303\333\306\320\205\206\207\264\264\223"
	.size	.L.str.2.enc.3.enc, 20

	.type	.L.str.3.enc.4.enc,@object      # @.str.3.enc.4.enc
.L.str.3.enc.4.enc:
	.ascii	"\357\311\337\310\272\272$"
	.size	.L.str.3.enc.4.enc, 7

	.type	.L.str.4.enc.5.enc,@object      # @.str.4.enc.5.enc
	.p2align	4, 0x0
.L.str.4.enc.5.enc:
	.ascii	"\n(%*<%(= &'i;,:<%=sil-CII'"
	.size	.L.str.4.enc.5.enc, 26

	.type	.L.str.5.enc.6.enc,@object      # @.str.5.enc.6.enc
	.p2align	4, 0x0
.L.str.5.enc.6.enc:
	.ascii	"Klnyb\177dla-bk-87-(i\007\r\r`"
	.size	.L.str.5.enc.6.enc, 22

	.type	.L.str.6.enc.7.enc,@object      # @.str.6.enc.7.enc
	.p2align	4, 0x0
.L.str.6.enc.7.enc:
	.ascii	"\234\260\262\257\263\272\247\377\263\260\270\266\274\345\377\372\273\325\337\337\177"
	.size	.L.str.6.enc.7.enc, 21

	.type	.L.str.7.enc.8.enc,@object      # @.str.7.enc.8.enc
	.p2align	4, 0x0
.L.str.7.enc.8.enc:
	.ascii	"\374\336\336\330\316\316\235\332\317\334\323\311\330\331\234\267\275\275q"
	.size	.L.str.7.enc.8.enc, 19

	.type	.L.str.8.enc.9.enc,@object      # @.str.8.enc.9.enc
	.p2align	4, 0x0
.L.str.8.enc.9.enc:
	.ascii	"\225\267\267\261\247\247\364\260\261\272\275\261\260\365\336\324\324\347"
	.size	.L.str.8.enc.9.enc, 18

	.type	.L.str.enc.enc.enc,@object      # @.str.enc.enc.enc
.L.str.enc.enc.enc:
	.ascii	"#\016\007\007\004GKN\030Jakk\306\301"
	.size	.L.str.enc.enc.enc, 15

	.type	.L.str.1.enc.enc.enc,@object    # @.str.1.enc.enc.enc
	.p2align	4, 0x0
.L.str.1.enc.enc.enc:
	.ascii	"\323\341\350\347\353\351\341\244\360\353\244\360\354\341\244\353\346\342\361\367\347\345\360\355\353\352\244\360\341\367\360\252\216\204\204\251Q"
	.size	.L.str.1.enc.enc.enc, 37

	.type	.L.str.2.enc.enc.enc,@object    # @.str.2.enc.enc.enc
	.p2align	4, 0x0
.L.str.2.enc.enc.enc:
	.ascii	"v@FW@QuDVVRJWA\024\027\026%%\345\022"
	.size	.L.str.2.enc.enc.enc, 21

	.type	.L.str.3.enc.enc.enc,@object    # @.str.3.enc.enc.enc
.L.str.3.enc.enc.enc:
	.ascii	"\373\335\313\334\256\256\3224"
	.size	.L.str.3.enc.enc.enc, 8

	.type	.L.str.4.enc.enc.enc,@object    # @.str.4.enc.enc.enc
	.p2align	4, 0x0
.L.str.4.enc.enc.enc:
	.ascii	"!\003\016\001\027\016\003\026\013\r\fB\020\007\021\027\016\026XBG\006hbb\313-"
	.size	.L.str.4.enc.enc.enc, 27

	.type	.L.str.5.enc.enc.enc,@object    # @.str.5.enc.enc.enc
	.p2align	4, 0x0
.L.str.5.enc.enc.enc:
	.ascii	"}ZXOTIRZW\033T]\033\016\001\033\036_1;;\214>"
	.size	.L.str.5.enc.enc.enc, 23

	.type	.L.str.6.enc.enc.enc,@object    # @.str.6.enc.enc.enc
	.p2align	4, 0x0
.L.str.6.enc.enc.enc:
	.ascii	"\211\245\247\272\246\257\262\352\246\245\255\243\251\360\352\357\256\300\312\312\207>"
	.size	.L.str.6.enc.enc.enc, 22

	.type	.L.str.7.enc.enc.enc,@object    # @.str.7.enc.enc.enc
	.p2align	4, 0x0
.L.str.7.enc.enc.enc:
	.ascii	"uWWQGG\024SFUZ@QP\025>44TW"
	.size	.L.str.7.enc.enc.enc, 20

	.type	.L.str.8.enc.enc.enc,@object    # @.str.8.enc.enc.enc
	.p2align	4, 0x0
.L.str.8.enc.enc.enc:
	.ascii	"Mooi\177\177,hibeih-\006\f\fi\343"
	.size	.L.str.8.enc.enc.enc, 19

	.ident	"clang version 20.1.8"
	.section	".note.GNU-stack","",@progbits
