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

					AREA areaRO,DATA,READONLY
start 			DCD			9, 6, 3, 2, 1, 8, 7, 0, 5, 4, 0, 0 ;torre di partenza, aggiungo doppio 0 per terminazione

					AREA areaRW,DATA,READWRITE
stack1			SPACE	 20*4
stack2			SPACE	 20*4
stack3			SPACE	 20*4

init				RN 0
sp1				RN 1	;stack pointer
sp2				RN 2
sp3				RN 3
var				RN 4
var2				RN 5

                AREA    |.text|, CODE, READONLY
					
				


; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
                
				LDR init,=start
				LDR sp1,=stack1
				LDR sp2,=stack2
				LDR sp3,=stack3
				
				PUSH {init}
				PUSH {sp1}
				BL fillStack ;chiamata per fillare primo stack
				POP {sp1}
				
				PUSH {sp2}
				BL fillStack ;chiamata per fillare secondo stack
				POP {sp2}
				
				PUSH {sp3}
				BL fillStack ;chiamata per fillare terzo stack
				POP {sp3}
				POP {init}
				
				PUSH {sp1} ;stack partenza
				PUSH {sp2} ;stack destinazione
				PUSH {r12} ;posto per risultato
				BL move1
				POP {var} ;risultato move1
				POP {sp2}
				POP {sp1}
				
				PUSH {sp1} ;stack partenza
				PUSH {sp2} ;stack destinazione
				PUSH {sp3} ;stack appoggio
				MOV var,#3
				PUSH {var} ;numero movimenti
				BL moveN
				
stop			B stop
				ENDP
				
fillStack 	PROC 
				PUSH {LR}
				PUSH {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12}
				LDR r0,[SP,#56] ;in r0 stack pointer dello stack
				LDR r1,[SP,#60] ;in r1 indirizzo memoria readonly inizializzazione
				LDR var,[r1] ;il primo valore lo aggiungerò a prescindere perchè lo stack è vuoto a meno che non sia 0
				CMP var,#0
				BEQ fineciclofill
				STR var,[r0] ;inserisco nello stack
				ADD r1,#4 ;incremento puntatore vettore inizializzazione	
ciclofill
				LDR var,[r1] ;carico valore da vettore inizializzazione
				CMP var,#0 ;controllo condizione di terminazione valore 0
				BEQ fineciclofill
				LDR var2,[r0]
				CMP var,var2 ;confronto con ultimo valore in stack per condizione di terminazione maggiore
				BHI fineciclofill
				ADD r0,#4 ;incremento stack pointer prima dell'inserimento
				STR var,[r0] ;inserisco nello stack
				ADD r1,#4 ;incremento puntatore vettore inizializzazione
				B ciclofill
fineciclofill
				LDR var,[r1] ;se sono uscito per uno 0 devo toglierlo 
				CMP var,#0
				BNE nonZero
				ADD r1,#4
nonZero ;funziona con doppio 0 finale
				STR r0,[SP,#56] ;carico stack pointer nello stack principale per ritorno
				STR r1,[SP,#60] ;carico vettore inizializzazione nello stack principale per ritorno
				POP {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12}
				POP {PC}
				ENDP
				
move1		PROC
				PUSH {LR}
				PUSH {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12}
				LDR r0,[SP,#64] ;stack di partenza
				LDR r1,[SP,#60] ;stack destinazione
				LDR var,[r0]
				LDR var2,[r1]
				CMP var,var2
				BHI move1Fail
				ADD r1,#4 ;aumento stack pointer destinazione e inserisco valore
				STR var,[r1]
				MOV var2,#0 
				STR var2,[r0] ;diminuisco stack pointer partenza e inserisco zero
				SUB r0,#4
				MOV var2,#1
				STR var2,[SP,#56] ;inserisco risultato 1 in stack generico (move effettuata)
				POP {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12}
				POP {PC}
move1Fail
				MOV var2,#0
				STR var2,[SP,#56] ;inserisco risultato 0 in stack generico (move fallita)
				POP {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12}
				POP {PC}
				ENDP
				
moveN		PROC
				PUSH{r0-r11,lr}
				LDR r0,[SP,#56] ;N
				LDR r1,[SP,#68] ;stack partenza
				LDR r2,[SP,#64] ;stack destinazione
				LDR r3,[SP,#60] ;stack appoggio
				MOV r6,#0 ;M: numero movimenti effettuati
				CMP r0,#1
				BNE nmag1
				;caso N==1
				PUSH {r1} ;stack partenza
				PUSH {r2} ;stack destinazione
				PUSH {r12} ;posto per risultato
				BL move1
				POP {var} ;risultato move1
				POP {sp2}
				POP {sp1}
				ADD r6,r6,var ;M=M+a
nmag1 ;caso N>1
				PUSH {r1} ;stack partenza
				PUSH {r3} ;stack destinazione (invertiti)
				PUSH {r2} ;stack appoggio (invertiti)
				LDR r0,[sp,#56] ;paletto sorg
				LDR r1,[sp,#64] ;paletto dest
				LDR r2,[sp,#60] ;paletto ausiliario
				LDR r3,[sp,#56] ;n spost
				
				MOV r4,#0 ;M
				CMP r3,#1
				BNE else_if
				
				PUSH{r0}; src
				PUSH{r1};dest
				PUSH{r5};ritorno
				BL move1
				PUSH{r5}
				PUSH{r1}
				PUSH{r0}
				
				add r4,r5;M += a
				B fine_ric
else_if			
				;RICORSIONE
				MOV r6,r3
				ADD r6,#-1
				MOV r7,r6
				PUSH{r0};partenza 
				PUSH{r2};destinazione 
				PUSH{r1};paletto ausiliario
				PUSH{r6};numero spostamenti
				BL moveN
			    POP{r6}
				POP{r1}
				POP{r2}
				POP{r0}	
				ADD r4,r6 ;M = M + b
				
				PUSH{r0}; src
				PUSH{r1};dest
				PUSH{r5};ritorno a
				BL move1
				POP{r5}
				POP{r1}
				POP{r0}				
				CMP r5,#0
				BEQ fine_ric
				ADD r4,#1
				
				PUSH{r2};partenza 
				PUSH{r1};destinazione 
				PUSH{r0};paletto ausiliario
				PUSH{r7};numero spostamenti
				BL moveN
			    POP{r7}
				POP{r0}
				POP{r1}
				POP{r2}				
				ADD r4,r7 ;m+=c
fine_ric				
				STR r3,[sp,#56]
				STR r2,[sp,#60]
				STR r1,[sp,#64]
				STR r0,[sp,#56]
				POP{r0-r11,pc}
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
