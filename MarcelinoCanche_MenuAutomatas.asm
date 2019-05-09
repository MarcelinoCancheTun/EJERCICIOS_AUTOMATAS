                          
;INSTITUTO TECNOLOGICO SUPERIOR DE VALLADOLID
;ISC 6B

;ELABORADO POR: MARCELINO CANCHE TUN
 

DATA SEGMENT   
    
    
 include 'emu8086.inc'
 
;MENSAJES DEL NUMERO MAYOR 

 mj1 db 0ah,0dh, 'Ingrese tres numeros del 0 al 9 : ','$'
 mj2 db 0ah,0dh, 'Primer numero: ','$'
 mj3 db 0ah,0dh, 'Segundo numero: ','$'
 mj4 db 0ah,0dh, 'Tercer numero: ', '$'
 Mayor db 0ah,0dh, 'El numero mayor es: ','$'

 Digito1 db 100 dup('$')
 Digito2 db 100 dup('$')
 Digito3 db 100 dup('$')

 salto db 13,10,'',13,10,'$' ;salto de linea  
 
 ;MENSAJES DE OPERACIONES
       
 numero1        db 0
 numero2        db 0
 suma           db 0
 resta          db 0
 multiplicacion db 0
 division       db 0

 msgn1 db  10,13, "ingresa el primer valor:",'$'
 msgn2 db  10,13, "ingresa el segundo valor:",'$'
 msg1  db  10,13,  "suma=",'$'
 msg2  db  10,13,  "resta=",'$'
 msg3  db  10,13,  "multiplicacion=",'$'
 msg4  db  10,13,  "division=",'$' 
 
 ;MENSAJES DEL MENU   
    
 MSJ1 DB 'MENU DE OPERACIONES$'
 MSJ2 DB '[1] OPERACIONES ARITMETICAS$' 
 MSJ3 DB '[2] NUMERO MAYOR$'
 MSJ6 DB 'SELECIONE UNA OPCION:$'


DATA ENDS 
    
    
CODE SEGMENT 
    INICIO:
    ASSUME DS:DATA, CS CODE   
       
    MOV AX,@DATA
    MOV DS,AX 

;PRIMERA PANTALLA
    
    MOV AH,06H
    MOV AL,0    
    MOV BH,4FH ;ROJO
    MOV CX,0000H
    MOV DX,184FH;2479  
    INT 10H  
    

;SEGUNDA PANTALLA  
    
    MOV AH,06H
    MOV AL,0    
    MOV BH,0FH ;NEGRO
    MOV CX,030AH;0510
    MOV DX,0345H;1969
    INT 10H  
       
  
;TERCERA PANTALLA  
    
    MOV AH,06H
    MOV AL,0    
    MOV BH,9FH ;AZUL
    MOV CX,060AH;0510
    MOV DX,1345H;1969
    INT 10H  
    
    
;PRIMER TEXTO
   
    MOV AH, 02H
    MOV BH,0
    MOV DH,03H 
    MOV DL,1EH
    INT 10H     
    
    MOV AH,09H 
    MOV DX,OFFSET MSJ1 
    INT 21H     
    
    
;SEGUNDO TEXTO          
            
    MOV AH, 02H
    MOV BH,0
    MOV DH,07H
    MOV DL,0EH 
    INT 10H    
    
    MOV AH,09H 
    MOV DX,OFFSET MSJ2 
    INT 21H  
      
    
;TERCER TEXTO    
    
    MOV AH, 02H
    MOV BH,0
    MOV DH,0AH
    MOV DL,0EH
    INT 10H  
    
    MOV AH,09H 
    MOV DX,OFFSET MSJ3 
    INT 21H   

    
;SEXTO TEXTO PARA SELECIONAR    
    
    MOV AH, 02H
    MOV BH,0
    MOV DH,15H
    MOV DL,2EH
    INT 10H  
    
    MOV AH,09H 
    MOV DX,OFFSET MSJ6 
    INT 21H 
       

PAG:
   
MOV AH,0H
INT 16H 

CMP AL,"1"
JE ARITMETICAS

CMP AL,"2"
JE MAYORMENOR 
  
JMP FIN  


ARITMETICAS: 

MOV AH,05H
MOV AL,1
INT 10H

