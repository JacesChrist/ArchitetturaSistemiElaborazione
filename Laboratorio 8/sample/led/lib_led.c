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

  LPC_PINCON->PINSEL4 &= 0xFFFF0000;	//PIN mode GPIO (00b value per p2.0 p2.1 p2.2 p2.3  			//forzo i bit bassi a zero
	LPC_GPIO2->FIODIR   |= 0x000000FF;  //P2.0...P2.7 Output LEDs on PORT2 defined as Output			//setto i pin in modalita' output forzando a 1 i bit bassi
}

void LED_deinit(void) {

  LPC_GPIO2->FIODIR &= 0xFFFFFF00;  //P2.0...P2.7 Output LEDs on PORT2 defined as Output
}
