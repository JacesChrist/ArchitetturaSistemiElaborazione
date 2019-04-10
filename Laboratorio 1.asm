.model small
.stack
.data

row1 DB 50 DUP (?) 
  
minuscole1 DB 26 DUP (0) 
maiuscole1 DB 26 DUP (0) 
 
maxrow1 DB ?

caesar1 DB 27 ;27 coincide con shift di 1                       

.code
.startup  

;ACQUISIZIONE STRINGA 1  

XOR SI,SI  
MOV AH,01h
LOOP_INPUT1: 
CMP SI,50
JE ERROREmax50 ;superata la lunghezza massima
INT 21h       
MOV row1[SI],AL ;inserimento in vettore stringa
INC SI
CMP AL,13
JNE LOOP_INPUT1 ;loop acquisizione
MOV AH,02h
MOV DX,13
INT 21h ;stampa carattere preso
MOV DX,10
INT 21h  

MOV row1[49],13 ;mette alla fine del vettore il terminatore (tronca una lettera)
ERROREmax50: ;prende fino a 50 e poi va avanti (metti/togli ; anche linea sopra)      

;CONTA OCCORRENZE STRINGA 1
    
XOR SI,SI
DEC SI
LOOP_CONTA1: 
INC SI 
CMP SI,26
JE FINE_CONTA1 ;terminazione incremento sul vettore delle lettere
CMP row1[SI],13
JE FINE_CONTA1 ;terminatore stringa
CMP row1[SI],32
JE LOOP_CONTA1 ;spazio non conta, loppa avanti
CMP row1[SI],92 
JG MINUSCOLA1 ;>< 92 discrimina minuscole da maiuscole
XOR BX,BX ;maiusola
MOV BL,row1[SI]
MOV DI,BX
SUB DI,65 ;calcolo indirizzo sul vettore lettere
INC maiuscole1[DI] ;incrementa contatore lettera
JMP LOOP_CONTA1
MINUSCOLA1: ;minuscola
XOR BX,BX
MOV BL,row1[SI]
MOV DI,BX
SUB DI,97 ;calcolo indirizzo sul vettore lettere
INC minuscole1[DI] ;incrementa contatore lettera
JMP LOOP_CONTA1
FINE_CONTA1:

;CONTA MAX STRINGA 1 MINUSCOLE  

XOR SI,SI
DEC SI
MOV maxrow1,0
LOOP_MAX1min:    
INC SI   
CMP SI,26
JE FINEmax1min ;fine vettore
MOV AL,minuscole1[SI]
CMP AL,maxrow1 ;confronto valore attuale-valore vettore
JLE LOOP_MAX1min: 
MOV maxrow1,AL 
JMP LOOP_MAX1min
FINEmax1min:      

;CONTA MAX STRINGA 1 MAIUSCOLE 

XOR SI,SI
DEC SI
LOOP_MAX1M:    
INC SI   
CMP SI,26
JE FINEmax1M ;fine vettore
MOV AL,maiuscole1[SI]
CMP AL,maxrow1 ;confronto valore attuale-valore vettore
JLE LOOP_MAX1M: 
MOV maxrow1,AL 
JMP LOOP_MAX1M
FINEmax1M: 

;CARATTERI MAX/2 VOLTE 1 MINUSCOLE  

XOR SI,SI  
DEC SI;parte da -1 incrementato ogni volta
XOR AX,AX
MOV AL,maxrow1
MOV BL,2
DIV BL
CMP AH,0
JE NORESTO1min
INC AL
NORESTO1min:
MOV BL,AL;in BL il /2
LOOP_MAX21min: 
INC SI 
CMP SI,26;terminazione fine vettore
JE FINEmax21min
CMP minuscole1[SI],BL;verifica maggiore /2
JL LOOP_MAX21min;jumpa su se minore
MOV AH,02h
MOV DX,SI
ADD DX,97
INT 21h;stampa lettera
MOV DX,32
INT 21h;spazio 
XOR DX,DX
CMP minuscole1[SI],9
JLE MIN101min 
MOV DX,62
INT 21h
MOV DX,57
INT 21h
JMP ACAPO1min
MIN101min:
MOV DL,minuscole1[SI] 
ADD DX,48
INT 21h;stampa numero occorrenze lettera
ACAPO1min:
MOV DX,13
INT 21h
MOV DX,10
INT 21h;a capo
JMP LOOP_MAX21min
FINEmax21min:     

;CARATTERI MAX/2 VOLTE 1 MAIUSCOLE

XOR SI,SI  
DEC SI;parte da -1 incrementato ogni volta
XOR AX,AX
MOV AL,maxrow1
MOV BL,2
DIV BL
CMP AH,0
JE NORESTO1M
INC AL
NORESTO1M:
MOV BL,AL;in BL il /2
LOOP_MAX21M: 
INC SI 
CMP SI,26;terminazione fine vettore
JE FINEmax21M
CMP maiuscole1[SI],BL;verifica maggiore /2
JL LOOP_MAX21M;jumpa su se minore
MOV AH,02h
MOV DX,SI
ADD DX,65
INT 21h;stampa lettera
MOV DX,32
INT 21h;spazio 
XOR DX,DX
CMP maiuscole1[SI],9
JLE MIN101M 
MOV DX,62
INT 21h
MOV DX,57
INT 21h
JMP ACAPO1M
MIN101M:
MOV DL,maiuscole1[SI] 
ADD DX,48
INT 21h;stampa numero occorrenze lettera
ACAPO1M:
MOV DX,13
INT 21h
MOV DX,10
INT 21h;a capo
JMP LOOP_MAX21M
FINEmax21M:  

;CAESAR 1

CMP caesar1,26
JLE NONMAG26 ;se maggiore di 26 divido per 26
XOR AX,AX
MOV AL,caesar1  
MOV BL,26
DIV BL
MOV caesar1,AH
NONMAG26: ;caesar1<26 
XOR SI,SI
DEC SI   
MOV AH,02h
CICLOCAESAR1: 
INC SI
CMP row1[SI],32
JNE NONSPAZIO1 ;se spazio metto spazio e looppo avanti
MOV DX,32
INT 21h
JMP CICLOCAESAR1
NONSPAZIO1: 
CMP SI,50
JE FINECAESAR1
CMP row1[SI],13
JE FINECAESAR1  
XOR DX,DX
MOV DL,row1[SI]
CMP DL,92 ;><92 discrimina minuscole maiuscole
JL MAIUSCOLACAESAR1
ADD DL,caesar1
CMP DL,122
JLE NONOLTREZmin1
SUB DL,26 ;se sfora le lettere sottrai 26
NONOLTREZmin1:
INT 21h
JMP CICLOCAESAR1:
MAIUSCOLACAESAR1:
ADD DL,caesar1
CMP DL,90
JLE NONOLTREZM1
SUB DL,26 ;se sfora le lettere sottrai 26
NONOLTREZM1:
INT 21h
JMP CICLOCAESAR1
FINECAESAR1: 

;ERROREmax50: ;errore 50 sforati termina programma (metti/togli ;)       

.exit
end