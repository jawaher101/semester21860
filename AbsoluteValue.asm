// Load R0 into D
@0
D=M

// Check if R0 is negative (MSB is 1)
@NEGATIVE
D;JLT   // Jump if R0 < 0
// Load value from R0
@0
D=M

// Check if R0 is negative
@NEGATIVE
D;JLT   // Jump if negative

// If positive or zero, copy to R1 and set flags
@1
M=D     // R1 = R0
@2
M=0     // R2 = 0 (not negative)
@3
M=0     // R3 = 0 (valid absolute value)
@END
0;JMP

(NEGATIVE)
// Mark R0 as negative
@2
M=1

// Check if R0 is -32768
@0
D=M
@32768
D=D+A   // If R0 + 32768 == 0, it's -32768
@OVERFLOW
D;JEQ   // Jump if true

// Compute absolute value
@0
D=M
D=-D
@1
M=D     // R1 = -R0

// No overflow, set R3 = 0
@3
M=0
@END
0;JMP

(OVERFLOW)
// Handle overflow case
@0
D=M
@1
M=D     // Copy R0 to R1
@3
M=1     // R3 = 1 (overflow detected)

(END)
@END
0;JMP   // Loop indefinitely
// If R0 is non-negative, store it in R1, set flags accordingly
@1
M=D     // R1 = R0 (unchanged)
@2
M=0     // R2 = 0 (not negative)
@3
M=0     // R3 = 0 (valid absolute value)
@END
0;JMP

(NEGATIVE)
// Set R2 = 1 (negative flag)
@2
M=1

// Check for overflow: Is R0 == -32768 (1000000000000000)?
@0
D=M
@32768
D=D+A   // If R0 + 32768 == 0, then R0 was -32768
@OVERFLOW
D;JEQ   // Jump if R0 == -32768

// Compute absolute value: R1 = -R0
@0
D=M
D=-D
@1
M=D     // R1 = -R0

// No overflow, set R3 = 0
@3
M=0
@END
0;JMP

(OVERFLOW)
// Overflow case: Store R0 in R1, set R3 = 1
@0
D=M
@1
M=D     // R1 = R0 (unchanged)
@3
M=1     // R3 = 1 (indicating error)

(END)
@END
0;JMP   // Infinite loop (optional)