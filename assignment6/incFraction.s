	@incFraction.s
	@Gets values from user for a fraction, adds one to the frac.
	

	@ Define my Raspberry Pi
	.cpu    cortex-a53
	.fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

	@constants
	.equ	x,-8
	.equ	locals,12 	space for fraction

	.text
	.align 	2
	.global main
	.type 	main, %function

main:
	stmfd 	sp! {fp, lr}
	add	fp, sp, 4
	sub	sp, sp, locals

	@make instance
	add 	r0, fp, x
	bl	fractionConstructor

	@get user input
	add	r0 fp, x
	bl	getFraction

	@add 1
	add	r0, fp, x
	mov	r1, 1
	bl 	fractionAdd

	@call display function
	add	r0, fp, x
	bl	fractionDisplay
	
	
	@restore
	mov	r0, 0
	add	sp, sp, locals
	ldmfd	sp!, {fp, lr}
	bx	lr
