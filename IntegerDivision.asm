// Initialize registers R2, R3, and R4 to 0
@R2
M=0    
@R3
M=0
@R4
M=0  

// Check if denominator (R1) is zero
@R1
D=M
@INVALID
D;JEQ  // Jump to INVALID if denominator is zero

// Check if numerator (R0) is negative
@R0
D=M
@XNEGATIVE
D;JLT  // Jump to XNEGATIVE if numerator is negative
@16
M=D  // Store numerator in memory location 16

// Check if denominator (R1) is negative
@R1
D=M
@YNEGATIVE
D;JLT  // Jump to YNEGATIVE if denominator is negative
@17
M=D  // Store denominator in memory location 17

// Proceed to division
@DIVISION
0;JMP

// If numerator is negative, convert to positive
(XNEGATIVE)
@R0
D=M
D=-D
@16
M=D
0;JMP  // Continue execution

// If denominator is negative, convert to positive
(YNEGATIVE)
@R1
D=M
D=-D
@17
M=D
0;JMP  // Continue execution

// Perform division using subtraction loop
(DIVISION)
@16
D=M
@R3
M=D  // Initialize R3 with numerator

(LOOP)
@R3
D=M
@17
D=D-M
@END_DIV
D;JLT  // If result goes negative, exit loop
@R3
M=D  // Update remainder
@R2
M=M+1  // Increment quotient
@LOOP
0;JMP  // Repeat loop

// End of division process
(END_DIV)

// Determine the sign of the quotient
@R0
D=M
@R1
D=M
D=D-M
@NEG_QUOTIENT
D;JGT  // If numerator > denominator, quotient is positive

@R0
D=M
@NEG_REMAINDER
D;JLT  // If numerator is negative, remainder should be negative
@END
0;JMP

// If quotient should be negative, negate it
(NEG_QUOTIENT)
@R2
M=-M
@END
0;JMP

// If remainder should be negative, negate it
(NEG_REMAINDER)
@R3
M=-M
@END
0;JMP

// Handle invalid case 
(INVALID)
@R4
M=1  // Set R4 to 1 indicating error

(END)
