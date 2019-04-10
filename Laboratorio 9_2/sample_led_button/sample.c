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
//#include "sample.h"



/*----------------------------------------------------------------------------
  Main Program
 *----------------------------------------------------------------------------*/
	
	//GLOBALI
	int status = 0; // 0:nessuna partita in corso. 1: fase 1 eseguita. 2: fase 2 eseguita
	int unsigned timeCounter = 0; //incrementa
	int actual[3];

int main (void) {
	
  
  SystemInit();  												/* System Initialization (i.e., PLL)  */
  LED_init();                           /* LED Initialization                 */
  BUTTON_init();												/* BUTTON Initialization              */
	
  while (1) { //partite il loop
		if(timeCounter++ > 10000)
				timeCounter = 0; //azzero se no da errori (?)
		
  }

}

