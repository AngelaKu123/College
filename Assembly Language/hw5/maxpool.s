    .section .text
    .global maxPool
    .type maxPool,%function
maxPool:
    /* function start */
    mov ip, sp
    push {r4-r10, fp, ip, lr, pc}
    sub fp, ip, #4

    /* --- begin your function --- */

    MOV r2, r0  /* index of input_matrix */
    MOV r3, r1  /* index of output_matrix */

/* --- outer loop --- */
    MOV r4, #0  /* row index of output_matrix */
row_loop:
/* --- inner loop --- */
    MOV r5, #0  /* column loop of output_matrix */
col_loop:
    /* initialize */
    MOV r6, #0
    MOV r7, #0
    MOV r8, #0
    MOV r9, #0

    LDR r6, [r2]       /* kernal (0, 0) */
    LDR r8, [r2, #20]  /* kernal (1, 0) */
    /* if output_matrix column == 2, boundary happens. Won't LDR values of next column */
    CMP r5, #2
    BEQ not_boundary_column
    LDR r7, [r2, #4]   /* kernal (0, 1) */
    LDR r9, [r2, #24]  /* kernal (1, 1) */

    not_boundary_column:
    CMP r4, #2
    BNE not_boundary_row
    /* if output_matrix row == 2, boundary happens. Clean the value of next row */
    MOV r8, #0 
    MOV r9, #0

    not_boundary_row:
    /* if r6 < r7, r6 = r7 */
    CMP r6, r7
    MOVLT r6, r7

    /* if r6 < r8, r6 = r8 */
    CMP r6, r8
    MOVLT r6, r8

    /* if r6 < r9, r6 = r9 */
    CMP r6, r9
    MOVLT r6, r9

    /* store the max value to output_matrix */
    STR r6, [r3]

    /* conditionally col_loop */
    ADD r3, r3, #4  /* point to the next output_matrix element */
    ADD r5, r5, #1
    ADD r2, r2, #8  /* point to the next kernal, e.g. input_matrix(0, 0)->(0, 2) */
    CMP r5, #3
    BLT col_loop
    ADD r2, r2, #16  /* point to the next kernal, e.g. input_matrix(1, 1)->(2, 0) */

    /* conditionally row_loop */
    ADD r4, r4, #1
    CMP r4, #3
    BLT row_loop

    /* --- end of your function --- */

    /* function exit */
    sub sp, fp, #40
    ldmfd sp, {r4-r10, fp, sp, lr}
    bx lr
    .end
    