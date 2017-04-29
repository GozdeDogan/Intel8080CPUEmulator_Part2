 ; 8080 assembler code
        .hexfile test.hex
        .binfile test.com
        ; try "hex" for downloading in hex format
        .download bin  
        .objcopy gobjcopy
        .postbuild echo "OK!"
        ;.nodump

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
GTU_OS:	PUSH D
	push D
	push H
	push psw
	nop	; This is where we run our OS in C++, see the CPU8080::isSystemCall()
		; function for the detail.
	pop psw
	pop h
	pop d
	pop D
	ret
	; ---------------------------------------------------------------

begin:
    ;testing READ_B
    MVI A,READ_B	    ; store the OS call code to A, kullanicidan integer istendi
	call GTU_OS	        ; call the OS
	
	;testing PRINT_B
	MVI A,PRINT_B      ; KEYBOARD'DAN GELEN DEGER
	call GTU_OS
	
	;testing READ_MEM
	MVI A,READ_MEM
	call GTU_OS
	
	;testing PRINT_MEM
	MVI A,PRINT_MEM
	call GTU_OS
	
	;testing READ_STR
	MVI A,READ_STR
	call GTU_OS
	
	;testing PRINT_STR
	MVI A,PRINT_STR
	call GTU_OS
	
    hlt		            ; end program
