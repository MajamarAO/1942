                                .ORIG   x3000


LD R1, EX1
LD R2, EX1

JSR PLANE_UNRENDER
JSR MOVEMENT
JSR PLANE_RENDER
JSR SHOOTING

JSR SAVE_PL

LD R1, EXE1
LD R2, EYE2

JSR ENEMY_UNRENDER
JSR ENEMY_MOVEMENT
JSR ENEMY_RENDER
JSR SAVE_FOR

LD R0, PSAVE_R0
LD R1, PSAVE_R1
LD R2, PSAVE_R2
LD R3, PSAVE_R3
LD R4, PSAVE_R4
LD R5, PSAVE_R5
LD R6, PSAVE_R6
LD R7, PSAVE_R7

MAIN_LOOP

JSR PLANE_UNRENDER
JSR MOVEMENT
JSR PLANE_RENDER
JSR SHOOTING


JSR SAVE_PL

LD R0, ESAVE_R0
LD R1, ESAVE_R1
LD R2, ESAVE_R2
LD R3, ESAVE_R3
LD R4, ESAVE_R4
LD R5, ESAVE_R5
LD R6, ESAVE_R6
LD R7, ESAVE_R7

JSR ENEMY_UNRENDER
JSR ENEMY_MOVEMENT
JSR ENEMY_RENDER
JSR SAVE_FOR

LD R0, PSAVE_R0
LD R1, PSAVE_R1
LD R2, PSAVE_R2
LD R3, PSAVE_R3
LD R4, PSAVE_R4
LD R5, PSAVE_R5
LD R6, PSAVE_R6
LD R7, PSAVE_R7

BRnzp MAIN_LOOP

EX1             .FILL #50
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


EXE1            .FILL #100
EYE2		    .FILL #1
NEGATIVE_FLAG   .FILL x8000
NSAVE_R0        .BLKW  1
NSAVE_R1        .BLKW  1
NSAVE_R2        .BLKW  1
NSAVE_R3        .BLKW  1
NSAVE_R4        .BLKW  1
NSAVE_R5        .BLKW  1
NSAVE_R6        .BLKW  1
NSAVE_R7        .BLKW  1
NSAVE_R7_PLUS   .BLKW  1
ENEMY_X_POS     .BLKW  1
ENEMY_Y_POS     .BLKW  1
SLEEP_COUNTER	.FILL #0

ESAVE_R0         .BLKW  1
ESAVE_R1         .BLKW  1
ESAVE_R2         .BLKW  1
ESAVE_R3         .BLKW  1
ESAVE_R4         .BLKW  1
ESAVE_R5         .BLKW  1
ESAVE_R6         .BLKW  1
ESAVE_R7         .BLKW  1

PSAVE_R0         .BLKW  1
PSAVE_R1         .BLKW  1
PSAVE_R2         .BLKW  1
PSAVE_R3         .BLKW  1
PSAVE_R4         .BLKW  1
PSAVE_R5         .BLKW  1
PSAVE_R6         .BLKW  1
PSAVE_R7         .BLKW  1

SAVE_PL
ST R0, PSAVE_R0
ST R1, PSAVE_R1
ST R2, PSAVE_R2
ST R3, PSAVE_R3
ST R4, PSAVE_R4
ST R5, PSAVE_R5
ST R6, PSAVE_R6
ST R7, PSAVE_R7
ret

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

GOOD_COLOR			.FILL x01C0
SAVE_R7_WIN			.BLKW 1
SAVE_R0_WIN			.BLKW 1

SRENDER
LD R6, ROW
ADD R4,R4, #1
LDR R5,R4, #0
BRn CHECK_INVISS
ST R7, SAVE_R7_WIN
ST R0, SAVE_R0_WIN
LDR R7, R3, #0
LD R0, GOOD_COLOR
NOT R0, R0
ADD R0, R0, #1
ADD R7, R7, R0
BRz YOU_WINN
LD R7, SAVE_R7_WIN
LD R0, SAVE_R0_WIN
STR R5,R3, #0
CHECK_INVISS
ADD R3,R3, #1
ADD R1,R1, #-1
BRp SRENDER
ADD R3, R3, R6
LDR R1, R0, #0
NOT R6, R1
ADD R6, R6, #1
ADD R3, R3, R6
ADD R2,R2, #-1 
BRp SRENDER
ret

SHOT_RENDERER

ST R7, SAVE_R7

JSR FIRST_PIXEL
LEA R0, SHOTS
LDR R1,R0, #0
LDR R2,R0, #1
LEA R4, SHOTS_PIXELS
ADD R4, R4, #-1
JSR SRENDER

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



SAVE_FOR
ST R0, ESAVE_R0
ST R1, ESAVE_R1
ST R2, ESAVE_R2
ST R3, ESAVE_R3
ST R4, ESAVE_R4
ST R5, ESAVE_R5
ST R6, ESAVE_R6
ST R7, ESAVE_R7
ret



