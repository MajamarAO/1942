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
;R0 = Direccion de memoria del sprite estatica
;R1 = Dirección de escritura 
;R2 = Ancho
;R3 = Alto
;R4 = Pixel a escribir
;R5 = Dirección de pixel por escribir
;

 
RENDER
ADD R5,R5, #1
LDR R4,R5, #0
BRn CHECK_INVIS
STR R4,R1, #0
CHECK_INVIS
ADD R1,R1, #1
ADD R2,R2, #-1
BRp RENDER
LDR R2, R0, #1 
NOT R6, R2
ADD R6, R6, #1
ADD R1, R1, R6
ADD R1, R1, R7
ADD R3,R3, #-1 
BRp RENDER
HALT

ROW     .FILL x0080
