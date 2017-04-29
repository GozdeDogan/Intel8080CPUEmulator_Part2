 ; 8080 assembler code
        .hexfile Sort.hex
        .binfile Sort.com
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


myarr: DW '012h, 034h, 053h, 02Ah, 05Bh, 06Fh, 033h, 021h, 07Ch, 0FFh, 0BAh, 0CBh, 0A1h, 01Ah, 03Bh, 0C3h, 04Ah, 05Dh, 062h, 0A3h, 0B1h, 05Ch, 0CCh, 0AAh, 034h',00AH,00H                ;array
;Decimal degerleri: 18, 52, 83, 42, 91, 111, 51, 33, 124, 255, 186, 203, 161, 17, 59, 195, 74, 94, 98, 163, 177, 92, 204, 170, 52
err: DW 'Error',00AH,00H                        ;null termineted string

size ds 2                                       ; arrayin boyutu

counter1 ds 2                                   ; i(iki dongu var distaki icin index)

counter2 ds 2                                   ; j(icteki dongu icin index)


begin:
    MVI A,26                                    ; arrayin size 26
    STA size                                    ; size=26
    
    MVI A,0                                     ; distaki dongunun index'i
    STA counter1                                ; counter1=0
    
    LXI B,myarr                                 ; B'ye arrayin baslangic adresi verildi
    
LOOP1:
    MVI A,0                                     ; distaki dongunun index'i
    STA counter2                                ; counter2=0
    
    LDAX B                                      ; A=myarr[0]
    MOV L,A                                     ; L=arrayde kiyaslama yapilacak eleman
    
    LXI D,myarr                                 ; D'ye arrayin baslangic adresi verildi
    
LOOP2:
    LDAX D                                      ; A=kiyaslanacak diger eleman
    CMP L                                       ; A-L < 0 ise swap var, >0 ise swap yapilmaz
    JM SWAP
    
Continue:        
    INX D                                       ; dw ile yer aldik yani her sayi 2 byte'lik yerde, 
    INX D                                       ; bu nedenle 2 defa artt'rma yapilir 
    
    MVI A, counter2                             ; counter2 A register'ina yazildi
    INR A                                       ; A++
    STA counter2                                ; A counter2'ye yazildi, counter2++ oldu
    
    MVI A, size                                 ; Aya size yazildi, counter2 ile kiyaslamak icin
    CPI counter2                                ; A-counter2 > 0 ise daha elemanlarin tamami kiyaslanmadi
    JP LOOP2                                    ; pozitif ise LOOP2 devam eder
    
    INX B                                   ; dw ile yer aldik yani her sayi 2 byte'lik yerde, 
    INX B                                   ; bu nedenle 2 defa artt'rma yapilir 
    
    MVI A, counter1                         ; counter1 A register'ina yazildi
    INR A                                   ; A++
    STA counter1                            ; A counter1'ye yazildi, counter1++ oldu
    
    MVI A, size                             ; Aya size yazildi, counter1 ile kiyaslamak icin
    CPI counter1                            ; A-counter1 > 0 ise daha elemanlarin tamami kiyaslanmadi
    JP LOOP1
    
    LXI B,myarr                             ; siralanan arrayi ekrana yazdiriyoruz
    MVI A,PRINT_STR
    call GTU_OS
    
    hlt		                                ; end program
    
    
SWAP:
    STAX B                                  ; Dnin gosterdigi adrese L yazildi
    MOV A,L
    STAX D                                  ; B'nin gosterdigi yere H yazildi
    JMP Continue                            ; subroutine cagirildigi yerden devam edecek
    
    hlt                                     ; end program
    
    
