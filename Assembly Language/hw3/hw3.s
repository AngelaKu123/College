/* ========================= */
/*       DATA section        */
/* ========================= */
	.data
	.align 4

/* --- variable a --- */
	.type a, %object
	.size a, 40 /* 4bytes * 10 */
a: /* [1 10] */
	.word 1, 2, 3, -4, 2, 6, 4, -1, 5, 2

/* --- variable b --- */
	.type b, %object
	.size b, 40
b:
	.word 3, -1, 6, 2, 7, 5, 4, 9, 8, -6

c:
	.space 4, 0 

/* ========================= */
/*       TEXT section        */
/* ========================= */
	.section .text
	.global main
	.type main,%function
.matrix:
	.word a
	.word b
	.word c
	
main:
	ldr r0, =0 /* accumulate a * b */
	ldr r1, =.matrix
	ldr r2, [r1], #4 /* r2 =mem(a) */
	ldr r3, [r1], #4 /* r3 =mem(b) */
	ldr r4, [r1] /* r4 =mem(c) */
	ldr r5, =#10 /* loop counter */

loop:
	ldr r6, [r2], #4 /* a[1, k] */
	ldr r7, [r3], #4 /* b[1, k] */
	mul r8, r6, r7 /* a * b */
	add r0, r0, r8 /* r0 = a * b */

	subs r5, r5, #1 /* loop counter -1 */
	bne loop /* `bne` auto checks zero flag, which is the last instruction `subs` main body */

	/* result */
	str r0, [r4] /* c =r0 */
        nop
