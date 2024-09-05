    .ORIG    x3000

EXAMPLE_RND
LEA R0, EXAMPLE
LDR R1,R0, #0
LDR R2,R0, #1
LDR R3,R0, #2
LDR R4,R0, #3
LEA R5, EXAMPLE
ADD R5, R5, #3
LD R6, ROW
 
RENDER
STR R4,R1, #0
ADD R5,R5, #1
LDR R4,R5, #0
ADD R1,R1, #1
ADD R2,R2, #-1
BRp RENDER
LDR R2, R0, #1 
NOT R6, R2
ADD R6, R6, #1
ADD R1, R1, R
ADD R1, R1, R7
ADD R3,R3, #-1 
BRp RENDER
HALT

EXAMPLE  .FILL xDD42
         .FILL 5
         .FILL 4
      
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
         .FILL x001F
        

ROW     .FILL x0080
