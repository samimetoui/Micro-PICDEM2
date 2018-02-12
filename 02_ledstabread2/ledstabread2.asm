;*****************************************************************
; Programme: ledstabread2.asm
; Programme qui fait clignoter une ou plusieurs leds sur le port B
; en fonction de l'état des switches sur le port A en utilisant
; une table read 
;*****************************************************************

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
	clrf	PORTA				;clear le port A
	
	movlw	0x07				;turn comparators off and
	movwf	CMCON
	
	bsf		STATUS,RP0			;bank 1
	
	movlw	0xFF				;PORTA en entrée
	movwf	TRISA			
	
	movlw	0x00				;PORTB en sortie
	movwf	TRISB
	
	bcf		STATUS,RP0			;retour bank 0
	
	movlw	0					;clear la variable LED
	movwf	LED
	
	clrf	PORTB				;clear le portB
	
	movlw	0
	
main
	
	xorwf	PORTB				;toggle le port B avec W
	btfsc	SW0					;sw0 à 1
	goto	sw0
	btfsc	SW1					;sw1 à 1
	goto	sw1
	btfsc	SW2					;sw2 à 1
	goto	sw2
	btfsc	SW3					;sw3 à 1
	goto	sw3
	
	movlw	0
	
	goto	main

sw0
	movlw	HIGH Table			;charge les 8 bits de poids fort 
	movwf	PCLATH				;de l'adresse de Table dans PCLATH
	movlw	0
	call	Table				;toggle RB5
	movwf	LED
	goto	main
sw1
	movlw	HIGH Table			;charge les 8 bits de poids fort 
	movwf	PCLATH				;de l'adresse de Table dans PCLATH
	movlw	1
	call	Table				;toggle RB6 et RB7
	movwf	LED
	goto	main
sw2
	movlw	HIGH Table			;charge les 8 bits de poids fort 
	movwf	PCLATH				;de l'adresse de Table dans PCLATH
	movlw	2
	call	Table				;toggle RB7
	movwf	LED
	goto	main
sw3
	movlw	HIGH Table			;charge les 8 bits de poids fort 
	movwf	PCLATH				;de l'adresse de Table dans PCLATH
	movlw	3
	call	Table				;toggle RB5 et RB6
	movwf	LED
	goto	main

Table
addwf	PCL,F					;add offset to PCF

retlw	b'00100000'
retlw	b'11000000'
retlw	b'10000000'
retlw	b'01100000'

	END