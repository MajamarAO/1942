;IDEA que haya 3 disparos maximos en simultaneo y que cuando uno llegue 
;a colisionar o al final de la pantalla se borre y salga uno nuevo formando un ciclo de 3 disparos
;Problema: si uno se mantiene cerca del borde superior de la pantalla estaria disparando muchisimos disparos ya que 
;llegarian todos al borde de la pantalla 


;IDEA2 que se lanzen disparos con cierta periodicidad, se necesita de un clock, se veria que la periodicidad permita
;como peor caso 3-5 disparos (a mas disparos, mas tedioso y tardado es el renderizado de dichos disparos) 

SHOOTING
ST R1, SAVE_R1
ST R2, SAVE_R2
ST R7, SAVE_R7_PLUS

LD R6, SHOT1_FLAG
BRn FST_SHOT
BRzp SHOOT_SHOT1

FST_SHOT

LD R1, SHOT1_X_POS
LD R2, SHOT1_Y_POS
JSR SHOT_UNRENDERER

LD R1, SHOT1_X_POS
LD R2, SHOT1_Y_POS
ADD R2, R2, #-1
JSR SHOT_RENDERER
STOP_SHOOTING

SHOOT_SHOT1

LD R0, NEGATIVE_FLAG
ST R0, SHOT1_FLAG

LD R1, PLANE_X_POS
LD R2, PLANE_Y_POS
ADD R2, R2, #-5
JSR SHOT_RENDERER
BRnzp STOP_SHOOTING

STOP_SHOOTING
LD R1, SAVE_R1
LD R2, SAVE_R2
LD R7, SAVE_R7_PLUS
ret


SHOT_RENDERER

ST R7, SAVE_R7

JSR FIRST_PIXEL
LEA R0, SHOTS
LDR R1,R0, #0
LDR R2,R0, #1
LEA R4, SHOTS_PIXELS
ADD R4, R4, #-1
JSR RENDER

LD R7, SAVE_R7
ret

SHOT_UNRENDERER

ST R7, SAVE_R7

JSR FIRST_PIXEL
LEA R0, SHOTS
LDR R1,R0, #0
LDR R2,R0, #1
JSR UNRENDER

LD R7, SAVE_R7
ret


SHOT1_FLAG          .BLKW 1
SHOT1_X_POS         .BLKW 1
SHOT1_Y_POS         .BLKW 1
SHOT_COUNTER        .BLKW 1