;/**************************************************************************//**
; * @file     startup_LPC17xx.s
; * @brief    CMSIS Cortex-M3 Core Device Startup File for
; *           NXP LPC17xx Device Series
; * @version  V1.10
; * @date     06. April 2011
; *
; * @note
; * Copyright (C) 2009-2011 ARM Limited. All rights reserved.
; *
; * @par
; * ARM Limited (ARM) is supplying this software for use with Cortex-M
; * processor based microcontrollers.  This file can be freely distributed
; * within development tools that are supporting such ARM based processors.
; *
; * @par
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; ******************************************************************************/

; *------- <<< Use Configuration Wizard in Context Menu >>> ------------------

; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00000200

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000000

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     NMI_Handler               ; NMI Handler
                DCD     HardFault_Handler         ; Hard Fault Handler
                DCD     MemManage_Handler         ; MPU Fault Handler
                DCD     BusFault_Handler          ; Bus Fault Handler
                DCD     UsageFault_Handler        ; Usage Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     SVC_Handler               ; SVCall Handler
                DCD     DebugMon_Handler          ; Debug Monitor Handler
                DCD     0                         ; Reserved
                DCD     PendSV_Handler            ; PendSV Handler
                DCD     SysTick_Handler           ; SysTick Handler

                ; External Interrupts
                DCD     WDT_IRQHandler            ; 16: Watchdog Timer
                DCD     TIMER0_IRQHandler         ; 17: Timer0
                DCD     TIMER1_IRQHandler         ; 18: Timer1
                DCD     TIMER2_IRQHandler         ; 19: Timer2
                DCD     TIMER3_IRQHandler         ; 20: Timer3
                DCD     UART0_IRQHandler          ; 21: UART0
                DCD     UART1_IRQHandler          ; 22: UART1
                DCD     UART2_IRQHandler          ; 23: UART2
                DCD     UART3_IRQHandler          ; 24: UART3
                DCD     PWM1_IRQHandler           ; 25: PWM1
                DCD     I2C0_IRQHandler           ; 26: I2C0
                DCD     I2C1_IRQHandler           ; 27: I2C1
                DCD     I2C2_IRQHandler           ; 28: I2C2
                DCD     SPI_IRQHandler            ; 29: SPI
                DCD     SSP0_IRQHandler           ; 30: SSP0
                DCD     SSP1_IRQHandler           ; 31: SSP1
                DCD     PLL0_IRQHandler           ; 32: PLL0 Lock (Main PLL)
                DCD     RTC_IRQHandler            ; 33: Real Time Clock
                DCD     EINT0_IRQHandler          ; 34: External Interrupt 0
                DCD     EINT1_IRQHandler          ; 35: External Interrupt 1
                DCD     EINT2_IRQHandler          ; 36: External Interrupt 2
                DCD     EINT3_IRQHandler          ; 37: External Interrupt 3
                DCD     ADC_IRQHandler            ; 38: A/D Converter
                DCD     BOD_IRQHandler            ; 39: Brown-Out Detect
                DCD     USB_IRQHandler            ; 40: USB
                DCD     CAN_IRQHandler            ; 41: CAN
                DCD     DMA_IRQHandler            ; 42: General Purpose DMA
                DCD     I2S_IRQHandler            ; 43: I2S
                DCD     ENET_IRQHandler           ; 44: Ethernet
                DCD     RIT_IRQHandler            ; 45: Repetitive Interrupt Timer
                DCD     MCPWM_IRQHandler          ; 46: Motor Control PWM
                DCD     QEI_IRQHandler            ; 47: Quadrature Encoder Interface
                DCD     PLL1_IRQHandler           ; 48: PLL1 Lock (USB PLL)
                DCD     USBActivity_IRQHandler    ; 49: USB Activity interrupt to wakeup
                DCD     CANActivity_IRQHandler    ; 50: CAN Activity interrupt to wakeup


                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         DCD     0xFFFFFFFF
                ENDIF
				
				;costante N e nomi registri
;N				EQU	3
N		 		EQU 8
dimn			RN 0
mat				RN 1
dimnn			RN 2
boolvett		RN 3
valore 			RN 4
count			RN 5
magic			RN 6
valore2			RN 7
crighe 			RN 8
ccolonne		RN 9
valore3			RN 10
valore4			RN 11

				;MATRICI
				AREA matrici,DATA,READONLY
;mat1			DCB 4,9,2,3,5,7,8,1,6
;mat1			DCB 4,9,2,3,5,7,4,1,6 ;SBAGLIATA RIPETIZIONE
;mat1			DCB 4,9,2,3,5,7,1,8,6 ;SBAGLIATA SOMMA >15
;mat1			DCB 0,9,2,3,5,7,8,1,6 ;SBAGLIATA ZERO
mat1			DCB 64,2,3,61,60,6,7,57,9,55,54,12,13,51,50,16,17,47,46,20,21,43,42,24,40,26,27,37,36,30,31,33,32,34,35,29,28,38,39,25,41,23,22,44,45,19,18,48,49,15,14,52,53,11,10,56,8,58,59,5,4,62,63,1

