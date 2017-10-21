	@fractionConstructor.s
	@constructs a fraction object
	@Calling sequence:
	@        r0 <- address of fraction variable
	@        bl  fractionConstr
	@ Returns 0

	@ Define my Raspberry Pi
	.cpu    cortex-a53
	.fpu    neon-fp-armv8
	.syntax unified         @ modern syntax

	@ Constants for assembler
        .include "fractionObject.s"  @ fraction object defs.

	.text
	.algin  2
	.global fractionConstructor
	.type 	fractionConstructor, %function

functionConstructor:
	stmfd 	sp! {fp, lr}
	add	fp, sp, 4
	mov	r1, 1
	str	r1, [r0, num]

	mov	r1, 2
	str	r1, [r0, den]

	mov	r0, 0
	ldmfd	sp!, {fp, lr}
	bx	lr
