	@ numbers.s
	@ Displays numerals, 0 - 9
	@ Ian Davidson

	@ Define my Raspberry Pi
	.cpu    cortex-a53
	.fpu    neon-fp-armv8
	.syntax unified         @ modern syntax

	@ Useful source code constants
	.equ    STDOUT,1
	.equ    numeral,-9
	.equ    local,4

	@ Constant program data
	.section .rodata
	.align  2

	@ main labels
	.text
	.align  2
	.global main
	.type   main, %function
main:
	stmfd   sp!, {r4, fp, lr}  @ save caller's info
	add     fp, sp, 8       @ our frame pointer
	sub     sp, sp, local   @ allocate memory for local var

	mov     r4, '0          @ numeral 0
loop:
	strb    r4, [fp, numeral]  @ char must be
	@ in memory for write
	mov     r0, STDOUT      @ write to screen
	add     r1, fp, numeral @ address of numeral
	mov     r2, 1           @ one byte
	bl      write

	add     r4, r4, 1       @ next numeral
	cmp     r4, '9          @ all numerals?
	ble     loop            @ no, keep going

	mov     r0, 0           @ yes, return 0 ;
	add     sp, sp, local   @ deallocate local var
	ldmfd   sp!, {r4, fp, lr}  @ restore caller's info
	bx      lr              @ return
	
