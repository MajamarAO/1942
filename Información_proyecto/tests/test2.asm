    .ORIG    x3000

EXAMPLE_RND
LEA R0, PLANE
LDR R1,R0, #0
LDR R2,R0, #1
LDR R3,R0, #2
LDR R4,R0, #3
LEA R5, PLANE
ADD R5, R5, #2
LD R7, ROW
 
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


 PLANE .FILL xDD42
       .FILL 11
       .FILl 8

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

      
