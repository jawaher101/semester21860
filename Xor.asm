// begin load value from R0 and compute NOT R0, store in R3
@0
D=M        // D = R0
D=!D       // D = NOT R0 (bitwise negation)
@3
M=D        // R3 = NOT R0

// compute NOT R1 and store result in R4
@1
D=M        // D = R1
D=!D       // D = NOT R1
@4
M=D        // R4 = NOT R1

// compute (R0 AND NOT R1) and store in R5
@4
D=M        // D = NOT R1
@0
D=D&M      // D = R0 AND NOT R1
@5
M=D        // R5 = (R0 AND NOT R1)

// compute (NOT R0 AND R1) and store result in D (for XOR step)
@3
D=M        // D = NOT R0
@1
D=D&M      // D = NOT R0 AND R1

// compute XOR: (R0 AND NOT R1) OR (NOT R0 AND R1)
@5
D=D|M      // D = R5 OR D = (R0 AND NOT R1) OR (NOT R0 AND R1)

// store final XOR result in R2
@2
M=D        // R2 = R0 XOR R1
