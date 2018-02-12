opt subtitle "HI-TECH Software Omniscient Code Generator (Lite mode) build 9453"

opt pagewidth 120

	opt lm

	processor	16F628
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
	FNCALL	_main,_testSwitch
	FNROOT	_main
	global	_led
	global	_CMCON
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:
_CMCON	set	31
	global	_PORTA
_PORTA	set	5
	global	_PORTB
_PORTB	set	6
	global	_CARRY
_CARRY	set	24
	global	_GIE
_GIE	set	95
	global	_EEADR
_EEADR	set	155
	global	_EECON1
_EECON1	set	156
	global	_EECON2
_EECON2	set	157
	global	_EEDATA
_EEDATA	set	154
	global	_TRISA
_TRISA	set	133
	global	_TRISB
_TRISB	set	134
	global	_RD
_RD	set	1248
	global	_WR
_WR	set	1249
	global	_WREN
_WREN	set	1250
	file	"ledsasmc.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bssCOMMON,class=COMMON,space=1
global __pbssCOMMON
__pbssCOMMON:
_led:
       ds      1

; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2
	clrf	((__pbssCOMMON)+0)&07Fh
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	??_testSwitch
??_testSwitch:	; 0 bytes @ 0x0
	global	??_main
??_main:	; 0 bytes @ 0x0
	global	?_testSwitch
?_testSwitch:	; 1 bytes @ 0x0
	global	?_main
?_main:	; 2 bytes @ 0x0
	ds	1
;;Data sizes: Strings 0, constant 0, data 0, bss 1, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      1       2
;; BANK0           80      0       0
;; BANK1           80      0       0
;; BANK2           48      0       0

;;
;; Pointer list with targets:



;;
;; Critical Paths under _main in COMMON
;;
;;   None.
;;
;; Critical Paths under _main in BANK0
;;
;;   None.
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.

;;
;;Main: autosize = 0, tempsize = 1, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 1     1      0       0
;;                                              0 COMMON     1     1      0
;;                         _testSwitch
;; ---------------------------------------------------------------------------------
;; (1) _testSwitch                                           0     0      0       0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 1
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _testSwitch
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA              80      0       0       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;COMMON               E      1       2       1       14.3%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;STACK                0      0       1       2        0.0%
;;BANK0               50      0       0       3        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;SFR3                 0      0       0       4        0.0%
;;ABS                  0      0       2       4        0.0%
;;BITBANK0            50      0       0       5        0.0%
;;BITSFR2              0      0       0       5        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK2            30      0       0       8        0.0%
;;BANK2               30      0       0       9        0.0%
;;DATA                 0      0       3      10        0.0%

	global	_main
psect	maintext

;; *************** function _main *****************
;; Defined at:
;;		line 13 in file "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  2  380[COMMON] int 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          1       0       0       0
;;      Totals:         1       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_testSwitch
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
	line	13
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 7
; Regs used in _main: [wreg+status,2+status,0+pclath+cstack]
	line	16
	
l2018:	
;ledsasmc.c: 16: PORTB=0x00;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(6)	;volatile
	line	18
	
l2020:	
;ledsasmc.c: 18: CMCON=0x07;
	movlw	(07h)
	movwf	(31)	;volatile
	line	19
	
l2022:	
;ledsasmc.c: 19: TRISA=0xff;
	movlw	(0FFh)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(133)^080h	;volatile
	line	20
;ledsasmc.c: 20: TRISB=0x00;
	clrf	(134)^080h	;volatile
	line	22
;ledsasmc.c: 22: PORTA=0x00;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(5)	;volatile
	line	24
	
l2024:	
;ledsasmc.c: 24: led=0;
	clrf	(_led)
	goto	l2026
	line	26
;ledsasmc.c: 26: while (1)
	
l381:	
	line	29
	
l2026:	
;ledsasmc.c: 27: {
;ledsasmc.c: 29: testSwitch(led);
	movf	(_led),w
	fcall	_testSwitch
	line	32
	
l2028:	
;ledsasmc.c: 32: PORTB ^= led;
	movf	(_led),w
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	xorwf	(6),f	;volatile
	goto	l2026
	line	36
	
l382:	
	line	26
	goto	l2026
	
l383:	
	line	38
;ledsasmc.c: 36: }
;ledsasmc.c: 37: return;
	
l384:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,90
	global	_testSwitch
psect	text71,local,class=CODE,delta=2
global __ptext71
__ptext71:

;; *************** function _testSwitch *****************
;; Defined at:
;;		line 41 in file "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
;; Parameters:    Size  Location     Type
;;  l               1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text71
	file	"C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
	line	41
	global	__size_of_testSwitch
	__size_of_testSwitch	equ	__end_of_testSwitch-_testSwitch
	
_testSwitch:	
	opt	stack 7
; Regs used in _testSwitch: [wreg]
	line	45
	
l1158:	
# 45 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
main ;#
	line	47
# 47 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 btfsc _PORTA,0 ;#
	line	48
# 48 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 goto sw0 ;#
	line	49
# 49 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 btfsc _PORTA,1 ;#
	line	50
# 50 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 goto sw1 ;#
	line	51
# 51 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 btfsc _PORTA,2 ;#
	line	52
# 52 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 goto sw2 ;#
	line	53
# 53 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 btfsc _PORTA,3 ;#
	line	54
# 54 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 goto sw3 ;#
	line	55
# 55 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 movlw 0 ;#
	line	56
# 56 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 goto endp ;#
	line	57
# 57 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
sw0 ;#
	line	58
# 58 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 movlw 0x20 ;#
	line	59
# 59 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 movwf _led ;#
	line	60
# 60 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 goto endp ;#
	line	61
# 61 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
sw1 ;#
	line	62
# 62 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 movlw 0xC0 ;#
	line	63
# 63 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 movwf _led ;#
	line	64
# 64 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 goto endp ;#
	line	65
# 65 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
sw2 ;#
	line	66
# 66 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 movlw 0x80 ;#
	line	67
# 67 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 movwf _led ;#
	line	68
# 68 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 goto endp ;#
	line	69
# 69 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
sw3 ;#
	line	70
# 70 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 movlw 0x60 ;#
	line	71
# 71 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 movwf _led ;#
	line	73
# 73 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 endp ;#
	line	74
# 74 "C:\Users\metouisa\Documents\_sources\_micro program\_dossiers micro\04_ledsasmc\ledsasmc.c"
 movlw 0 ;#
psect	text71
	line	80
;ledsasmc.c: 78: return led;
;	Return value of _testSwitch is never used
	
l387:	
	return
	opt stack 0
GLOBAL	__end_of_testSwitch
	__end_of_testSwitch:
;; =============== function _testSwitch ends ============

	signat	_testSwitch,4217
psect	text72,local,class=CODE,delta=2
global __ptext72
__ptext72:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
