.model small
.stack
.data

N EQU 4 ; righe mat1
M EQU 7 ; colonne mat1, righe mat2
P EQU 5 ; colonne mat2

MAT1 DB 3, 14,-15, 9, 26,-53, 5, 89, 79, 3, 23, 84, -6, 26, 43, -3, 83, 27, -9, 50, 28, -88, 41, 97, -103, 69, 39, -9
MAT2 DB 37, -101, 0, 58, -20, 9, 74, 94, -4, 59, -23, 90, -78, 16, -4, 0, -62, 86, 20, 89, 9, 86, 28, 0, -34, 82, 5, 34, -21, 1, 70, -67, 9, 82, 14
MAT3 DW N*P DUP (0) ;risultato

cicloN DB ? ;indice riga mat1 e riga mat3, [0->N-1] progressivo
cicloM DB ? ;contatore riga mat2 e colonna mat1 [0->M-1] progressivo 
cicloP DB ? ;indice colonna mat2 e colonna mat3, [0->P-1] progressivo

.code                           
.startup 
           
MOV cicloN,0
CICLO1: ;cicla su cicloN
    MOV cicloP,0 
    CICLO2: ;cicla su cicloP 
        MOV cicloM,0
        XOR CX,CX
        CICLO3: ;cicla su cicloM
            XOR AX,AX
            MOV AL,cicloN
            MOV DX,M
            MUL DX
            ADD AL,cicloM
            MOV SI,AX ;offset in MAT1: cicloN*M
            XOR AX,AX
            MOV AL,cicloM 
            MOV DX,P
            MUL DX
            ADD AL,cicloP
            MOV BX,AX ;offset in MAT2: cicloM*P
            MOV AL,MAT1+SI
            IMUL MAT2+BX ;in AX risultato moltiplicazione tra elementi mat1*mat2 
            ADD CX,AX ;aggiungo risultato parziale
            JNO NOOVERFLOW ;controlla overflow
            MOV CX,32767 ;mette 32767 se c'e' stato overflow 
            MOV cicloM,M ;break in caso di of
            DEC cicloM
            NOOVERFLOW: 
        INC cicloM  
        CMP cicloM,M
        JE FINECICLO3
        JMP CICLO3 ;ricorrenza CICLO3
        FINECICLO3:; treminazione per cicloP == P
        XOR AX,AX
        MOV AL,cicloN ;offset in mat3: cicloN*P+ciclop
        MOV BL,P
        MUL BL
        ADD AL,cicloP
        MOV BL,2 ;mat3 e' in DW moltiplico offest *2
        MUL BL
        MOV BX,AX 
        MOV MAT3+BX,CX ;aggiungo risultato al precedente in mat3 
    INC cicloP
    CMP cicloP,P
    JE FINECICLO2
    JMP CICLO2  ;ricorrenza CICLO2
    FINECICLO2: ; treminazione per cicloM == M
INC cicloN
CMP cicloN,N
JE FINECICLO1
JMP CICLO1  ;ricorrenza CICLO1
FINECICLO1: ; treminazione per cicloN == N

.exit
end