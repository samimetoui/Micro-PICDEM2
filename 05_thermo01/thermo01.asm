;**************************************************************
; Programme : thermo01.asm
; Auteur: Sami Metoui
; le moteur est démarré lorsque le bouton sw2 est pressé
; Il est arrêté 2 sec après relachement du bouton. FOSC 125kHz
;**************************************************************

 list	p=16F917
#include <p16f917.inc>

#define SW2		PORTA,4
#define MTR		PORTD,7

org 0x00
	goto start

org 0x05

start

	bsf		STATUS,RP0		;bank 1

	movlw	0xFF			;PORTA en entrée
	movwf	TRISA			

	movlw	0x00			;PORTD en sortie
	movwf	TRISD
	
	movlw	0x10			;initialise l'oscillateur 125 kHz
	movwf	OSCCON			;

	movlw	0x07			;timer rate 1/256
	movwf	OPTION_REG

	bcf		STATUS,RP0		;retour bank 0

	clrf	PORTD			;clear portd
	clrf	PORTA			;clear porta

sw0
	btfsc	SW2				;test le bouton sw2
	goto	sw0				;lorsqu'il est pressé

	bsf		MTR				;démarre le moteur

sw1
	btfss	SW2				;test le bouton sw2
	goto	sw1				;lorsqu'il est relaché
	
	bcf		INTCON,T0IF		;clear overflow flag
	clrf	TMR0			;clear tmr0

tmr
	btfss	INTCON,T0IF		;boucle tant que overflow flag = 0
	goto	tmr				;tempo 2 sec

	bcf		MTR				;arrete le moteur
	goto 	sw0
END

	