	@ helloWorld.s
	@Hello Ian program, in asl
	@ define my RaspberryPi

	.cpu 	cortex-a53
	.fpu    neon-fp-armv8
	.syntax unified         @ modern syntax

	@ Useful source code constant
	.equ    STDOUT,1

	@ Constant program data
	.section  .rodata
	.align  2
helloMsg:
	.asciz	 "Hello, Ian!\n"
	.equ    helloLngth,.-helloMsg

	@ Program code
	.text
	.align  2
	.global main
	.type   main, %function
main:
	stmfd   sp!, {fp, lr}   @ save caller's info
	add     fp, sp, 4       @ our frame pointer

	mov     r0, STDOUT      @ file number to write to
	ldr     r1, helloMsgAddr   @ pointer to message
	mov     r2, helloLngth  @ number of bytes to write
	bl      write           @ write the message

	mov     r0, 0           @ return 0 ;
	ldmfd   sp!, {fp, lr}   @ restore caller's info
	bx      lr              @ return

	.align  2
helloMsgAddr:
        .word   helloMsg
