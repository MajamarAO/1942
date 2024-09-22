.ORIG    x3000

LD R1, EX1
LD R2, EX1

EXAMPLE_RND
JSR FIRST_PIXEL
LEA R0, PLANE
LDR R1,R0, #0
LDR R2,R0, #1
LEA R4, PLANE_PIXELS
ADD R4, R4, #-1
BRnzp RENDER


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
HALT

FIRST_PIXEL
LD R3, PANTALLA
LD R6, ROW
ADD R3, R3, R1
ADD R2, R2, #0
BRz END
SUM
ADD R3, R3, R6
ADD R2, R2, #-1
BRp SUM
END
ret

PANTALLA    .FILL xC000
ROW         .FILL x0080
EX1         .FILL 50

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
