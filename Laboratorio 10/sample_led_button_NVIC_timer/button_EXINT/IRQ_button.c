#include "button.h"
#include "lpc17xx.h"
#include "../led/led.h"

#define timeNoBounce 0x00000050 //tempo attesa per evitare bounce

void extern waitTimer(int);

int extern takeButton;
int extern button;
int extern random012[256];
int extern support;

void EINT0_IRQHandler (void)	  
{
	LPC_SC->EXTINT = (1 << 0);     /* clear pending interrupt         */
	if(takeButton){ //non fa niente se non rischiesta pressione di un bottone
		waitTimer(timeNoBounce);
		button = 0;
		takeButton = 0;	
		random012[support] = LPC_TIM1->TC % 3; //setta numero randomico da istante pressione bottone
		LPC_SC->EXTINT = (1 << 0);     /* clear pending interrupt         */
	}
	return;
}


void EINT1_IRQHandler (void)	  
{
	LPC_SC->EXTINT = (1 << 1);     /* clear pending interrupt         */
	if(takeButton){
		waitTimer(timeNoBounce);
		button = 1;
		takeButton = 0;	
		random012[support] = LPC_TIM1->TC % 3; //setta numero randomico da istante pressione bottone
		LPC_SC->EXTINT = (1 << 1);     /* clear pending interrupt         */
	}
	return;
}

void EINT2_IRQHandler (void)	  
{
	LPC_SC->EXTINT = (1 << 2);     /* clear pending interrupt         */   
	if(takeButton){
		LPC_SC->EXTINT = (1 << 2);     /* clear pending interrupt         */   
		waitTimer(timeNoBounce);
		button = 2;
		takeButton = 0;	
		random012[support] = LPC_TIM1->TC % 3; //setta numero randomico da istante pressione bottone
		LPC_SC->EXTINT = (1 << 1);     /* clear pending interrupt         */
	}
	return;
} 
