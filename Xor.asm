// begain
@0
D=M
D=!D
@3
M=D

// Compute NOT R1 and store in R4
@1
D=M
D=!D
@4
M=D

// Compute (R0 AND NOT R1) and store in R5
@4
D=M
@0
D=D&M
@5
M=D

// Compute NOT R0 AND R1
@3
D=M
@1
D=D&M

// Compute final XOR using OR operation
@5
D=D|M

// Store result in R2
@2
M=D