;************************************************************
; Programme : thermo02.asm
; Auteur: Sami Metoui
; le moteur est démarré lorsque le bouton sw2 est pressé
; Il est arrêté 2 sec après relachement du bouton. FOSC 4MHz
;************************************************************

 list	p=16F917
#include <p16f917.inc>

#define SW2		PORTA,4
#define MTR		PORTD,7

cblock	0x20
	CNT
endc

org 0x00
	goto start

org 0x05

start

	bsf		STATUS,RP0		;bank 1

	movlw	0xFF			;PORTA en entrée
	movwf	TRISA			

	movlw	0x00			;PORTD en sortie
	movwf	TRISD
	
	movlw	0x61			;initialise l'oscillateur 4 Mhz
	movwf	OSCCON			;

	movlw	0x07			;timer rate 1/256
	movwf	OPTION_REG

	bcf		STATUS,RP0		;retour bank 0
	
	clrf	PORTD			;clear portd
	clrf	PORTA			;clear porta

sw0
	btfsc	SW2				;test le bouton sw2 pressé
	goto	sw0				;

	bsf		MTR				;démarre le moteur

sw1
	btfss	SW2				;test le bouton sw2 relaché
	goto	sw1				;
	
	bcf		INTCON,T0IF		;clear overflow flag
	clrf	TMR0			;clear tmr0


	movlw	0x1E			;CNT=30
	movwf	CNT

count
	bcf		INTCON,T0IF		;clear overflow flag
	clrf	TMR0			;clear tmr0
tmr
	btfss	INTCON,T0IF		;Test overflow flag
	goto	tmr				;boucle 30 x 65ms = 2sec
	decfsz	CNT				;
	goto	count			;

	bcf		MTR				;arrete le moteur
	goto 	sw0
END

	