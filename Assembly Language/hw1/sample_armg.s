	.cpu arm7tdmi
	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"sample.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 1 "sample.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%d\012\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.type	main, %function
main:
.LFB3:
	.loc 1 5 1
	.cfi_startproc
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 808
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	.cfi_def_cfa_offset 8
	.cfi_offset 11, -8
	.cfi_offset 14, -4
	add	fp, sp, #4
	.cfi_def_cfa 11, 4
	sub	sp, sp, #808
	.loc 1 8 8
	mov	r3, #0
	str	r3, [fp, #-12]
	.loc 1 10 10
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 10 4
	b	.L2
.L3:
	.loc 1 11 14 discriminator 3
	bl	rand
	mov	r2, r0
	.loc 1 11 12 discriminator 3
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	sub	r3, r3, #4
	add	r3, r3, fp
	str	r2, [r3, #-808]
	.loc 1 10 22 discriminator 3
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L2:
	.loc 1 10 15 discriminator 1
	ldr	r3, [fp, #-8]
	cmp	r3, #199
	ble	.L3
	.loc 1 13 10
	mov	r3, #0
	str	r3, [fp, #-8]
	.loc 1 13 4
	b	.L4
.L5:
	.loc 1 14 20 discriminator 3
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	sub	r3, r3, #4
	add	r3, r3, fp
	ldr	r3, [r3, #-808]
	.loc 1 14 11 discriminator 3
	ldr	r2, [fp, #-12]
	add	r3, r2, r3
	str	r3, [fp, #-12]
	.loc 1 13 23 discriminator 3
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L4:
	.loc 1 13 15 discriminator 1
	ldr	r3, [fp, #-8]
	cmp	r3, #100
	ble	.L5
	.loc 1 16 4
	ldr	r1, [fp, #-12]
	ldr	r0, .L7
	bl	printf
	.loc 1 18 11
	mov	r3, #0
	.loc 1 19 1
	mov	r0, r3
	sub	sp, fp, #4
	.cfi_def_cfa 13, 8
	@ sp needed
	pop	{fp, lr}
	.cfi_restore 14
	.cfi_restore 11
	.cfi_def_cfa_offset 0
	bx	lr
.L8:
	.align	2
.L7:
	.word	.LC0
	.cfi_endproc
.LFE3:
	.size	main, .-main
.Letext0:
	.file 2 "/opt/arm-cross-toolchain/cross-tool-ubuntu22/arm-none-eabi/include/stdio.h"
	.file 3 "/opt/arm-cross-toolchain/cross-tool-ubuntu22/arm-none-eabi/include/stdlib.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0xf0
	.2byte	0x5
	.byte	0x1
	.byte	0x4
	.4byte	.Ldebug_abbrev0
	.uleb128 0x3
	.4byte	.LASF11
	.byte	0x1d
	.4byte	.LASF12
	.4byte	.LASF13
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x1
	.byte	0x1
	.byte	0x6
	.4byte	.LASF0
	.uleb128 0x1
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1
	.uleb128 0x1
	.byte	0x2
	.byte	0x5
	.4byte	.LASF2
	.uleb128 0x1
	.byte	0x2
	.byte	0x7
	.4byte	.LASF3
	.uleb128 0x1
	.byte	0x4
	.byte	0x5
	.4byte	.LASF4
	.uleb128 0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF5
	.uleb128 0x1
	.byte	0x8
	.byte	0x5
	.4byte	.LASF6
	.uleb128 0x1
	.byte	0x8
	.byte	0x7
	.4byte	.LASF7
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF8
	.uleb128 0x1
	.byte	0x8
	.byte	0x4
	.4byte	.LASF9
	.uleb128 0x1
	.byte	0x1
	.byte	0x8
	.4byte	.LASF10
	.uleb128 0x5
	.4byte	0x73
	.uleb128 0x6
	.byte	0x4
	.4byte	0x7a
	.uleb128 0x7
	.4byte	.LASF14
	.byte	0x2
	.byte	0xce
	.byte	0x5
	.4byte	0x5e
	.4byte	0x9c
	.uleb128 0x8
	.4byte	0x7f
	.uleb128 0x9
	.byte	0
	.uleb128 0xa
	.4byte	.LASF15
	.byte	0x3
	.byte	0x90
	.byte	0x5
	.4byte	0x5e
	.uleb128 0xb
	.4byte	.LASF16
	.byte	0x1
	.byte	0x4
	.byte	0x5
	.4byte	0x5e
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xe7
	.uleb128 0x2
	.ascii	"i\000"
	.byte	0x8
	.4byte	0x5e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x2
	.ascii	"sum\000"
	.byte	0xb
	.4byte	0x5e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x2
	.ascii	"A\000"
	.byte	0x10
	.4byte	0xe7
	.uleb128 0x3
	.byte	0x91
	.sleb128 -816
	.byte	0
	.uleb128 0xc
	.4byte	0x5e
	.uleb128 0xd
	.4byte	0x65
	.byte	0xc7
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x21
	.sleb128 6
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF6:
	.ascii	"long long int\000"
.LASF8:
	.ascii	"unsigned int\000"
.LASF16:
	.ascii	"main\000"
.LASF11:
	.ascii	"GNU C17 12.3.0 -mcpu=arm7tdmi -marm -march=armv4t -"
	.ascii	"g\000"
.LASF5:
	.ascii	"long unsigned int\000"
.LASF7:
	.ascii	"long long unsigned int\000"
.LASF1:
	.ascii	"unsigned char\000"
.LASF10:
	.ascii	"char\000"
.LASF4:
	.ascii	"long int\000"
.LASF15:
	.ascii	"rand\000"
.LASF12:
	.ascii	"sample.c\000"
.LASF3:
	.ascii	"short unsigned int\000"
.LASF14:
	.ascii	"printf\000"
.LASF9:
	.ascii	"long double\000"
.LASF2:
	.ascii	"short int\000"
.LASF13:
	.ascii	"/home/angela/ARM/hw1\000"
.LASF0:
	.ascii	"signed char\000"
	.ident	"GCC: (GNU) 12.3.0"
