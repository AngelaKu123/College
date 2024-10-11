/* ========================= */
/* TEXT section */
/* ========================= */
    .section .text
    .global main
    .type main,%function
main:
    ldr r1,=#10 /* r1 = 10 */
    ldr r2,=#20 /* r2 = 20 */
    ldr r3,=#12 /* r3 = 12 */
    /* r0 = 2 * r1 + 4 * r2 - 7 * r3 */

    /* 2 * r1 */
    mov r4, r1, lsl #1  /* r4 =  r1 << (2 * r1) */

    /* 4 * r2 */
    mov r5, r2, lsl #2  /* r5 = r2 << 2 (4 * r2) */

    /* 7 * r3 */
    mov r6, r3, lsl #3  /* r6 = r3 << 3 (8 * r3) */
    sub r6, r6, r3      /* r6 = r6 - r3 (7 * r3) */

    /* r0 = 2 * r1 + 4 * r2 - 7 * r3 */
    add r0, r4, r5      /* r0 = 2 * r1 + 4 * r2 */
    sub r0, r0, r6      /* r0 = r0 - (7 * r3) */

    nop
    .end