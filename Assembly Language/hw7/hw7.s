.set SWI_Open, 0x1
.set SWI_Close, 0x2
.set SWI_Write, 0x5
.set SWI_Read, 0x6
.set SWI_FLen, 0xC
.set AngelSWI, 0x123456

/* ========================= */
/*       DATA section        */
/* ========================= */
	.data
	.align 4

/* --- file name --- */
.input_filename:
    .ascii "input.txt\0"
.output_filename:
    .ascii "output.txt\0"
.read_buffer:
    .space 4  /* read 1 word one time */

/* ========================= */
/*       TEXT section        */
/* ========================= */
	.section .text
	.global main
	.type main,%function

.open_input_param:
    .word .input_filename
    .word 0x2
    .word 0x9
.open_output_param:
    .word .output_filename
    .word 0x4
    .word 0xA
.flen_param:
	.space 4
.read_param:
    .space 4
    .word .read_buffer
    .space 4
.write_param:
    .space 4
    .space 4
    .space 4

main:
    mov ip, sp
	push {fp, ip, lr, pc}
	sub fp, ip, #4

    /* open files */
    MOV r0, #SWI_Open
    ADR r1, .open_input_param
    SWI AngelSWI
    MOV r2, r0

    MOV r0, #SWI_Open
    ADR r1, .open_output_param
    SWI AngelSWI
    MOV r3, r0

    /* get length of input.txt */
    MOV r0, #SWI_FLen
    ADR r1, .flen_param
    STR r2, [r1, #0]
    SWI AngelSWI
    MOV r4, r0

    /* read from inpui.txt */
    ADR r1, .read_param
    STR r2, [r1, #0]
    LDR r5, [r1, #4]
    MOV r6, #1
    STR r6, [r1, #8]

read_loop:
    CMP r4, #1

    MOV r0, #SWI_Read
    SWI AngelSWI
    LDRB r7, [r5, #0]  /* r7 is the read data */

    CMP r7, #'a'  /* if the word < a, 97 */
    BLT skip_convert
    CMP r7, #'z'  /* if the word > z, 122 */
    BGT skip_convert
    SUB r7, r7, #32  /* a - A(65) = 32 */
    B write_step

skip_convert:
    B write_step

write_step:
    MOV r0, #SWI_Write
    ADR r1, .write_param
    STR r3, [r1, #0]

    STR r7, [r1, #4]  /* r7 task done */

    MOV r7, #4  /* new r7 */
    STR r7, [r1, #8]

    SWI AngelSWI

    SUB r4, r4, #1
    BNE read_loop
/* requirement done */

close_files:
    MOV r0, #SWI_Close
    MOV r1, r2
    SWI AngelSWI

    MOV r1, r3
    SWI AngelSWI

    /* end of program */
    sub sp, fp, #12
    ldm sp, {fp, sp, lr}
    bx lr
