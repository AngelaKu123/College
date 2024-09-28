	.section	.rodata
	.align	2
.LC0:
	.ascii	"number = %d\n\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #8
	mov	r3, #100
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	add	r3, r3, #10
	str	r3, [fp, #-20]
	ldr	r0, .L2
	ldr	r1, [fp, #-16]
	bl	printf
	mov	r3, #0
	mov	r0, r3
	ldmea	fp, {fp, sp, pc}
.L3:
	.align	2
.L2:
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.6"
