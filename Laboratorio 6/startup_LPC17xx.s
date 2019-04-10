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


				AREA areaData, DATA, READWRITE, NOINIT
var2			SPACE 12

                AREA    |.text|, CODE, READONLY
					
					
					



; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
					
				;ESERCIZIO 1 passaggio parametri tramite registri
								
				;LDR r0,=0x7A30458D ;OPERANDO 1 IN r0
				;LDR r1,=0xC3159EAA ;OPERANDO 2 IN r1
				;BL myUADD8 ;IN r4 AVRO' IL RISULTATO, REGISTRI r2,r3,r5,r6 INALTERATI CON PUSH-POP
;stop 			B stop

				;ESERCIZIO 2 ;parametri tramite area di memoria con indirizz (no registri)
				
				;LDR r6,=var2 ;AREA DI MEMORIA RW DI 24 BYTE, PRIMI 32 BIT OPERANDO1, SECONDI 32 BIT OPERANDO2, TERZI 32 PER FUTURO RISULTATO
				;LDR r0,=0x7A30458D ;OPERANDO 1
				;LDR r1,=0xC3159EAA ;OPERANDO 2
				;STR r0,[r6]
				;STR r1,[r6,#4]
				;BL myUSAD8 ;RISULTATO IN [r6,#8]
;stop			B stop

				;ESERCIZIO 3 tramite stack
				
				;LDR r0,=0x7A30458D ;OPERANDO 1
				;PUSH {r0} ;PASSAGGIO TRAMITE STACK
				;LDR r0,=0xC3159EAA ;OPERANDO 2
				;;SMUAD
				;PUSH {r0}
				;PUSH {r0} ;PUSHO VALORE INUTILE PER ALLOCARMI LO SPAZIO NELLO STACK CHE USERO' PER IL RISULTATO
				;BL mySMUAD
				;POP {r0} ;IN r0 IL RISULTATO
				;;SMUSD
				;PUSH {r0}
				;PUSH {r0} ;PUSHO VALORE INUTILE PER ALLOCARMI LO SPAZIO NELLO STACK CHE USERO' PER IL RISULTATO
				;BL mySMUSD
				;POP {r0} ;IN r0 IL RISULTATO
;stop			B stop

				;ESERCIZIO 4 -> Laboratorio 6.4

myUADD8
				PUSH {LR} ;PUSHO INDIRIZZO DI RITORNO
				PUSH {r2,r3,r5,r6} ;PUSHO REGISTRI CHE UTILIZZO NELLA PROCEDURA
				LDR r4,=0x0 ;AZZERO REGISTRO DESTINAZIONE
				LDR r2,=0xFF ;MASCHERA BIT A 1 NEGLI 8 MENO SIGNIFICATIVI
CICLO1 
				AND r5,r0,r2 ;r0 MASCHERATO 
				AND r6,r1,r2 ;r1 MASCHERATO 
				ADD r3,r5,r6 ;ADD CON RIPORTO
				AND r3,r3,r2 ;TRONCAMENTO RIPORTO
				ADD r4,r4,r3 ;AGGIUNGO AL RISULTATO CORRENTE
				LSL r2,r2,#8 ;SHIFTO MASCHERA DI UN BYTE
				CMP r2,#0x0 ;CONDIZIONE DI TERMINAZIONE QUANDO FF HA SHIFTATO A DESTRA 4 VOLTE (DIVENTA ZERO)
				BNE CICLO1 ;UNICO VALORE SIGNIFICATIVO IN r4
				POP {r2,r3,r5,r6} ;POPPO REGISTRI CHE HO SOVRASCRITTO RIOTTENENDO I VALORI PRECEDENTI
				POP {PC} ;CARICO INDIRIZZO DI RITORNO NEL PROGRAM COUNTER
				
myUSAD8
				PUSH {LR}
				PUSH {r0,r1,r2,r3,r4,r5,r7,r8,r9,r10}
				PUSH {r6}
				LDR r0,[r6] ;OPERANDO 1
				LDR r1,[r6,#4];OPERANDO 2
				LDR r5,=0x0 ;AZZERO REGISTRO DESTINAZIONE
				LDR r2,=0xFF ;MASCHERA BIT A 1 NEGLI 8 MENO SIGNIFICATIVI
				LDR r10,=0x0      
CICLO2
				AND r3,r0,r2 ;r0 MASCHERATO 
				AND r4,r1,r2 ;r1 MASCHERATO
				CMP r3,r4 ;GUARDO QUALE TRA I DUE E' MAGGIORE
				BCC OP2MAGOP1 ;SALTA SE IL SECONDO OPERANDO E' MAGGIORE DEL PRIMO, CONTROLLO TRA UNSOGNED
				SUB r6,r3,r4 ;SOTTRAZIONE OP1-OP2
				B CONTINUE
OP2MAGOP1
				SUB r6,r4,r3 ;SOTTRAZIONE OP2-OP1
CONTINUE
				LSR r6,r6,r10
				ADD r5,r5,r6
				LSL r2,r2,#8 ;SHIFTO MASCHERA DI UN BYTE
				ADD r10,r10,#8
				CMP r2,#0x0 ;CONDIZIONE DI TERMINAZIONE QUANDO FF HA SHIFTATO A DESTRA 4 VOLTE (DIVENTA ZERO)
				BNE CICLO2
				POP {r6}
				STR r5,[r6,#8] ;IN r5 IL RISULTATO DELLA FUNZIONE, LO SALVO NELLA TERZA WORD DELLA MIA VARIABILE RW
				POP {r0,r1,r2,r3,r4,r5,r7,r8,r9,r10}
				POP {PC} 
				
mySMUAD
				PUSH {LR}
				PUSH {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12} 
				LDR r0,[SP,#60] ;PRENDO OPERANDI DALLO STACK
				LDR r1,[SP,#64]
				LDR r2,=0xFFFF ;MASCHERA BIT A 1 NEI 16 MENO SIGNIFICATIVI
				AND r3,r0,r2 ;r0 MASCHERATO L
				AND r4,r1,r2 ;r1 MASCHERATO L
				LSL r2,r2,#16 ;SPOSTO MASCHERA SU 16 BIT ALTI, LA USERO' ANCHE PER ESTENDERE SEGNO -
				MOV r10,#32768 ;MASCHERA 2^16 PER CONTROLLARE SEGNO
				AND r8,r10,r3 ;AND TRA MASCHERA E r3
				AND r9,r10,r4 ;AND TRA MASCHERA E r4
				CMP r8,r10 ;CONFRONTA RISULTATO AND CON MASCHERA: SE UGUALI E' NEGATIVO
				BNE POSITIVOr3L
				ADD r3,r3,r2 ;NEGATIVO: ESTENDO IL SEGNO
POSITIVOr3L
				CMP r9,r10 ;CONFRONTA RISULTATO AND CON MASCHERA: SE UGUALI E' NEGATIVO
				BNE POSITIVOr4L
				ADD r4,r4,r2 ;NEGATIVO: ESTENDO IL SEGNO
POSITIVOr4L
				MUL r6,r3,r4 ;RISULTATO r0L*r1L
				MOV r7,r6 ;COPIO IL RISULTATO PER LA SECONDA FUNZIONE
				AND r3,r0,r2 ;r0 MASCHERATO H
				AND r4,r1,r2 ;r1 MASCHERATO H
				LSR r3,r3,#16 ;SPOSTO A DESTRA
				LSR r4,r4,#16 ;SPOSTO A DESTRA
				AND r8,r10,r3 ;AND TRA MASCHERA r7 E r3
				AND r9,r10,r4 ;AND TRA MASCHERA r7 E r4
				CMP r8,r10 ;CONFRONTA RISULTATO AND CON MASCHERA: SE UGUALI E' NEGATIVO
				BNE POSITIVOr3H
				ADD r3,r3,r2 ;NEGATIVO: ESTENDO IL SEGNO
POSITIVOr3H
				CMP r9,r10 ;CONFRONTA RISULTATO AND CON MASCHERA: SE UGUALI E' NEGATIVO
				BNE POSITIVOr4H
				ADD r4,r4,r2 ;NEGATIVO: ESTENDO IL SEGNO
POSITIVOr4H
				MUL r5,r3,r4 ;RISULTATO r0H*r1H			
				ADD r6,r6,r5 ;SOMMO I RISULTATI(SMUAD)
				STR r6,[SP,#56] ;SALVO RISULTATO NELLO STACK AL POSTO DEL PRIMO OPERANDO
				POP {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12}
				POP {PC}	
				
mySMUSD
				PUSH {LR}
				PUSH {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12} 
				LDR r0,[SP,#60] ;PRENDO OPERANDI DALLO STACK
				LDR r1,[SP,#64]
				LDR r2,=0xFFFF ;MASCHERA BIT A 1 NEI 16 MENO SIGNIFICATIVI
				AND r3,r0,r2 ;r0 MASCHERATO L
				AND r4,r1,r2 ;r1 MASCHERATO L
				LSL r2,r2,#16 ;SPOSTO MASCHERA SU 16 BIT ALTI, LA USERO' ANCHE PER ESTENDERE SEGNO -
				MOV r10,#32768 ;MASCHERA 2^16 PER CONTROLLARE SEGNO
				AND r8,r10,r3 ;AND TRA MASCHERA E r3
				AND r9,r10,r4 ;AND TRA MASCHERA E r4
				CMP r8,r10 ;CONFRONTA RISULTATO AND CON MASCHERA: SE UGUALI E' NEGATIVO
				BNE POSITIVOr3LSMUSD
				ADD r3,r3,r2 ;NEGATIVO: ESTENDO IL SEGNO
POSITIVOr3LSMUSD
				CMP r9,r10 ;CONFRONTA RISULTATO AND CON MASCHERA: SE UGUALI E' NEGATIVO
				BNE POSITIVOr4LSMUSD
				ADD r4,r4,r2 ;NEGATIVO: ESTENDO IL SEGNO
POSITIVOr4LSMUSD
				MUL r6,r3,r4 ;RISULTATO r0L*r1L
				MOV r7,r6 ;COPIO IL RISULTATO PER LA SECONDA FUNZIONE
				AND r3,r0,r2 ;r0 MASCHERATO H
				AND r4,r1,r2 ;r1 MASCHERATO H
				LSR r3,r3,#16 ;SPOSTO A DESTRA
				LSR r4,r4,#16 ;SPOSTO A DESTRA
				AND r8,r10,r3 ;AND TRA MASCHERA r7 E r3
				AND r9,r10,r4 ;AND TRA MASCHERA r7 E r4
				CMP r8,r10 ;CONFRONTA RISULTATO AND CON MASCHERA: SE UGUALI E' NEGATIVO
				BNE POSITIVOr3HSMUSD
				ADD r3,r3,r2 ;NEGATIVO: ESTENDO IL SEGNO
POSITIVOr3HSMUSD
				CMP r9,r10 ;CONFRONTA RISULTATO AND CON MASCHERA: SE UGUALI E' NEGATIVO
				BNE POSITIVOr4HSMUSD
				ADD r4,r4,r2 ;NEGATIVO: ESTENDO IL SEGNO
POSITIVOr4HSMUSD
				MUL r5,r3,r4 ;RISULTATO r0H*r1H
				SUB r7,r7,r5 ;SOTTRAGGO I RISULTATI(SMUSD)    
				STR r7,[SP,#56] ;SALVO RISULTATO NELLO STACK AL POSTO DEL PRIMO OPERANDO
				POP {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12}
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
