;Cada pixel [15:0] tiene [15] para que ser invisible, [14:10] para color rojo 
;[9:5] para color verde y [4:0] para el color azul y que cada uno de estos pixeles 
;tiene las coordenadas (x,y) siendo X el número de la fila e Y el número de la columna
;Para calcular el espacio en memoria que ocuparía se hace (xC000 + (X*x0080) + Y)

;Funciones a hacer dentro de este archivo: RENDER,CHECK_POS 
;funciones hechas: RENDER, CHECK_INVIS

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
 
  ;funcion para dibujar un sprite en pantalla
RENDER
LD R6, ROW          ;carga en R6 valor desplazamiento por fila
ADD R4,R4, #1       ;incrementa R4 para avanzar al siguiente pixel
LDR R5,R4, #0       ;craga el valor actual del pixel desde R4
BRn CHECK_INVIS     ;R5 valor negativo, salta a CHECK_INVIS para omitir pixel
STR R5,R3, #0       ;R5 no negativo, se almacena en panatlla en R3

CHECK_INVIS         
ADD R3,R3, #1       ;aumenta R3 en 1 para avanzar a la siguient direccion en pantalla
ADD R1,R1, #-1      ;disminuye R1 (ancho spirte) en 1 
BRp RENDER          ;si quedan columnas (R1 > 0) vuelve a RENDER

ADD R3, R3, R6      ;Avanza una fila completa (incrementa R3 en ROW)
LDR R1, R0, #0      ;restaura valor original del ancho (desde R0)
NOT R6, R1          ;calcula el complemento de R1 y lo almacena en R6
ADD R6, R6, #1      ;aumenta R6 en 1 (realiza la operacion de -R1)
ADD R3, R3, R6      ;ajusta R3 para alinear la dirección de inicio de la siguiente fila en pantalla
ADD R2,R2, #-1      ;disminuye la altura del sprite
BRp RENDER          ;si quedan filas (R2 > 0) vuelve al inicio de RENDER

  ;funcion para borrar un sprite 
UNRENDER
LD R6, ROW          ;carga en R6 valor desplazamiento por fila
LD R5, BLACK        ;carga en R5 el color negro (BLACK) para "borrar" un pixel
STR R5,R3, #0       ;almacena el valor de R5 (negro) en la pantalla en la dirección indicada por R3
ADD R3, R3, #1      ;aumenta R3 en 1 para avanzar a la siguiente direccion en pantalla
ADD R1, R1, #-1     ;disminuye R1 (ancho sprite) en 1
BRp UNRENDER        ;si quedan columnas por borrar en la fila (R1 > 0), vuelve a UNRENDER

ADD R3, R3, R6      ;avanza una fila completa (incrementa R3 en ROW)
LDR R1, R0, #0      ;restaura valor original del ancho (desde R0)
NOT R6, R1          ;Calcula el complemento de R1 y lo almacena en R6
ADD R6, R6, #1      ;aumenta R6 en 1 (esto efectúa la operación de -R1)
ADD R3, R3, R6      ;ajusta R3 para alinear la dirección de inicio de la siguiente fila en pantalla
ADD R2,R2, #-1      ;disminuye la altura del sprite (R2)
BRp UNRENDER        ;Si quedan filas por borrar (R2 > 0), vuelve a UNRENDER
ret                 ;Retorna del subprograma UNRENDER

PANTALLA      .FILL xC000      ;direccion de la pantalla
ROW           .FILL x0080      ;valor de desplazamiento por fila
BLACK         .FILL x0000      ;valor color negro

  ;funcion para apuntar al primer pixel donde comienza el dibujo (renderizado)
FIRST_PIXEL
LD R3, PANTALLA     ;carga el valor base de la pantalla
LD R6, ROW          ;carga el desplazamiento por fila
ADD R3, R3, R1      ;ajusta R3 para la posicion inicial del ancho
ADD R2, R2, #0      ;añade 0 a R2 para verificar si es cero
BRz END_FSTPXL      ;si la altura es 0 (R2), salta a END_FSTPXL
SUM_ALTO
ADD R3, R3, R6      ;avanza una fila completa (incrementa R3 en ROW)
ADD R2, R2, #-1     ;decrementa R2 en 1 (proceso de ajuste en altura)
BRp SUM_ALTO        ;si altura no llego a cero (R2 > 0), vuelve a SUM_ALTO
END_FSTPXL
ret                 ;retornar a FISRT_PIXEL