;VETTORE DI SERVIZIO
				AREA vettore,DATA,READWRITE
boolvet			SPACE N*N ;BYTE
countcolonne	SPACE N*4 ;WORD
countrighe		SPACE N*4 ;WORD


                AREA    |.text|, CODE, READONLY


; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
					
				MOV dimn,#N ;DIMENSIONE N       
				PUSH {dimn} 				
				LDR mat,=mat1 ;INDIRIZZO MATRICE
				PUSH {mat} ;PUSHO UN REGISTRO ALLA VOLTA SE NO LI PUSHEREBBE IN ORDINE DI REGISTRO E NON COME VOGLIO
				PUSH {r2} ;SEGNAPOSTO PER RISULTATO
				BL magicSquare ;CHIAMATA
				POP {r0} ;RISULTATO PASSATO VIA STACK POPPATO IN r1
				
stop 			B stop				
			
			
magicSquare
				;ACQUISIZIONE/INIZIALIZZAZIONE
				PUSH {LR}
				PUSH {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12} ;PUSHO TUTTI I REGISTRI E LINK REGISTER
				LDR dimn,[SP,#64] ;POPPO N
				LDR mat,[SP,#60] ;POPPO INDIRIZZO MATRICE
				MUL dimnn,dimn,dimn ;VALORE DI RIFERIMENTO N^2
				LDR boolvett,=boolvet ;INDIRIZZO VETTORE DI BOOLEANI DOPPIONI
				LDR crighe,=countrighe ;INDIRIZZO VETTORE SOMMATORIE PER RIGA
				LDR ccolonne,=countcolonne ;INDIRIZZO VETTORE SOMMATORIE PER COLONNA
				MUL magic,dimn,dimn
				ADD magic,magic,#1
				MUL magic,magic,dimn
				LSR magic,magic,#1 ;NUMERO MAGICO
				EOR count,count ;AZZERO E USERO' COME CONTATORE 0->N^2
				MOV valore4,#4 ;COSTANTE MOLTIPLICATIVA PER GLI INDIRIZZAMENTI NEI VETTORI DI WORD
CICLO		
				;CONTROLLO >N^2 <=0
				LDRB valore,[mat,count] ;PRENDO VALORE DALLA MATRICE
				MOV valore2,#0
				CMP valore,valore2 ;CONTROLLO SE IL NUMERO E' MINORE O UGUALE A 0
				BLS BREAK 
				CMP valore,dimnn ;CONTROLLO SE IL NUMERO E' MAGGIORE DI N^2
				BHI BREAK			
				;CONTROLLO BOOLEANO DOPPIONI
				SUB valore, valore,#1 ;PORTO DA [1-N^2] A [0-N^2-1] PER ACCEDERE DIRETTAMENTE AL VETTORE N*N
				LDRB valore2,[boolvett,valore] ;CARICO BOOLEANO DAL VETTORE DI BOOLEANI
				CMP valore2,#1 ;CONTROLLO: SE TRUE GIA' INCONTRATO
				BEQ BREAK 
				MOV valore2,#1
				STRB valore2,[boolvett,valore] ;SETTO IL BOOLEANO A TRUE
				ADD valore,valore,#1 ;RIPORTO VALORE A [1-n^2]			
				;AGGIORNO CONTEGGIO RIGA
				UDIV valore2,count,dimn ;RIGA CORRENTE
				MUL valore2,valore2,valore4 ;INDICE DI ACCESSO *4 PER WORD
				LDR valore3,[crighe,valore2] ;PRENDO SOMMATORIA CORRENTE DELLA RIGA
				UDIV valore2,valore2,valore4
				ADD valore3,valore3,valore ;AGGIUNGO A VALORE DELLA RIGA IL VALORE CORRENTE
				CMP valore3,magic ;CONFRONTO LA NUOVA SOMMATORIA DELLA RIGA CON IL NUMERO MAGICO
				BGT BREAK
				MUL valore2,valore2,valore4 ;INDICE DI ACCESSO *4 PER WORD
				STR valore3,[crighe,valore2] ;AGGIORNO SOMMATORIA DELLA RIGA CORRENTE
				UDIV valore2,valore2,valore4
				;AGGIORNO CONTEGGIO COLONNA
				MOV valore2,count ;CALCOLO COLONNA CORRENTE FACENDO (count)mod(N) TRAMITE SOTTRAZIONI DI N SUCCESSIVE
CICLOC
				CMP valore2,dimn
				BLO FINECICLOC
				SUB valore2,valore2,dimn 
				B CICLOC
FINECICLOC
				MUL valore2,valore2,valore4 ;INDICE DI ACCESSO *4 PER WORD
				LDR valore3,[ccolonne,valore2] ;PRENDO SOMMATORIA CORRENTE DELLA COLONNA
				UDIV valore2,valore2,valore4
				ADD valore3,valore3,valore ;AGGIUNGO A VALORE DELLA COLONNA IL VALORE CORRENTE
				CMP valore3,magic ;CONFRONTO LA NUOVA SOMMATORIA DELLA COLONNA CON IL NUMERO MAGICO
				BGT BREAK
				MUL valore2,valore2,valore4 ;INDICE DI ACCESSO *4 PER WORD
				STR valore3,[ccolonne,valore2] ;AGGIORNO SOMMATORIA DELLA COLONNA CORRENTE
				UDIV valore2,valore2,valore4
				ADD count,count,#1 ;FINE CICLO
				CMP count,dimnn
				BLO CICLO
				;CONTROLLO SE TUTTE LE SOMMATORIE SONO UGUALI AL NUMERO MAGICO
				MOV count,#0
				MUL valore4,valore4,dimn ;VALORE DI TERMINAZIONE N*4
CONTROLLOMAGIC
				LDR valore,[crighe,count]
				CMP valore,magic
				BNE BREAK
				LDR valore,[ccolonne,count]
				CMP valore,magic
				BNE BREAK
				ADD count,count,#4
				CMP count,valore4
				BLO CONTROLLOMAGIC
				;FINE FAVOREVOLE
				MOV r0, #1
				STR r0,[SP,#56] ;SCRIVO 1 NEL LO SPAZIO RISULTATO NELLO STACK
				POP {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12} ;RIPRISTINO REGISTRI E PROGRAM COUNTER CON LR
				POP {PC}
							
BREAK	
				MOV r0,#0 ;CONDIZIONE FALLIMENTARE
				STR r0,[SP,#56] ;SCRIVO 0 NEL LO SPAZIO RISULTATO NELLO STACK
				POP {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12} ;RIPRISTINO REGISTRI E PROGRAM COUNTER CON LR
				POP {PC}

                ENDP


; Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                B       .
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
                B       .
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  TIMER0_IRQHandler         [WEAK]
                EXPORT  TIMER1_IRQHandler         [WEAK]
                EXPORT  TIMER2_IRQHandler         [WEAK]
                EXPORT  TIMER3_IRQHandler         [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  PWM1_IRQHandler           [WEAK]
                EXPORT  I2C0_IRQHandler           [WEAK]
                EXPORT  I2C1_IRQHandler           [WEAK]
                EXPORT  I2C2_IRQHandler           [WEAK]
                EXPORT  SPI_IRQHandler            [WEAK]
                EXPORT  SSP0_IRQHandler           [WEAK]
                EXPORT  SSP1_IRQHandler           [WEAK]
                EXPORT  PLL0_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  EINT0_IRQHandler          [WEAK]
                EXPORT  EINT1_IRQHandler          [WEAK]
                EXPORT  EINT2_IRQHandler          [WEAK]
                EXPORT  EINT3_IRQHandler          [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  BOD_IRQHandler            [WEAK]
                EXPORT  USB_IRQHandler            [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  DMA_IRQHandler            [WEAK]
                EXPORT  I2S_IRQHandler            [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  RIT_IRQHandler            [WEAK]
                EXPORT  MCPWM_IRQHandler          [WEAK]
                EXPORT  QEI_IRQHandler            [WEAK]
                EXPORT  PLL1_IRQHandler           [WEAK]
                EXPORT  USBActivity_IRQHandler    [WEAK]
                EXPORT  CANActivity_IRQHandler    [WEAK]

WDT_IRQHandler
TIMER0_IRQHandler
TIMER1_IRQHandler
TIMER2_IRQHandler
TIMER3_IRQHandler
UART0_IRQHandler
UART1_IRQHandler
UART2_IRQHandler
UART3_IRQHandler
PWM1_IRQHandler
I2C0_IRQHandler
I2C1_IRQHandler
I2C2_IRQHandler
SPI_IRQHandler
SSP0_IRQHandler
SSP1_IRQHandler
PLL0_IRQHandler
RTC_IRQHandler
EINT0_IRQHandler
EINT1_IRQHandler
EINT2_IRQHandler
EINT3_IRQHandler
ADC_IRQHandler
BOD_IRQHandler
USB_IRQHandler
CAN_IRQHandler
DMA_IRQHandler
I2S_IRQHandler
ENET_IRQHandler
RIT_IRQHandler
MCPWM_IRQHandler
QEI_IRQHandler
PLL1_IRQHandler
USBActivity_IRQHandler
CANActivity_IRQHandler

                B       .

                ENDP


                ALIGN


; User Initial Stack & Heap

                IF      :DEF:__MICROLIB

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit

                ELSE

                ;IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap
__user_initial_stackheap

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR

                ALIGN

                ENDIF


                END
