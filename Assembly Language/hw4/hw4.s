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
    LDR r0, =input_matrix
    LDR r4, =input_matrix  /* index of input matrix */
    LDR r1, =output_matrix
    LDR r9, =output_matrix  /* index of output matrix */

/* --- outer loop --- */
    MOV r2, #0  /* row index of output matrix */
row_loop:
/* --- inner loop --- */
    MOV r3, #0  /* column loop in output matrix */

col_loop:
    /* initialize */
    MOV r5, #0
    MOV r6, #0
    MOV r7, #0
    MOV r8, #0 

    LDR r5, [r4]       /* kernal (0, 0) */
    LDR r7, [r4, #20]  /* kernal (1, 0) */
    /* if output_matrix column == 2, boundary happens. Won't LDR values of next column */
    CMP r3, #2
    BEQ not_boundary_column
    LDR r6, [r4, #4]   /* kernal (0, 1) */
    LDR r8, [r4, #24]  /* kernal (1, 1) */

not_boundary_column:
    CMP r2, #2
    BNE not_boundary_row
    /* if output_matrix row == 2, boundary happens. Clean the value of next row */
    MOV r7, #0 
    MOV r8, #0

not_boundary_row:
    /* if r5 < r6, r5 = r6 */
    CMP r5, r6
    MOVLT r5, r6

    /* if r5 < r7, r5 = r7 */
    CMP r5, r7
    MOVLT r5, r7

    /* if r5 < r8, r5 = r8 */
    CMP r5, r8
    MOVLT r5, r8

    /* store the max value to output_matrix */
    STR r5, [r9]

    /* conditionally col_loop */
    ADD r9, r9, #4  /* point to the next output_matrix element */
    ADD r3, r3, #1
    ADD r4, r4, #8  /* point to the next kernal, e.g. input_matrix(0, 0)->(0, 2) */
    CMP r3, #3
    BLT col_loop
    ADD r4, r4, #16  /* point to the next kernal, e.g. input_matrix(1, 1)->(2, 0) */

    /* conditionally row_loop */
    ADD r2, r2, #1
    CMP r2, #3
    BLT row_loop

    nop
