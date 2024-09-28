	.file	"sample.c"
	.text
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$832, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -820(%rbp)
	movl	$0, -824(%rbp)
	jmp	.L2
.L3:
	call	rand@PLT
	movl	-824(%rbp), %edx
	movslq	%edx, %rdx
	movl	%eax, -816(%rbp,%rdx,4)
	addl	$1, -824(%rbp)
.L2:
	cmpl	$199, -824(%rbp)
	jle	.L3
	movl	$0, -824(%rbp)
	jmp	.L4
.L5:
	movl	-824(%rbp), %eax
	cltq
	movl	-816(%rbp,%rax,4), %eax
	addl	%eax, -820(%rbp)
	addl	$1, -824(%rbp)
.L4:
	cmpl	$100, -824(%rbp)
	jle	.L5
	movl	-820(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L7
	call	__stack_chk_fail@PLT
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
