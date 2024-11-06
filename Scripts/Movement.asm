;Aquí se realizarán las funciones que permitan moverse al avión principal

;Funciones a hacer: MOVEMENT, CHECK_RANGE, PLANE_RENDER, MOVE

; Funciones hechas:
; MOVEMENT        - Inicia la acción de movimiento y verifica los inputs. 
; MOVE            - Determina el tipo de movimiento basandose en la tecla presionada. 
; PLANE_RENDER    - Dibuja (renderiza) el avión en la pantalla. 
; PLANE_UNRENDER  - Borra el avión de la pantalla. 

;IDEA 
;al detectar un imput ejecutar la funcion de movimiento 
;la misma consta de revisar si el imput coincide con alguna direccion de movimiento
;y de ser ese el caso actualizar el avion 
;registros:
;R0 = input
;R1 = pos x del avion
;R2 = pos y del avion
;R3 = registro aux usado para comparar ASCIIs de movimiento
;R4 = detector de inputs
;R5 = mascara usada para imputs 
;R6 = segundo registro aux para comparar teclas

MOVEMENT                  ;detectar un input y, de ser así, ealizar movimiento correspondiente
ST R1, SAVE_R1            ;guarda las cooredenadas actuales del avión
ST R2, SAVE_R2
LD R5, MASK               ;carga el valor de la mascara
LDI R4, DETECTOR_INPUT    ;verifica si hay un input
BRn MOVE                  ;si encuentra un input, ejecuta move para analizar tipo de movimiento
BRnzp END_MOVE            ;si no hay input termina MOVEMENT

MOVE                      ;procesa el input y verifica si corresponde a alguna tecla (A, W, D, S)
LDI R0, KEYBOARD_INPUT    ;carga el valor y lo filtra con la mascara
AND R0, R0, R5

A_MOVE_CHECK              ;compara si el valor en R0 coincide con el ASCII de la letra (en este caso: `A`)
AND R6, R6, 0
ADD R6, R6, R0
LD R3 , ASCII_A
ADD R6, R6, R3
BRz A_MOVE

W_MOVE_CHECK              ;compara si el valor en R0 coincide con el ASCII de la letra (en este caso: `W`)
AND R6, R6, 0
ADD R6, R6, R0
LD R3 , ASCII_W
ADD R6, R6, R3
BRz W_MOVE

D_MOVE_CHECK              ;compara si el valor en R0 coincide con el ASCII de la letra (en este caso: `D`)
AND R6, R6, 0
ADD R6, R6, R0
LD R3 , ASCII_D
ADD R6, R6, R3
BRz D_MOVE

S_MOVE_CHECK              ;compara si el valor en R0 coincide con el ASCII de la letra (en este caso: `S`)
AND R6, R6, 0
ADD R6, R6, R0
LD R3 , ASCII_S
ADD R6, R6, R3
BRz S_MOVE

A_MOVE                    ;detecta `A`? entonces decrementa R1 para mover hacia izquierda
ADD R1, R1, 0
BRz END_MOVE
ADD R1, R1, #-1
BRnzp END_MOVE

W_MOVE                    ;detecta `W`? entonces decrementa R2 para mover hacia arriba
ADD R2, R2, 0
BRz END_MOVE
ADD R2, R2, #-1
BRnzp END_MOVE

D_MOVE                    ;detecta `D`? entonces incrementa R1 para mover hacia derecha y verifica que no exceda abscisas (X_MAX)
LD R5, X_MAX
ADD R5, R5, R1
BRz END_MOVE
ADD R1, R1, #1
BRnzp END_MOVE

S_MOVE                    ;detecta `S`? entonces incrementa R1 para mover hacia abajo y verifica que no exceda ordenadas (Y_MAX)
LD R5, X_MAX
ADD R5, R5, R1
BRz END_MOVE
ADD R2, R2, #1
BRnzp END_MOVE

END_MOVE
ret

PLANE_RENDER              ;dibujar el avion en posicion actual
ST R1, SAVE_R1
ST R2, SAVE_R2
ST R7, SAVE_R7

JSR FIRST_PIXEL           ;ubiaca el primer pixel del avion
LEA R0, PLANE             ;direccion de los datos del avion en R0
LDR R1,R0, #0             ;
LDR R2,R0, #1             ;
LEA R4, PLANE_PIXELS      ;
ADD R4, R4, #-1           ;ajusta direccion del primer pixel
JSR RENDER                ;llama a RENDER para dibujar avion en pantalla

  ;restaurar valores originales
LD R1, SAVE_R1            
LD R2, SAVE_R2
LD R7, SAVE_R7
ret

  ;borrar al avion de su actual ubicacion
PLANE_UNRENDER
ST R1, SAVE_R1
ST R2, SAVE_R2
ST R7, SAVE_R7

JSR FIRST_PIXEL
LEA R0, PLANE
LDR R1,R0, #0
LDR R2,R0, #1
JSR UNRENDER

LD R1, SAVE_R1
LD R2, SAVE_R2
LD R7, SAVE_R7
ret

DETECTOR_INPUT      .FILL   xFE00
KEYBOARD_INPUT      .FILL   xFE02       ;direccion de memoria input
ASCII_A             .FILL #-97          ;valor ASCII `A`
ASCII_W             .FILL #-119         ;valor ASCII `W`
ASCII_D             .FILL #-100         ;valor ASCII `D`
ASCII_S             .FILL #-115         ;valor ASCII `S`
MASK                .FILL x00FF
X_MAX               .FILL #-117         ;valor máximo "eje abscisas" (ancho display)
Y_MAX               .FILL #-116         ;valor máximo "eje ordenadas" (largo display)
