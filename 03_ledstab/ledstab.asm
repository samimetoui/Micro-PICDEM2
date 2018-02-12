;******************************************************************
; Programme: ledstab.asm
; Programme qui fait clignoter une ou plusieurs leds sur le port B
; en fonction de l'état des switches sur le port A en utilisant
; l'adressage indirecte
;******************************************************************

 list	p=16F628
#include <p16f628.inc>

#define SW0		PORTA,0
#define SW1		PORTA,1
#define SW2		PORTA,2
#define SW3		PORTA,3

 cblock	0x20
  tab : 4
  cnt
 endc

 org 0x00
	goto start

 org 0x05

start
	clrf	PORTA			;clear le port A
	clrf	PORTB			;clear le port B
	
	movlw	0x07			;turn comparators off and
	movwf	CMCON

	bsf		STATUS,RP0		;bank 1

	movlw	0xFF			;PORTA en entrée
	movwf	TRISA			

	movlw	0x00			;PORTB en sortie
	movwf	TRISB

	bcf		STATUS,RP0		;retour bank 0
	
	movlw	0				;


;initab
	;movlw	tab				;tab dans le W
	;movwf	FSR				;FSR contient l'adresse de tab

	;movlw	4				;cnt contient 4
	;movwf	cnt				;

;next
	;clrf	INDF			;permet
	;incf	FSR				;de clearer tab		;btfss	FSR,3
	;decfsz	cnt				;
	;goto	next			;

	movlw	0x20			;tab[0] contient 00100000b
	movwf	tab

	movlw	0xc0			;tab[1] contient 11000000b
	movwf	tab+1

	movlw	0x80			;tab[2] contient 10000000b
	movwf	tab+2

	movlw	0x60			;tab[3] contient 01100000b
	movwf	tab+3
	
	movlw	0


main
	xorwf	PORTB,f			;toggle le port B avec W
	btfsc	SW0				;sw0 à 1
	goto	sw0
	btfsc	SW1				;sw1 à 1
	goto	sw1
	btfsc	SW2				;sw2 à 1
	goto	sw2
	btfsc	SW3				;sw3 à 1
	goto	sw3
	
	movlw	0
	
	goto	main

sw0
	movlw	tab				;tab dans le W
	movwf	FSR				;FSR contient l'adresse de tab
	movfw	INDF			;tab[0] dans W
	goto	main
sw1
	movlw	tab+1			;tab+1 dans le W
	movwf	FSR				;FSR contient l'adresse de tab+1
	movfw	INDF			;tab[1] dans W
	goto	main
sw2
	movlw	tab+2			;tab+2 dans le W
	movwf	FSR				;FSR contient l'adresse de tab+2
	movfw	INDF			;tab[2] dans W
	goto	main
sw3
	movlw	tab+3			;tab+3 dans le W
	movwf	FSR				;FSR contient l'adresse de tab+3
	movfw	INDF			;tab[3] dans W
	goto	main


	END