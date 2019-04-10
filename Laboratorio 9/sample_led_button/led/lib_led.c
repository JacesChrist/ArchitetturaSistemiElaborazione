/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           timer.h
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        Atomic led init functions
** Correlated files:    lib_timer.c, funct_timer.c, IRQ_timer.c
**--------------------------------------------------------------------------------------------------------       
*********************************************************************************************************/

#include "lpc17xx.h"
#include "led.h"

/*----------------------------------------------------------------------------
  Function that initializes LEDs and switch them off
 *----------------------------------------------------------------------------*/



void LED_init(void) {

  LPC_PINCON->PINSEL4 &= 0xFFFF0000;	//PIN mode GPIO (00b value per p2.0 p2.1 p2.2 p2.3 
	LPC_GPIO2->FIODIR   |= 0x000000FF;  //P2.0...P2.7 Output LEDs on PORT2 defined as Output
}

void LED_deinit(void) {

  LPC_GPIO2->FIODIR &= 0xFFFFFF00;  //P2.0...P2.7 Output LEDs on PORT2 defined as Output
}

//dal lab 8
void LED_On(unsigned int num){
		switch (num){
			case 0: //LED 4 
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
			case 7: //LED 11
				LPC_GPIO2->FIOSET   |= 0x00000080;	
				break;
		}			
}

//ritorna status led
int LED_status(void){
				return LPC_GPIO2->FIOSET;
}
