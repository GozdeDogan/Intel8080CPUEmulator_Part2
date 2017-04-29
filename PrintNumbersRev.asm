	; OS call list
PRINT_B		equ 1
PRINT_MEM	equ 2
READ_B		equ 3
READ_MEM	equ 4
PRINT_STR	equ 5
READ_STR	equ 6



	; Position for stack pointer
stack   equ 0F000h

	org 000H
	jmp begin

	; Start of our Operating System
GTU_OS:	PUSH B
	push D
	push H
	push psw
	nop	; This is where we run our OS in C++, see the CPU8080::isSystemCall()
		; function for the detail.
	pop psw
	pop h
	pop d
	pop B
	ret
	; ---------------------------------------------------------------


begin:
    MVI C, 51
    MVI B, 100
LOOP:
    MVI A, PRINT_B	    ; store the OS call code to A
	call GTU_OS	        ; call the OS
	DCR B               ; B = B-1
	DCR C               ; C--
	JNZ LOOP            ; C!=0 branch loop
	
	hlt		; end program