;---------------------------------------------------------U
ENEMY_UNRENDER
ST R1, NSAVE_R1
ST R2, NSAVE_R2
ST R7, NSAVE_R7

JSR FIRST_PIXEL
LEA R0, ENEMY
LDR R1,R0, #0
LDR R2,R0, #1
JSR UNRENDER

LD R1, NSAVE_R1
LD R2, NSAVE_R2
LD R7, NSAVE_R7
ret
;-----------------------------------------------------------U
;------------------------------------------------------M
ENEMY_MOVEMENT
ST R1, NSAVE_R1
ST R2, NSAVE_R2

LD R5, SLEEP_COUNTER
ADD R5, R5, #1
ST R5, SLEEP_COUNTER
ADD R5, R5, #-8
BRzp RESET_CON
BRnzp ENDE_MOVE

RESET_CON
AND R5, R5, #0
ST R5, SLEEP_COUNTER

AE_MOVE
ADD R1, R1, 0
BRz BACK_RIGHT
ADD R1, R1, #-1
BRnzp SE_MOVE

BACK_RIGHT
LD R1, X_MAX

SE_MOVE
LD R5, Y_MAX
ADD R5, R5, R2
BRz BACK_UP
ADD R2, R2, #1
BRnzp ENDE_MOVE

BACK_UP
LD R2, EYE2

ENDE_MOVE
ret
;-------------------------------------------------------------M
;-------------------------------------------------------------R
ENEMY_RENDER
ST R1, NSAVE_R1
ST R2, NSAVE_R2
ST R7, NSAVE_R7

JSR FIRST_PIXEL
LEA R0, ENEMY
LDR R1,R0, #0
LDR R2,R0, #1
LEA R4, ENEMY_PIXELS
ADD R4, R4, #-1
JSR ERENDER

LD R1, NSAVE_R1
LD R2, NSAVE_R2
LD R7, NSAVE_R7
ret
;---------------------------------------------------------R



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

BAD_COLOR			.FILL x7FFF
SAVE_R7_LOSE		.BLKW 1


ERENDER
LD R6, ROW
ADD R4,R4, #1
LDR R5,R4, #0
BRn CHECK_INVISE
ST R7, SAVE_R7_LOSE
LDR R7, R3, #0
ADD R7, R7, #2
BRn YOU_LOSE
LD R7, SAVE_R7_LOSE
STR R5,R3, #0
CHECK_INVISE
ADD R3,R3, #1
ADD R1,R1, #-1
BRp ERENDER
ADD R3, R3, R6
LDR R1, R0, #0
NOT R6, R1
ADD R6, R6, #1
ADD R3, R3, R6
ADD R2,R2, #-1 
BRp ERENDER
ret


YOU_WINN
BRnzp YOU_WIN

LXL			.FILL #50
LYL			.FILL #40

YOU_LOSE
HALT



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




ENEMY	.FILL 7
	.FILL 8
	
ENEMY_PIXELS
	.FILL xF000
	.FILL xF000
	.FILL xF000
	.FILL x01C0
	.FILL xF000
	.FILL xF000
	.FILL xF000

	.FILL xF000
	.FILL xF000
	.FILL x01C0
	.FILL x01C0
	.FILL x01C0
	.FILL xF000
	.FILL xF000

	.FILL xF000
	.FILL xF000
	.FILL xF000
	.FILL x01C0
	.FILL xF000
	.FILL xF000
	.FILL xF000

	.FILL xF000
	.FILL xF000
	.FILL x01C0
	.FILL x01C0
	.FILL x01C0
	.FILL xF000
	.FILL xF000

	.FILL xF000
	.FILL xF000
	.FILL x01C0
	.FILL x533D
	.FILL x01C0
	.FILL xF000
	.FILL xF000

	.FILL x01C0
	.FILL x01C0
	.FILL x01C0
	.FILL x533D
	.FILL x01C0
	.FILL x01C0
	.FILL x01C0

	.FILL xF000
	.FILL x01C0
	.FILL x01C0
	.FILL x01C0
	.FILL x01C0
	.FILL x01C0
	.FILL xF000

	.FILL xF000
	.FILL xF000
	.FILL xF000
	.FILL x01C0
	.FILL xF000
	.FILL xF000
	.FILL xF000

LXW			.FILL #28
LYW			.FILL #40

YOU_WIN
LD R1, LXW
LD R2, LYW
JSR FIRST_PIXEL
LEA R0, CARTELW
LDR R1,R0, #0
LDR R2,R0, #1
LEA R4, CARTELW_PIXELS
ADD R4, R4, #-1
JSR RENDER
HALT

CARTELW  .FILL 65
         .FILl 10

CARTELW_PIXELS
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000

       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0

       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL x03E0
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0
       .FILL xF000
       .FILL xF000
       .FILL xF000
       .FILL x03E0
       .FILL x03E0