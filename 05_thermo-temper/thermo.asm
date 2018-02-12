;************************************************************************
;programme thermo.asm
;Auteur: Sami Metoui
;Le moteur est d�marr� lorsque la temp�rature de consigne est d�pass�e
;Le moteur s'arr�te 2 secondes apres que la temp�rature soit d�cendue 
;en dessous de la consigne. 
;************************************************************************

 list	p=16F917
#include <p16f917.inc>
#include "lcd.inc"

#define SW2		PORTA,4
#define MTR		PORTD,7

VAR udata

CNT res 1					;compteur
TMP res 2					;temp�rature
CNS res 2					;consigne

RST CODE 0x0
	pagesel start
	goto start

	CODE

start

	clrf	PORTA			;

	bsf		STATUS,RP0		;bank 1

	movlw	0xFF			;PORTA en entr�e
	movwf	TRISA			;

	movlw	0x00			;PORTD en sortie
	movwf	TRISD			;
	
	movlw	0x61			;initialise la fr�quence de l'oscillateur 4 Mhz
	movwf	OSCCON			;

	movlw	0x07			;init le timer 0 timer rate 1/256
	movwf	OPTION_REG		;

	movlw	0x01			;analog bit 0 select
	movwf	ANSEL			;
	
	movlw	0x10			;conversion clock FOSC/8
	movwf	ADCON1			;

	bcf		STATUS,RP0		;retour bank 0

	clrf	PORTD			;clear portd
	clrf	PORTA			;clear porta
	
	movlw	0x81			;active le convertisseur, r�sultat 
	movwf	ADCON0			;dans ADRESL et 2 bits ADRESH 

	call	InitLCD			;Initialise le LCD

sw0_1

	bsf		ADCON0,GO		;init flag lecture T�
sw0	
	btfsc	ADCON0,GO		;test si temp�rature lue
	goto	sw0				;

	bsf		STATUS,RP0		;bank 1

	movf	ADRESL,W		;temp�rature dans W

	bcf		STATUS,RP0		;bank 0

	movwf	TMP				;conversion 
	movlw	0x68			;de temp�rature 
	subwf	TMP,F			;temp lue - 104
	bcf		STATUS,C		;clear carry flag
	rrf		TMP,W			;divise par 2
	movwf	TMP				;temp�rature dans TMP
	

	bcf		STATUS,C		;clear carry flag
	movf	TMP,W			;
	
	call	DisplayDecimal	;affiche la temp�rature

	call	Tempo			;Tempo 65ms

	movlw	0x1E			;consigne 30�
	movwf	CNS				;

	movf	TMP,W	
	bsf		STATUS,C		;carry � 1
	subwf	CNS,F			;consigne - temp�rature
	btfsc	STATUS,C		;temp�rature sup�rieure � consigne
	goto	sw0_1			;

	bsf		MTR				;d�marre le moteur

sw1_1

	bsf		ADCON0,GO		;init flag lecture T�
sw1
	btfsc	ADCON0,GO		;test si temp�rature lue
	goto	sw1				;

	bsf		STATUS,RP0		;bank 1

	movf	ADRESL,W		;temp�rature dans W

	bcf		STATUS,RP0		;bank 0

	movwf	TMP				;conversion 
	movlw	0x68			;de temp�rature
	subwf	TMP,F			;temp lue - 104
	bcf		STATUS,C		;clear carry flag
	rrf		TMP,W			;divise par 2, 
	movwf	TMP				;temp�rature dans TMP


	bcf		STATUS,C		;clear carry flag
	movf	TMP,W			;temp�rature dans W
	
	call	DisplayDecimal	;affiche la temp�rature

	call	Tempo			;tempo 65ms

	movlw	0x1B			;consigne 27�
	movwf	CNS				;dans CNS

	movf	TMP,W
	bsf		STATUS,C		;carry � 1
	subwf	CNS,F			;consigne - temp�rature
	btfss	STATUS,C		;temp�rature sup�rieure � consigne
	goto	sw1_1
	
	call	Tempo30			;tempo 2 secondes

	bcf		MTR				;arrete le moteur

	goto 	sw0_1			;

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
	
;----------------------------------------------
;Temporisation 30 * 65ms = 2sec
;----------------------------------------------
Tempo30	

	bcf		INTCON,T0IF		;clear timer overflow flag
	clrf	TMR0			;clear timer

	movlw	0x1E			;boucle de 30
	movwf	CNT				;clear timer
    
Tempo30_count

	bcf		INTCON,T0IF		;clear timer overflow flag
	clrf	TMR0			;
	
Tempo30_tmr

	btfss	INTCON,T0IF		;test overflow tmr
	goto	Tempo30_tmr		;
	
	decfsz	CNT				;test CNT = 0
	goto	Tempo30_count	;

	return	

 END
