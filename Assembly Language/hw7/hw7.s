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
	MOV ip, sp
	PUSH {fp, ip, lr, pc}
	SUB fp, ip, #4

    /* open a file */
	MOV r0, #SWI_Open
	ADR r1, .open_param
	SWI AngelSWI
	MOV r2, r0                /* r2 is file descriptor */

    MOV r0, #SWI_Open
    ADR r1, .open_output_param
    SWI AngelSWI
    MOV r7, r0  /* r7 is output_filename */

	/* get length of a file */
	MOV r0, #SWI_FLen
	ADR r1, .flen_param
	STR r2, [r1, #0]
	SWI AngelSWI
	MOV r6, r0

loop:      
    /* read from a file */
	ADR r1, .read_param
	MOV r8, #0
	STR r8, [r1, #0]
	STR r8, [r1, #4]
	STR r8, [r1, #8]

	STR r2, [r1, #0]  /* r2: input file descriptor */

	LDR r5, [r1, #4]  /* r5: address of read_buffer */

	MOV r3, #1
	STR r3, [r1, #8]  /* r3: length of read data */

	MOV r0, #SWI_Read
	SWI AngelSWI

	LDRB r4, [r5, #0]  /* r4 is read data */

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
    STRB r4, [r10]  /* r4 is data, r10 is new address point to r4 */
	STR r10, [r1, #4]
    MOV r8, #1
    STR r8, [r1, #8]

    MOV r0, #SWI_Write
    SWI AngelSWI

	SUB r6, r6, #1
	CMP r6, #0
	BNE loop

close_files:
	ADR r1, .close_param
	STR r2, [r1, #0]

	MOV r0, #SWI_Close
	SWI AngelSWI

    ADR r1, .close_param
    STR r7, [r1, #0]
    MOV r0, #SWI_Close
    SWI AngelSWI

    SUB sp, fp, #12
    LDM sp, {fp, sp, lr}
    BX lr

