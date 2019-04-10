#include "led.h"
#include "lpc17xx.h"

//ESERCIZIO 1
void led4and11_On(void){
	LPC_GPIO2->FIOSET   |= 0x00000081;	//metto 1000 0001 per accendere led 4 e 11 (primo e ultimo)
}

//ESERCIZIO 2
void led4_Off(void){
	LPC_GPIO2->FIOCLR   |= 0x00000001;	//spegnere led 4 e altri inalterati
}

//ESERCIZIO 3
void ledEvenOn_OddOf(void){
		LPC_GPIO2->FIOSET   |= 0x00000055;
	;	LPC_GPIO2->FIOCLR   |= 0x000000AA;
}

//ESERCIZIO 4
void LED_On(unsigned int num){
		switch (num){
			case 0://LED 4
				LPC_GPIO2->FIOSET   |= 0x00000001;	
				break;
			case 1:
				LPC_GPIO2->FIOSET   |= 0x00000002;	
				break;
			case 2:
				LPC_GPIO2->FIOSET   |= 0x00000004;	
				break;
			case 3:
				LPC_GPIO2->FIOSET   |= 0x00000008;	
				break;
			case 4:
				LPC_GPIO2->FIOSET   |= 0x00000010;	
				break;
			case 5:
				LPC_GPIO2->FIOSET   |= 0x00000020;	
				break;
			case 6:
				LPC_GPIO2->FIOSET   |= 0x00000040;	
				break;
			case 7://LED 11
				LPC_GPIO2->FIOSET   |= 0x00000080;	
				break;
		}			
}
	
//ESERCIZIO 5
void LED_Off(unsigned int num){
					switch (num){
			case 0:
				LPC_GPIO2->FIOCLR   |= 0x00000001;	
				break;
			case 1:
				LPC_GPIO2->FIOCLR   |= 0x00000002;	
				break;
			case 2:
				LPC_GPIO2->FIOCLR   |= 0x00000004;	
				break;
			case 3:
				LPC_GPIO2->FIOCLR   |= 0x00000008;	
				break;
			case 4:
				LPC_GPIO2->FIOCLR   |= 0x00000010;	
				break;
			case 5:
				LPC_GPIO2->FIOCLR   |= 0x00000020;	
				break;
			case 6:
				LPC_GPIO2->FIOCLR   |= 0x00000040;	
				break;
			case 7:
				LPC_GPIO2->FIOCLR   |= 0x00000080;	
				break;
		}			
}
