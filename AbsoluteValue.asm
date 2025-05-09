// load the initial value from RAM address 0 (R0) 
@0
D=M

// check if the number is negative
// if the value < 0, the program will jump to the negative label
@NEGATIVE
D;JLT

// if we reach here, the number is positive or zero
@0
D=M

// double check for negative numbers 
// we don't miss negative values
@NEGATIVE
D;JLT

// for positive numbers: simply copy R0's value into R1
// this is done because positive numbers don't need conversion
@1
M=D

// set R2 to 0 to indicate this was a positive number
// R2 acts as a sign flag (0 = positive, 1 = negative)
@2
M=0

// set R3 to 0 because there's no possibility of overflow with positive numbers
// R3 acts as an overflow flag (0 = no overflow, 1 = overflow occurred)
@3
M=0

// skip the negative number handling by jumping to the end of the program
@END
0;JMP

(NEGATIVE)
// we arrive here if the number was negative
// first, set R2 to 1 to remember that this was a negative number
@2
M=1

// special case check: is this number -32768?
// -32768 is special because it's the most negative 16-bit number
// add 32768 to the number, if result is 0, we found -32768
@0
D=M
@32768
D=D+A
@OVERFLOW
D;JEQ

// for all other negative numbers:
// load the negative number from R0 and negate it to get its absolute value
@0
D=M
D=-D

// store the absolute value result in R1
@1
M=D

// set R3 to 0 because no overflow occurred during negation
@3
M=0

// jump to end
@END
0;JMP

(OVERFLOW)
// special handling for -32768
// copy the original -32768 value to R1 without trying to negate it
@0
D=M
@1
M=D

// set R3 to 1 to indicate that an overflow condition occurred
// this happens because -32768 cannot be represented as a positive number in 16 bits
@3
M=1

(END)
// create an infinite loop 
// this prevents execution 
@END
0;JMP