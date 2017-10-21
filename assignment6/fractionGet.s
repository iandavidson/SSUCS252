	@fractionGet.s
	@ Gets values for a fraction from keyboard
	@ Calling sequence:
	@        r0 <- address of the struct
	@        bl  getStruct
	@ Returns 0
	@ Bob Plantz - 6 August 2016

	@ Define my Raspberry Pi
	.cpu    cortex-a53
	.fpu    neon-fp-armv8
	.syntax unified         @ modern syntax

	@ Constants for assembler
	.include "fractionObject.s"  @ fraction object defs.

	@ Constant program data
	.section .rodata
	.align  2
numPrompt:
	.asciz        "  Enter numerator: "
denPrompt:
	.asciz        "Enter denominator: "

	@ The code
	.text
	.align  2
	.global fractionGet
	.type   fractionGet, %function

fractionGet:
	stmfd 	sp! {fp, lr, r4}
	add 	fp, sp, 8

	mov	r4, r0

	ldr	r0, numPromptAd
	bl	writeStr
	bl	getDecInt
	str	r0, [r4, num]

	ldr	r0, denPromptAd
	bl	writeStr
	bl	getDecInt
        str	r0, [r4, den]

	mov	r0, 0
	ldmfd	sp!, {r4, fp, lr}
	bx	lr

	.align 2
	
numPromptAd:
	.word	numPrompt

denPromptAd:
	.word	denPrompt
