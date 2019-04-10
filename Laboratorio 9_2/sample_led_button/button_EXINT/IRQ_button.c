#include "button.h"
#include "lpc17xx.h"
#include "../led/led.h"
#include "time.h" //per timer

void EINT0_IRQHandler (void)	  
{
	int extern status;
	int unsigned extern timeCounter;
	int extern actual[3];
	
  LPC_SC->EXTINT = (1 << 0);     /* clear pending interrupt         */
	
	if(status == 2){ //controllo se sono nella fase che richiede KEY0
		if(timeCounter % 2){ //caso timer pari (50% che sia divisibile per 2)
			//accende LED8
			LED_On(4);
			actual[0] = 1; //setto bool nel vettore per controllo
		}
		else{
			actual[0] = 0;
			//accende LED9
			LED_On(5);
		}
		//controllo vittoria sul vettore actual (bit uguali)
		if(actual[0] == actual[1] && actual[1] == actual[2]){ //vittoriaaaaaa!!!!!!
			//accende LED11
			LED_On(7);
		}
		else{
			//accende LED10
			LED_On(6);
		}
		status = 0; //aggiorno stato
	}
	else{ //KEY2 non accettata in questa fase
	}
}


void EINT1_IRQHandler (void) //KEY1  
{
	int extern status;
	int unsigned extern timeCounter;
	int extern actual[3];
	
	LPC_SC->EXTINT = (1 << 1);     /* clear pending interrupt         */
	
	if(status == 0){ //controllo se sono nella fase che richiede KEY1
		LPC_GPIO2->FIOCLR   |= 0xFFFFFFFF; //spegne led
		if(timeCounter % 2){ //caso timer pari (50% che sia divisibile per 2)
			//accende LED4
			LED_On(0);
			actual[1]=1;
		}
		else{
			//accende LED5
			LED_On(1);
			actual[1] = 0;
		}

		status = 1; //aggiorno stato
	}
	else{ //KEY1 non accettata in questa fase
	}
}

void EINT2_IRQHandler (void)	  
{
	int extern status;
	int unsigned extern timeCounter;
	int extern actual[3];
	
  LPC_SC->EXTINT = (1 << 2);     /* clear pending interrupt         */  
		
	if(status == 1){ //controllo se sono nella fase che richiede KEY2
		if(timeCounter % 2){ //caso timer pari (50% che sia divisibile per 2)
			//accende LED6 
			LED_On(2);
			actual[2] = 1;
		}
		else{
			//accende LED7
			LED_On(3);
			actual[2] = 0;
		}
		status = 2; //aggiorno stato
	}
	else{ //KEY2 non accettata in questa fase
	}
}


