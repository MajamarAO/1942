    .ORIG    x3000

EXAMPLE_RND
LD R0, EXAMPLE
LD R1, EXAMPLE
LD R2, ANCHO_EX
LD R3, ALTO_EX
LD R4, SPRITE_EX
LD R6, ROW
 
RENDER
STR R4,R1, #0
ADD R4,R4, #1
ADD R1,R1, #1
ADD R2,R2, #-1
BRp RENDER
LD R2, ANCHO_EX
NOT R5, R2
ADD R5, R5, #1
ADD R1, R1, R5
ADD R1, R1, R6
ADD R3,R3, #-1 
BRp RENDER
HALT

EXAMPLE  .FILL xDD42
ANCHO_EX .FILL 5
ALTO_EX  .FILL 4
      
SPRITE_EX .FILL x001F
          .FILL x001F
          .FILL x001F
          .FILL x001F
          .FILL x001F

          .FILL x001F
          .FILL x001F
          .FILL x001F
          .FILL x001F
          .FILL x001F

          .FILL x001F
          .FILL x001F
          .FILL x001F
          .FILL x001F
          .FILL x001F

          .FILL x001F
          .FILL x001F
          .FILL x001F
          .FILL x001F
          .FILL x001F
        

ROW     .FILL x0080