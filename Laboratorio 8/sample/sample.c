/*----------------------------------------------------------------------------
 * Name:    sample.c
 * Purpose: to control led through EINT buttons
 * Note(s):
 *----------------------------------------------------------------------------
 *
 * This software is supplied "AS IS" without warranties of any kind.
 *
 * Copyright (c) 2017 Politecnico di Torino. All rights reserved.
 *----------------------------------------------------------------------------*/
        
#include <stdio.h>
#include "LPC17xx.H"                    /* LPC17xx definitions                */
#include "led/led.h"
#include "button_EXINT/button.h"

/* Led external variables from funct_led */

/*----------------------------------------------------------------------------
  Main Program
 *----------------------------------------------------------------------------*/
int main (void) {
		int n=2;
  
  SystemInit();  												/* System Initialization (i.e., PLL)  */ 		//regola cose
  LED_init();                           /* LED Initialization                 */		//inizializza led
  //BUTTON_init();												/* BUTTON Initialization              */	
	
	//ESERCIZIO 1
	led4and11_On();		//chiamo la mia funzione
	
	//ESERCIZIO 2
	led4_Off();
	
	//ESERCIZIO 3
	ledEvenOn_OddOf();
	
	//ESERCIZIO 4
	n=7;
	LED_On(n);
	
	//ESERCIZIO 5
	n=4;
	LED_Off(n);
	
  while (1) {                           /* Loop forever                       */		//stop B stop in c
  }

}
