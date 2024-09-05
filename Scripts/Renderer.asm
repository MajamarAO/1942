;Cada pixel [15:0] tiene [15] para que ser invisible, [14:10] para color rojo 
;[9:5] para color verde y [4:0] para el color azul y que cada uno de estos pixeles 
;tiene las coordenadas (x,y) siendo X el número de la fila e Y el número de la columna
;Para calcular el espacio en memoria que ocuparía se hace (xC000 + (X*x0080) + Y)

;Funciones a hacer dentro de este archivo RENDER, PIXEL_INIT

;Ideas, pasar un sprite en memoria y que sea impreso
;deberia de funcionar para todo tamaño osea que se deberian de conocer 3 cosas: Posicion de inicio, 
;ancho y alto del sprite.


;Intento de implementacion numero 1: El sprite estara cargado en memoria y tendra:
;1- direccion en memoria del pixel inicial
;2- ancho
;3- alto
;4- El resto del dibujo en .FILL
;La direccion al sprite en si se pasaria en R0 y se cargaria R1 pos_inicial, R2 Ancho ,R3 Alto, R4 pos_actual 
;esto puede ser modificado 

EXAMPLE_RND
LD R0, EXAMPLE
LDR R0, R1, #0
LDR R0, R2, #1
LDR R0, R3, #2
LDR R0, R4. #3
LD R6, ROW
 
RENDER
STR R4,R1, #0
ADD R4,R4, #1
ADD R1,R1, #1
ADD R2,R2, #-1
BRp LOOP
LDR R0, R2, #1
NOT R5, R2
ADD R5, R5, #1
ADD R1, R1, R5
ADD R0, R0, R6
ADD R3,R3, #-1 
BRp LOOP
HALT

EXAMPLE .FILL xDD42
        .FILL 5
        .FILL 4
      
        .FILL x001F
        .FILL x001F
        .FILL x001F
        .FILL x001F
        .FILL x001F

        .FILL x001F
        .FILL x001F
        .FILL x001F
        .FILL x001F
        .FILL x001F

        .FILL x001F
        .FILL x001F
        .FILL x001F
        .FILL x001F
        .FILL x001F

        .FILL x001F
        .FILL x001F
        .FILL x001F
        .FILL x001F
        .FILL x001F
        

ROW     .FILL x0080