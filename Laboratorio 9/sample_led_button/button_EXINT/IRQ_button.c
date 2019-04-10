#include "button.h"
#include "lpc17xx.h"
#include "../led/led.h"

//DAL DEBUGGER NON SI CAPISCE QUALE LED SIA IL 4 E QUALE L'11?

void EINT0_IRQHandler (void)	  //bottone KEY0
{
  LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
	LPC_GPIO2->FIOCLR 	|= 0xFFFFFFFF; //spengo led accesi
	LPC_GPIO2->FIOSET   |= 0x00000010;	//accendo led8
}

void EINT1_IRQHandler (void)	 //bottone KEY1 
{
	  LPC_SC->EXTINT |= (1 << 1);     /* clear pending interrupt         */
 
		//ESERCIZIO 1
		//spegne led corrente e accende sinistro
		if(LPC_GPIO2->FIOSET == 0x00000080){ //se acceso led4
				LPC_GPIO2->FIOCLR 	|= 0x00000080;
				LPC_GPIO2->FIOSET   |= 0x00000001; //accendo led11
		}
		else{ //se led4 spento
			LPC_GPIO2->FIOSET  |= LPC_GPIO2->FIOSET << 1; //accende led a sinistra di quello acceso
			LPC_GPIO2->FIOCLR 	|= LPC_GPIO2->FIOSET >> 1; //spegne led a destra di quelli accesi
		}
}

void EINT2_IRQHandler (void)  //bottone KEY2	  
{
  LPC_SC->EXTINT |= (1 << 2);     /* clear pending interrupt         */  

	//ESERCIZIO 1
		//spegne led corrente e accende destro
		if(LPC_GPIO2->FIOSET == 0x00000001){ //se acceso led11
				LPC_GPIO2->FIOCLR 	|= 0x00000001;
				LPC_GPIO2->FIOSET   |= 0x00000080; //accendo led4
		}
		else{ //se led11 spento
			LPC_GPIO2->FIOSET  |= LPC_GPIO2->FIOSET >> 1; //accende led a destra di quello acceso
			LPC_GPIO2->FIOCLR 	|= LPC_GPIO2->FIOSET << 1; //spegne led a sinistra di quelli accesi
		}
}

//meccanismo anti-rimbalzo???


