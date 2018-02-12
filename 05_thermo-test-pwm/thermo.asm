;************************************************************************
; Programme thermo.asm
; Auteur: Sami Metoui
; programme démarre le moteur avec un rapport cyclique nul et l'augmente
; de 1 dans une boucle infinie. tempo de 65 ms à chaque incrémentation.
;************************************************************************

 list	p=16F917
#include <p16f917.inc>
#include "lcd.inc"

#define SW2		PORTA,4

VAR udata

CNT res 1					;compteur timer


RST CODE 0x0
	pagesel start
	goto start

	CODE

start

	;***************************************************
	; Initialisation
	;***************************************************

	clrf	PORTA				;

	bsf		STATUS,RP0			;bank 1
	
	bcf 	TRISD,2				;RD2 as output
	
	; Initialise l'oscillateur
	
	movlw	0x61				;initialise l'oscillateur 4 Mhz 
	movwf	OSCCON				;

	movlw 	0x3F 				; 15,6 kHz PWM
	movwf 	PR2

	movlw	0x07				;init le timer 0 timer rate 1/256
	movwf	OPTION_REG			;

	bcf		STATUS,RP0			;retour bank 0

	clrf	PORTD				;clear portd
	clrf	PORTA				;clear porta
	
	clrf 	CCPR2L

	movlw 	0xC 				; Select pwm mode
	movwf 	CCP2CON

	bsf 	T2CON,TMR2ON 		; active timer 2

	;;;;;;;;;;;;;; Set duty cycle for 316 RPM ;;;;;;;;;;;;;

	movlw 	0x0F 				; Turn on PWM, bit # 5,4 = 0,0
	iorwf 	CCP2CON,f

	movf 	0,W					;CNT = 0
	movwf 	CNT

cnt
	movf 	CNT,W				;incrémente 
	addlw 	1					;le rapport cyclique
	movwf 	CNT					;dans CNT
	movwf 	CCPR2L				;dans CCPR2L

	call 	Tempo				;Tempo 65ms
	goto 	cnt
 
;----------------------------------------------
;Temporisation 65ms
;----------------------------------------------
Tempo

	bcf		INTCON,T0IF		;clear timer overflow flag
	clrf	TMR0			;clear timer

Tempo_tmr

	btfss	INTCON,T0IF		;test overflow tmr
	goto	Tempo_tmr		;

	return

 END