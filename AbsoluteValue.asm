// load the value stored in memory address R0 into register D
@0
D=M

// if the value in R0 is less than zero (negative), jump to NEGATIVE label
@NEGATIVE
D;JLT

// value is non-negative: load R0 again into D
@0
D=M

// redundant negative check (included again for safety)
@NEGATIVE
D;JLT

// since the value is non-negative, store it in R1 (R1 = R0)
@1
M=D

// set R2 = 0 to indicate the number is not negative
@2
M=0

// set R3 = 0 to indicate no overflow has occurred
@3
M=0

// jump to END label to finish execution
@END
0;JMP

(NEGATIVE)
// we are in the NEGATIVE label: mark that the value was negative
@2
M=1

// check if the value is -32768, which cannot be negated in 16-bit signed integer
@0
D=M
@32768
D=D+A   // D will be 0 if R0 == -32768
@OVERFLOW
D;JEQ   // If so, jump to handle overflow

// Otherwise, compute the absolute value by negating the value in R0
@0
D=M
D=-D

// store the absolute value in R1
@1
M=D

// set R3 = 0 to indicate no overflow
@3
M=0

// jump to END to finish
@END
0;JMP

(OVERFLOW)
// overflow handler: the input was -32768, which cannot be negated in 16-bit
@0
D=M

// copy the original value into R1 (without negation)
@1
M=D

// set R3 = 1 to indicate an overflow has occurred
@3
M=1

(END)
// final label: halt execution with an infinite loop
@END
0;JMP
