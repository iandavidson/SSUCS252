@fractionAdd.s
@ Adds an integer to a fraction
@ Assumes (int X den) + num fits into 32 bits.
@ Calling sequence:
@        r0 <- address of the object
@        r1 <- integer to add
@        bl  fractionAdd
@ returns 0


	@ Define my Raspberry Pi
	.cpu    cortex-a53
	.fpu    neon-fp-armv8
	.syntax unified         @ modern syntax

	@ Constants for assembler
	.include "fractionObject.s"  @ fraction object defs.

	@ The code
	.text
	.align  2
	.global fractionAdd
	.type	fractionAdd, %function

fractionAdd:
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, 8

	mov	r4, r0
	ldr	r0, [r4, den]
	mul	r2, r1, r0	@this multiplies the denominator by the int ->r2
	ldr	r0, [r4, num]
	add	r2, r2, r0
	str	r2, [r4, num]	@saves new numerator back to orig addr

	mov	r0, 0
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
