 ; 8080 assembler code
        .hexfile Search.hex
        .binfile Search.com
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


            ;012h, 034h, 053h, 02Ah, 05Bh, 06Fh, 033h, 021h, 07Ch, 0FFh, 0BAh, 0CBh, 0A1h, 01Ah, 03Bh, 0C3h, 04Ah, 05Dh, 062h, 0A3h, 0B1h, 05Ch, 0CCh, 0AAh, 034h
            ;18, 52, 83, 42, 91, 111, 51, 33, 124, 255, 186, 203, 161, 16, 59, 195, 74, 93, 98, 163, 177, 92, 204, 170, 52
            ;12H, 34H, 53H, 2AH, 5BH, 6FH, 33H, 21H, 7CH, FFH, BAH, CBH, A1H, 1AH, 3BH, C3H, 4AH, 5DH, 62H, A3H, B1H, 5CH, CCH, AAH, 34H
            ;18, 52, 83, 42, 91, 111, 51, 33, 124, 255, 186, 203, 161, 16, 59, 195, 74, 93, 98, 163, 177, 92, 204, 170, 52
            ;12, 34, 53, 2A, 5B, 6F, 33, 21, 7C, FF, BA, CB, A1, 1A, 3B, C3, 4A, 5D, 62, A3, B1, 5C, CC, AA, 34



myarr: DB 012h, 034h, 053h, 02Ah, 05Bh, 06Fh, 033h, 021h, 07Ch, 0FFh, 0BAh, 0CBh, 0A1h, 01Ah, 03Bh, 0C3h, 04Ah, 05Dh, 062h, 0A3h, 0B1h, 05Ch, 0CCh, 0AAh, 034h      ;array
err: DW 'Error',00AH,00H  ;null termineted string


begin:
    MVI D,26           ; Size olarak tutuldu, 26 sayi var
    MVI H,0            ; index
    
    MVI A,READ_B	    ; store the OS call code to A, kullanicidan integer istendi
	call GTU_OS	        ; call the OS
	
	MVI A,PRINT_B      ; KEYBOARD'DAN GELEN DEGER
	call GTU_OS
	
	MOV E,B            ; E=searchNumber
    LXI B,myarr        ; arrayin baslangic adresi = BC

LOOP:
    LDAX B              ; A=myArr[0]
    CMP E               ; A-E; 0 ise devam eder, 0 degilse Continue label'ina atlar
    JNZ Continue        ; A-E 0 ise , B'ye bulundugu index yazilir ve B de ekrana yazilir
    
    MOV B, H            ; B=H
    MVI A, PRINT_B	    ; store the OS call code to A  INDEX
    call GTU_OS	        ; call the OS 
    hlt                 ; end program
    
    
Continue:
    INX B               ; arrayin 1 sonraki elemaninin adresine gitmek icin
    INR H               ; index 1 artti
    DCR D               ; size 1 azaldi
    JNZ LOOP	        ; size != 0 ise LOOP'a gider, size == 0 ise EXIT'e gider 
        

    LXI B,err
    MVI A,PRINT_STR
    call GTU_OS
    hlt		            ; end program
