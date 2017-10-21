@ echoFourChars.s
@ echos 4 characters entered by user then displays them
@ define my Raspberrypi

	.cpu 	cortex-a53
	.fpu 	neon-fp-armv8
	.syntax unified 	@modern syntax

@ source code constants
	.equ	STDIN,0
	.equ 	STDOUT,1	@standard error would sit in 2 but is not used/included
	.equ	char1,-8
	.equ	char2,-7
	.equ	char3,-6
	.equ	char4,-5
	.equ	nChars,4
	.equ 	local,8

@ program data constants
	.section	.rodata
	.align	2

promptMsg:
	.asciz 	"Enter only four chars: "
	.equ 	promptLngth,.-promptMsg

responseMsg:
	.asciz	"You entered: "
	.equ	responseLngth,.-responseMsg

@program code
	.text
	.align	2
	.global	main
	.type	main, %function

main:
	stmfd	sp!, {fp, lr}	@ save callers info
	add 	fp, sp, 4	@ sets up framePtr
	sub	sp, sp, local	@ allocate memory for local var

	mov 	r0, STDOUT 	@ prompt user for input
	ldr	r1, promptMsgAddr
	mov	r2, promptLngth
	bl	write

	mov	r0, STDIN	@ STDIN gets input from keyboard
	add	r1, fp, char1	@ address of first char
	mov 	r2, 1		@ one char
	bl 	read

	mov     r0, STDIN       @ from keyboard
	add     r1, fp, char2   @ address of 2nd char
	mov     r2, 1           @ one char
	bl      read

	mov     r0, STDIN       @ from keyboard
	add     r1, fp, char3   @ address of 3rd char
	mov     r2, 1           @ one char
	bl      read

	mov     r0, STDIN       @ from keyboard
	add     r1, fp, char4   @ address of 4th char
	mov     r2, 1           @ one char
	bl      read

	mov     r0, STDOUT      @ nice message for user
	ldr     r1, responseMsgAddr
	mov     r2, responseLngth
	bl      write		

	mov     r0, STDOUT      @ echo user's characters
	add     r1, fp, char1   @ address of 1st char
	mov     r2, nChars      @ all four characters
	bl      write

	mov     r0, 0           @ return 0 ;
	add     sp, sp, local   @ deallocate local var
	ldmfd   sp!, {fp, lr}   @ restore caller's info
	bx      lr              @ return

@ Addresses of messages
	.align  2
promptMsgAddr:
	.word   promptMsg
responseMsgAddr:
        .word   responseMsg
