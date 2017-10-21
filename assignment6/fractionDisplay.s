	@ fractionDisplay.s
	@ Displays a fraction struct on screen
	@ Calls with:
	@        r0 <- address of the struct
	@        bl  fractionDisplay
	@ returns 0


	@ Define my Raspberry Pi
	.cpu    cortex-a53
	.fpu    neon-fp-armv8
	.syntax unified   

	@ Constants for assembler
	.include "fractionObject.s"  @ fraction object defs.

	@ The code
	.text
	.align  2
	.global fractionDisplay
	.type   fractionDisplay, %function
fractionDisplay:
	stmfd   sp!, {r4, fp, lr}
	add     fp, sp, 8      

	mov     r4, r0         

	ldr     r0, [r4, num]  
	bl      putDecInt
	mov     r0, '/         
	bl      putChar
	ldr     r0, [r4, den]  
	bl      putDecInt
	bl      newLine

	mov     r0, 0  
	ldmfd   sp!, {r4, fp, lr} 
        bx      lr
