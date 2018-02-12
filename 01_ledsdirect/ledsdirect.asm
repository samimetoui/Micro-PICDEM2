;******************************************************************
; Programme: Ledsdirect.asm
; Programme qui fait clignoter une ou plusieurs leds spécifiques
; sur le port B en fonction de l'état de switches reliés au port A 
;******************************************************************

list	p=16F628
#include <p16f628.inc>

#define SW0		PORTA,0
#define SW1		PORTA,1
#define SW2		PORTA,2
#define SW3		PORTA,3

cblock	0x20
	LED	
endc

org 0x00
	goto start

org 0x05

start
	clrf	PORTA			;clear le port A
	clrf	PORTB			;clear le portB
	
	movlw	0x07			;éteint les comparateurs
	movwf	CMCON

	bsf		STATUS,RP0		;bank 1
	
	bsf		OPTION_REG,7	; pas de pull-up sur le port B
	
	movlw	0xFF			;PORTA en entrée
	movwf	TRISA			
	
	movlw	0x00			;PORTB en sortie
	movwf	TRISB
	
	bcf		STATUS,RP0		;retour bank 0
	
	movlw	0				;clear la variable LED
	movwf	LED
	
	

	movlw	0				;
		
main

	xorwf	PORTB			;toggle le port B avec W
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
	movlw	b'00100000'		;toggle RB5
	movwf	LED
	goto	main
sw1
	movlw	b'11000000'		;toggle RB6 et RB7
	movwf	LED
	goto	main
sw2
	movlw	b'10000000'		;toggle RB7
	movwf	LED
	goto	main
sw3
	movlw	b'01100000'		;toggle RB5 et RB6
	movwf	LED
	goto	main

	END