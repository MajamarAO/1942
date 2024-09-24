                                .ORIG   x3000


MAIN_LOOP
JSR MOVEMENT
JSR PLANE_RENDER
BRnzp MAIN_LOOP



SAVE_R0         .BLKW  1
SAVE_R1         .BLKW  1
SAVE_R2         .BLKW  1
SAVE_R3         .BLKW  1
SAVE_R4         .BLKW  1
SAVE_R5         .BLKW  1
SAVE_R6         .BLKW  1
SAVE_R7         .BLKW  1
X_POS           .BLKW  1
Y_POS           .BLKW  1
