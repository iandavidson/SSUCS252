	@ putChar.s
	@ Writes a character to the standard output (screen).
	@ Calling sequence:
	@       r0 <- the character
	@       bl    putChar

	.cpu    cortex-a53
	.fpu    neon-fp-armv8
	.syntax unified         @ modern syntax

	@ Constants for assembler
	.equ    STDOUT,1
	.equ    strSpace,-5     @ string space
	.equ    locals,8       @ space for local var

	@ The code
	.text
	.align  2
	.global putChar
        .type   putChar, %function

putChar:
	stmfd	sp!, {fp, lr}
	add 	fp, sp, 4
	sub	sp, sp, locals

	strb	r0, [fp, strSpace]
	mov	r0, STDOUT
	add	r1, fp, strSpace
	mov	r2, 1
	bl	write

	mov	r0, 0
	add	sp, sp, locals
	ldmfd	sp!, {fp, lr}
	bx	lr
