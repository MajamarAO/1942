;Cada pixel [15:0] tiene [15] para que ser invisible, [14:10] para color rojo 
;[9:5] para color verde y [4:0] para el color azul y que cada uno de estos pixeles 
;tiene las coordenadas (x,y) siendo X el número de la fila e Y el número de la columna
;Para calcular el espacio en memoria que ocuparía se hace (xC000 + (X*x0080) + Y)

;Funciones a hacer dentro de este archivo RENDER,CHECK_POS 

;Intento de implementacion numero 1: El sprite estara cargado en memoria y tendra:
;1- direccion en memoria del pixel inicial
;2- ancho
;3- alto
;4- El resto del dibujo en .FILL
;R0 = Direccion de memoria del sprite estatica
;R1 = Ancho
;R2 = Alto
;R3 = Dirección de escritura 
;R4 = Dirección de pixel por escribir
;R5 = Pixel a escribir
;R6 = NOT usado durante la operacion
;R7 = Columna

UNRENDER
LD R6, ROW
LD R5, INV
STR R5,R3, #0
ADD R1,R1, #-1
BRp UNRENDER
ADD R3, R3, R6
LDR R1, R0, #0
NOT R6, R1
ADD R6, R6, #1
ADD R3, R3, R6
ADD R2,R2, #-1 
BRp UNRENDER


PANTALLA     .FILL xC000
ROW          .FILL x0080
INV          .FILL xF000

FIRST_PIXEL
LD R3, PANTALLA
LD R6, ROW
ADD R3, R3, R1
ADD R2, R2, #0
BRz END_FSTPXL
SUM_ALTO
ADD R3, R3, R6
ADD R2, R2, #-1
BRp SUM_ALTO
END_FSTPXL
ret
