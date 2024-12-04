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

/* --- files --- */
.input_filename_addr:
	.ascii "input.txt\0"
.output_filename_addr:
    .ascii "output.txt\0"
.read_buffer:
	.space 4
.write_buffer:
	.space 4

/* ========================= */
/*       TEXT section        */
/* ========================= */
	.section .text
	.global main
	.type main,%function
.input_filename:
	.word .input_filename_addr
.output_filename:
    .word .output_filename_addr
.open_param:
	.word .input_filename_addr
	.word 0x2
	.word 0x9
.open_output_param:
    .word .output_filename_addr
    .word 0x4
    .word 0xA
.flen_param:
	.space 4
.read_param:
	.space 4
	.word .read_buffer
	.space 4
.write_param:
	.space 4   /* file descriptor */
	.word .write_buffer
	.space 4   /* length of the string */
.close_param:
	.space 4
main:
	mov ip, sp
	push {fp, ip, lr, pc}
	sub fp, ip, #4

    /* open a file */
	mov r0, #SWI_Open
	adr r1, .open_param
	swi AngelSWI
	mov r2, r0                /* r2 is file descriptor */

    MOV r0, #SWI_Open
    ADR r1, .open_output_param
    SWI AngelSWI
    MOV r7, r0  /* r7 is output_filename */

	/* get length of a file */
	mov r0, #SWI_FLen
	adr r1, .flen_param
	str r2, [r1, #0]
	swi AngelSWI
	mov r6, r0

loop:      
	cmp r6, #0
    BEQ add_end

    /* read from a file */
	adr r1, .read_param
	MOV r8, #0
	STR r8, [r1, #0]
	STR r8, [r1, #4]
	STR r8, [r1, #8]

	str r2, [r1, #0]          /* store file descriptor */

	ldr r5, [r1, #4]          /* r5 is the address of readbuffer */

	mov r3, #1
	str r3, [r1, #8]          /* store the length of the string */

	mov r0, #SWI_Read
	swi AngelSWI

	ldrb r4, [r5, #0]         /* r4 is the read data */

CMP r4, #'a'
    BLT write_step
    CMP r4, #'z'
    BGT write_step
    SUB r4, r4, #32  /* 97 - 65 */

write_step:
    ADR r1, .write_param

    MOV r9, #0
    STR r9, [r1, #0]
    STR r9, [r1, #4]
    STR r9, [r1, #8]

    STR r7, [r1, #0]
    STRB r4, [r1, #4]
    MOV r8, #1
    STR r8, [r1, #8]

    MOV r0, #SWI_Write
    SWI AngelSWI

	sub r6, r6, #1
	bne loop

add_end:
    MOV r4, #'\n'
    ADR r1, .write_param
    STR r7, [r1, #0]
    STRB r4, [r1, #4]
    STR r8, [r1, #8]

    MOV r0, #SWI_Write
    SWI AngelSWI

close_files:
	adr r1, .close_param
	str r2, [r1, #0]

	mov r0, #SWI_Close
	swi AngelSWI

    ADR r1, .close_param
    STR r7, [r1, #0]
    MOV r0, #SWI_Close
    SWI AngelSWI

    sub sp, fp, #12
    ldm sp, {fp, sp, lr}
    bx lr

