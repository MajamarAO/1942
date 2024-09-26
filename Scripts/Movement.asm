;Aquí se realizarán las funciones que permitan moverse al avión principal

;Funciones a hacer: MOVEMENT, CHECK_RANGE, PLANE_RENDER, MOVE

;IDEA 
;al detectar un imput ejecutar la funcion de movimiento 
;la misma consta de revisar si el imput coincide con alguna direccion de movimiento
;y de ser ese el caso actualizar el avion 
;registros:
;R0 = input
;R1 = pos x del avion
;R2 = pos y del avion
;R3 = usado para comparar ASCIIs de movimiento
;R4 = detector de inputs
;R5 = mascara usada para imputs

MOVEMENT
ST R1, SAVE_R1
ST R2, SAVE_R2
LD R5, MASK
LDI R4, DETECTOR_INPUT
BRn MOVE
BRnzp END_MOVE

MOVE
LDI R0, KEYBOARD_INPUT
AND R0, R0, R5

A_MOVE_CHECK
AND R6, R6, 0
ADD R6, R6, R0
LD R3 , ASCII_A
ADD R6, R6, R3
BRz A_MOVE

W_MOVE_CHECK
AND R6, R6, 0
ADD R6, R6, R0
LD R3 , ASCII_W
ADD R6, R6, R3
BRz W_MOVE

D_MOVE_CHECK
AND R6, R6, 0
ADD R6, R6, R0
LD R3 , ASCII_D
ADD R6, R6, R3
BRz D_MOVE

S_MOVE_CHECK
AND R6, R6, 0
ADD R6, R6, R0
LD R3 , ASCII_S
ADD R6, R6, R3
BRz S_MOVE

A_MOVE
ADD R1, R1, 0
BRz END_MOVE
ADD R1, R1, #-1
BRnzp END_MOVE

W_MOVE
ADD R2, R2, 0
BRz END_MOVE
ADD R2, R2, #-1
BRnzp END_MOVE

D_MOVE
LD R5, X_MAX
ADD R5, R5, R1
BRz END_MOVE
ADD R1, R1, #1
BRnzp END_MOVE

S_MOVE
LD R5, X_MAX
ADD R5, R5, R1
BRz END_MOVE
ADD R2, R2, #1
BRnzp END_MOVE

END_MOVE
ret

PLANE_RENDER
ST R1, SAVE_R1
ST R2, SAVE_R2
ST R7, SAVE_R7

JSR FIRST_PIXEL
LEA R0, PLANE
LDR R1,R0, #0
LDR R2,R0, #1
LEA R4, PLANE_PIXELS
ADD R4, R4, #-1
JSR RENDER

LD R1, SAVE_R1
LD R2, SAVE_R2
LD R7, SAVE_R7
ret

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
KEYBOARD_INPUT      .FILL   xFE02
ASCII_A             .FILL #-97
ASCII_W             .FILL #-119 
ASCII_D             .FILL #-100
ASCII_S             .FILL #-115
MASK                .FILL x00FF
X_MAX               .FILL #-117
Y_MAX               .FILL #-116