MOV AH, 06H
MOV AL, 0
 
MOV BH,5FH ;ROJO
MOV CX,0000H
MOV DX,184FH;2479  
INT 10H 


 mov ah, 9
 lea dx, msgn1
 int 21h
 mov ah, 1
 int 21h
 sub al, 30h
 mov numero1, al

 mov ah, 9
 lea dx, msgn2
 int 21h
 mov ah, 1
 int 21h
 sub al, 30h
 mov numero2, al

 mov al, numero1
 add al, numero2
 mov suma, al

 mov al, numero1
 sub al, numero2
 mov resta, al

 mov al, numero1
 mul numero2
 mov multiplicacion, al

 mov al, numero1
 div numero2
 mov division, al

 
 mov ah, 9
 lea dx, msg1
 int 21h
 mov dl, suma
 add dl, 30h
 mov ah, 2
 int 21h

 mov ah, 9
 lea dx, msg2
 int 21h
 mov dl, resta
 add dl, 30h
 mov ah, 2
 int 21h

 mov ah, 9
 lea dx, msg3
 int 21h
 mov dl, multiplicacion
 add dl, 30h
 mov ah, 2
 int 21h

 mov ah, 9 
 lea dx, msg4
 int 21h
 mov dl, division
 add dl, 30h
 mov ah, 2
 int 21h


MOV AH, 0H
INT 16H
CMP AL, 008
JE ATRAS
JMP FIN 

JMP FIN

MAYORMENOR:
MOV AH,05H
MOV AL,1
INT 10H

 
MOV AH, 06H
MOV AL, 0
MOV BH, 6FH
MOV CX, 0000H;0, 0
MOV DX, 184FH;24,79
INT 10H

mov ah,09
mov dx,offset mj1 ;Imprimimos el msj1
int 21h

call saltodelinea;llamamos el metodo saltodelinea.

call pedircaracter ;llamamos al metodo

mov Digito1,al ;lo guardado en AL a digito1

call saltodelinea

call pedircaracter

mov Digito2,al

call saltodelinea

call pedircaracter

mov Digito3,al

call saltodelinea

;*******************************COMPARAR*****************************************

mov ah,digito1
mov al,digito2
cmp ah,al ;compara primero con el segundo
ja compara-1-3 ;si es mayor el primero, ahora lo compara con el tercero
jmp compara-2-3 ;si el primero no es mayor,ahora compara el 2 y 3 digito
compara-1-3:
mov al,digito3 ;ah=primer digito, al=tercer digito
cmp ah,al ;compara primero con tercero
ja mayor1 ;si es mayor que el tercero, entonces el primero es mayor que los 3

compara-2-3:
mov ah,digito2
mov al,digito3
cmp ah,al ;compara 2 y 3, YA NO es necesario compararlo con el 1,porque ya sabemos que el 1 no es mayor que el 2
ja mayor2 ;Si es mayor el 2,nos vamos al metodo para imprimirlo
jmp mayor3 ;Si el 2 no es mayor, obvio el 3 es el mayor

 
mayor1:

call MensajeMayor ;llama al metodo que dice: El digito mayor es:

mov dx, offset Digito1 ;Imprir El Digito 1 es mayor
mov ah, 9
int 21h
jmp exit

mayor2:
call MensajeMayor

mov dx, offset Digito2 ;Salto de linea
mov ah, 9
int 21h
jmp exit

mayor3:
call MensajeMayor

mov dx, offset Digito3 ;Salto de linea
mov ah, 9
int 21h
jmp exit

;********************************METODOS*****************************************

MensajeMayor:
mov dx, offset Mayor ;El digito Mayor es:
mov ah, 9
int 21h

ret
pedircaracter:
mov ah,01h; pedimos primer digito
int 21h
ret

saltodelinea:
mov dx, offset salto ;Salto de linea
mov ah, 9
int 21h
ret

exit:

MOV AH, 0H
INT 16H
CMP AL, 008
JE ATRAS
JMP FIN 
   

;FINALIZAR 

ATRAS:
        MOV AH, 05H
        MOV AL, 0
        INT 10H
        JMP PAG 
        
    
    FIN:
        INT 21H  
   
CODE ENDS
END INICIO