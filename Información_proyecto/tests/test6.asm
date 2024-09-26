                                .ORIG   x3000

LD R1, EX1
LD R2, EX1

MAIN_LOOP
JSR PLANE_UNRENDER
JSR MOVEMENT
JSR PLANE_RENDER
JSR SHOOTING
BRnzp MAIN_LOOP

EX1             .FILL #50
NEGATIVE_FLAG   .FILL x8000
SAVE_R0         .BLKW  1
SAVE_R1         .BLKW  1
SAVE_R2         .BLKW  1
SAVE_R3         .BLKW  1
SAVE_R4         .BLKW  1
SAVE_R5         .BLKW  1
SAVE_R6         .BLKW  1
SAVE_R7         .BLKW  1
SAVE_R7_PLUS    .BLKW  1
PLANE_X_POS     .BLKW  1
PLANE_Y_POS     .BLKW  1

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
LD R5, Y_MAX
ADD R5, R5, R2
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


RENDER
LD R6, ROW
ADD R4,R4, #1
LDR R5,R4, #0
BRn CHECK_INVIS
STR R5,R3, #0
CHECK_INVIS
ADD R3,R3, #1
ADD R1,R1, #-1
BRp RENDER
ADD R3, R3, R6
LDR R1, R0, #0
NOT R6, R1
ADD R6, R6, #1
ADD R3, R3, R6
ADD R2,R2, #-1 
BRp RENDER
ret

UNRENDER
LD R6, ROW
LD R5, BLACK
STR R5,R3, #0
ADD R3, R3, #1
ADD R1, R1, #-1
BRp UNRENDER
ADD R3, R3, R6
LDR R1, R0, #0
NOT R6, R1
ADD R6, R6, #1
ADD R3, R3, R6
ADD R2,R2, #-1 
BRp UNRENDER
ret

PANTALLA      .FILL xC000
ROW           .FILL x0080
BLACK         .FILL x0000


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
BRz SHOOT_AGAIN
ST R2, SHOT1_Y_POS
JSR SHOT_RENDERER
BRnzp STOP_SHOOTING

SHOOT_SHOT1

LD R0, NEGATIVE_FLAG
ST R0, SHOT1_FLAG

ADD R2, R2, #-5
ST R1, SHOT1_X_POS
ST R2, SHOT1_Y_POS
JSR SHOT_RENDERER
BRnzp STOP_SHOOTING

SHOOT_AGAIN
AND R0, R0, 0
ST R0, SHOT1_FLAG
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

PLANE  .FILL 11
       .FILl 8

PLANE_PIXELS
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x7FFF
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000

       .FILL xF000
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL xF000

       .FILL xF000
       .FILL xF000
       .FILL x7FFF
       .FILL xF000
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL xF000
       .FILL x7FFF
       .FILL xF000
       .FILL xF000

       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7C00
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF

       .FILL xF000
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL xF000

       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x7FFF
       .FILL xF000
       .FILL x7FFF
       .FILL xF000
       .FILL x7FFF
       .FILL xF000
       .FILL xF000
       .FILL xF000

       .FILL xF000
       .FILL xF000
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL x7FFF
       .FILL xF000
       .FILL xF000

       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x7FFF
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x7FFF
       .FILL xF000
       .FILL xF000
       .FILL xF000

SHOTS           .FILL   11
                .FILL   4

SHOTS_PIXELS
                .FILL   xF000
                .FILL   xF000
                .FILL   xF000
                .FILL   x7C00
                .FILL   xF000
                .FILL   xF000
                .FILL   xF000
                .FILL   x7C00
                .FILL   xF000
                .FILL   xF000
                .FILL   xF000
                
                .FILL   xF000
                .FILL   xF000
                .FILL   x7C00
                .FILL   x7C00
                .FILL   x7C00
                .FILL   xF000
                .FILL   x7C00
                .FILL   x7C00
                .FILL   x7C00
                .FILL   xF000
                .FILL   xF000

                .FILL   xF000
                .FILL   xF000
                .FILL   x7C00
                .FILL   x7C00
                .FILL   x7C00
                .FILL   xF000
                .FILL   x7C00
                .FILL   x7C00
                .FILL   x7C00
                .FILL   xF000
                .FILL   xF000
                
                .FILL   xF000
                .FILL   xF000
                .FILL   xF000
                .FILL   x7C00
                .FILL   xF000
                .FILL   xF000
                .FILL   xF000
                .FILL   x7C00
                .FILL   xF000
                .FILL   xF000
                .FILL   xF000

