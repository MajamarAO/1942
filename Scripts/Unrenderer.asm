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

    ;funcion para "borrar" un sprite (pinta de negro cada pixel tomando la direccion inicial del sprite R3)
UNRENDER                          
LD R6, ROW                        ;carga tamaño de la fila
LD R5, BLACK                      ;carga el color negro (valor BLACK)
STR R5,R3, #0                     ;"pinta" de negro en la posicion de R3
ADD R1,R1, #-1                    ;disminuye el ancho (R1) en 1 para avanzar en fila
BRp UNRENDER                      ;si aun hay columnas restantes (R1 > 0), vuelve a UNRENDER
    ;salto a siguiente fila
ADD R3, R3, R6                    ;aumenta R3 al tamaño de la fila
LDR R1, R0, #0                    ;carga el ancho original 
    ;ajustar alto
NOT R6, R1                       ;calcula -R1
ADD R6, R6, #1
ADD R3, R3, R6
ADD R2,R2, #-1                    ;disminuye el alto en 1
BRp UNRENDER                      ;si aun hay fila restantes (R2 > 0) vuelve a UNRENDER


PANTALLA     .FILL xC000          ;valor direccion de la pantalla
ROW          .FILL x0080          ;valor de desplazamiento por fila
BLACK        .FILL x0000          ;valor color negro

FIRST_PIXEL
LD R3, PANTALLA                   ;carga la direcion base de la pantalla
LD R6, ROW                        ;carga el tamaño de la fila
ADD R3, R3, R1                    ;ajusta el ancho segun R1
ADD R2, R2, #0                    ;carag cero (0) para verificar
BRz END_FSTPXL                    ;si R2 es cero (0) entonces la altura termino y salta a END_FSTPXL
SUM_ALTO
ADD R3, R3, R6                    ;avanza una fila completa
ADD R2, R2, #-1                   ;disminuye la altura en 1 
BRp SUM_ALTO                      ;si la altura no llego a 0 (R2 > 0) vuelve a SUM_ALTO
END_FSTPXL
ret
