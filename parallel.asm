	; OS call list
PRINT_B		equ 1
PRINT_MEM	equ 2
READ_B		equ 3
READ_MEM	equ 4
PRINT_STR	equ 5
READ_STR	equ 6
FORK        equ 7
EXEC        equ 8
WAITPID     equ 9



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
    MVI A, FORK	    ; store the OS call code to A
	call GTU_OS	        ; call the OS
	;MVI A, EXEC	    ; store the OS call code to A
	;call GTU_OS	        ; call the OS
	;MVI A, WAITPID	    ; store the OS call code to A
	;call GTU_OS	        ; call the OS
	
	MVI A, FORK	    ; store the OS call code to A
	call GTU_OS	        ; call the OS
	;MVI A, EXEC	    ; store the OS call code to A
	;call GTU_OS	        ; call the OS
	;MVI A, WAITPID	    ; store the OS call code to A
	;call GTU_OS
	
	MVI A, FORK	    ; store the OS call code to A
	call GTU_OS	        ; call the OS
	;MVI A, EXEC	    ; store the OS call code to A
	;call GTU_OS	        ; call the OS
	;MVI A, WAITPID	    ; store the OS call code to A
	;call GTU_OS
	
	hlt		; end program
