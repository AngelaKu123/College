/* ========================= */
/*       DATA section        */
/* ========================= */
    .data
	.align 4

/* --- matrix input 5*5 --- */
    .type input_matrix, %object
    .size input_matrix, 100      /* 4 * 5 * 5 */
input_matrix:
    .word 1, 2, 3, 4, 5
    .word 6, 7, 8, 9, 0
    .word 3, 2, 1, 4, 2
    .word 1, 2, 0, 4, 5
    .word 9, 2, 8, 4, 1

/* --- matrix output 3*3 --- */
    .type output_matrix, %object
    .size output_matrix, 36      /* 4 * 3 * 3 */
output_matrix:
    .word 0, 0, 0
    .word 0, 0, 0
    .word 0, 0, 0

/* ========================= */
/*       TEXT section        */
/* ========================= */
    .section .text
    .global main
    .type main, %function
main:
    mov ip, sp
    push {fp, ip, lr, pc}
    sub fp, ip, #4

    LDR r0, =input_matrix
    LDR r1, =output_matrix
    BL maxPool

    nop
    sub sp, fp, #12
    ldmfd sp, {fp, sp, lr}
    bx lr
    .end
