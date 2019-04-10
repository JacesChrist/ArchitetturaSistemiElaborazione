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
#include "timer/timer.h"

/*----------------------------------------------------------------------------
  Main Program
 *----------------------------------------------------------------------------*/

//costanti
#define timeWait 0x00100000 //~~1,5s //0x017D7840 //25000*1500= 0x165A0BC0 nope troppo grande

//funzioni
void incrementStory(void);
void showStory(void);
int getStory(void);
void waitTimer(int);

//globali
	int count; //a partire da 1 numero raggiunto
	int story[256];	
	int timerLoop;
	int takeButton; //controllo pressione bottoni
	int button;
	int random012[256];
	int support;
	
int main (void) {
  	
	SystemInit();  												/* System Initialization (i.e., PLL)  */
  LED_init();                           /* LED Initialization                 */
  BUTTON_init();												/* BUTTON Initialization              */								
	init_timer(1,0xFFFFFFFF); //timer per random inizializzato							
	enable_timer(1); //timer per random partito
	
  while (1) { //attesa
		count = 0;		
		button = -1;
		support = 0;
		takeButton = 1;
		while(button == -1); //cicla finche' non viene attivato un bottone qualsiasi
		LPC_GPIO2->FIOCLR   |= 0x0000FFFF; //spegne tutti LED
		while(1){ //partita
			incrementStory();
			LPC_GPIO2->FIOCLR   |= 0x0000FFFF; //spegne tutti LED
			waitTimer(timeWait);
			showStory();
			support = getStory();
			if(support != 0){ //sconfitta
				LPC_GPIO2->FIOPIN |= (support); //mostra binario di count su LED$-11
				break;
			}
			else{ //vittoria, avanza
				LPC_GPIO2->FIOPIN |= (count); //mostra binario di count su LED$-11
				waitTimer(timeWait);
			}	
		}	
  }
}

void incrementStory(void){
	count++;
	for(support=0;support<count;support++)
			story[support] = random012[support];
	return;
}

void showStory(void){ //mostra sequenza
	for(support=0;support<count;support++){
		switch (story[support]){
			case 0:
				LPC_GPIO2->FIOSET   |= 0x00000001; //accende LED4
			break;
			case 1:
				LPC_GPIO2->FIOSET   |= 0x00000002; //accende LED5
				break;
			case 2:
				LPC_GPIO2->FIOSET   |= 0x00000004; //accende LED6
			break;
		}
		waitTimer(timeWait);
		LPC_GPIO2->FIOCLR   |= 0x0000FFFF; //spegne tutti LED
		waitTimer(timeWait);
	}
	return;
}

int getStory(void){ //acquisisce sequenza
	for(support=0;support<count;support++){
		if(support != 0) 
			random012[support] = LPC_TIM1->TC % 3;  //ogni pressione bottone mi da un casuale
		
		else //il primo lo ricavo come distanza dal primo precedente (pseudocasuale)
			random012[support] += LPC_TIM1->TC % 3;
			button = -1;
		takeButton = 1;
		while(button == -1); //cicla aspettando pressione bottone
		if(button != story[support]) //errore
			return support; //ritorna valore a cui hai sbagliato <n
	}
	return 0; //sequenza corretta
}

void waitTimer(int t){
	timerLoop = 1;
	init_timer(0,t);
	enable_timer(0);
	while(timerLoop);
	return;
}
