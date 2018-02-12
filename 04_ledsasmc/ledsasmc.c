/*******************************************************************/
/* Programme: ledsasmc.c                                           */
/* Programme qui fait clignoter une ou plusieurs leds sur le port  */
/* en fonction de l'état des switches du port A. Le programme fait */
/* appelle à la fonction testSwitch(), codée en assembleur.        */
/*******************************************************************/
#include <htc.h>
#include <pic16f628.h>

unsigned char led=0;

unsigned char testSwitch(unsigned char);

	/**********************************/
	/*MAIN                            */
	/**********************************/
int main()
{


PORTB=0x00;

CMCON=0x07;
TRISA=0xff; 
TRISB=0x00;

PORTA=0x00;

led=0;

while (1)
 {
   
  testSwitch(led);
  
  
 PORTB ^= led;


 
}
return;
}

/************************************************************/
/* Fonction qui test l'état des switchs sw0 à 3 et retourne */
/* le byte correspondant aux leds qui doivent êtres allumés */
/* Entré : état des leds                                    */
/* Sortie : état des leds                                   */
/************************************************************/
unsigned char testSwitch(unsigned char l)
{

#asm 

main

	btfsc	_PORTA,0
	goto	sw0
	btfsc	_PORTA,1
	goto	sw1
	btfsc	_PORTA,2
	goto	sw2
	btfsc	_PORTA,3
	goto	sw3
	movlw	0
	goto	endp
sw0
	movlw	0x20
	movwf	_led
	goto	endp
sw1
	movlw	0xC0
	movwf	_led
	goto	endp
sw2
	movlw	0x80
	movwf	_led
	goto	endp
sw3
	movlw	0x60
	movwf	_led
	
endp
	movlw	0

#endasm
 
 return led;

}