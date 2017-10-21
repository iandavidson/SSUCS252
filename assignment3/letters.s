	@ letters.s
	@ Displays the upper case alphabet, A - Z
	@ Ian Davidson

	@ Define my Raspberry Pi
	.cpu    cortex-a53
	.fpu    neon-fp-armv8
	.syntax unified         @ modern syntax

	@ Useful source code constants
	.equ    STDOUT,1
	.equ    alpha,9
	.equ    local,4

	@ Constant program data
	.section .rodata
	.align  2
	@ Main labels
	.text
	.align  2
	.global main
	.type   main, %function
main:
	stmfd   sp!, {r4, fp, lr}  @ save for caller
	add     fp, sp, 8       @ our frame pointer
	sub     sp, sp, local   @ allocate memory for local var

	mov     r4, 'A          @ beginning of alphabet
loop:
	strb    r4, [fp, alpha] @ char must be
	@ in memory for write
	mov     r0, STDOUT      @ write to screen
	add     r1, fp, alpha   @ address of alpha
	mov     r2, 1           @ one byte
	bl      write

	add     r4, r4, 1       @ next alpha
	cmp     r4, 'Z          @ whole alphabet?
	ble     loop            @ no, keep going

	mov     r0, 0           @ yes, return 0 ;
	add     sp, sp, local   @ deallocate local var
	ldmfd   sp!, {r4, fp, lr}  @ restore caller's info
	        bx      lr              @ return
