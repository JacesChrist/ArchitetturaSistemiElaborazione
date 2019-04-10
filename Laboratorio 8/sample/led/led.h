																			 /*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           timer.h
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        Prototypes of functions included in the lib_led, funct_led .c files
** Correlated files:    lib_led.c, funct_led.c
**--------------------------------------------------------------------------------------------------------       
*********************************************************************************************************/

/* lib_led */
void LED_init(void);
void LED_deinit(void);

/* funct_led */

//ESERCIZIO 1
void led4and11_On(void); //funzione che controlla led 4 e 11

//ESERCIZIO 2
void led4_Off(void);

//ESERCIZIO 3
void ledEvenOn_OddOf(void);

//ESERCIZIO 4
void LED_On(unsigned int num);

//ESERCIZIO 5
void LED_Off(unsigned int num);
