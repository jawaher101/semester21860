// step 1 calculate NOT R0
// first, we load the value from memory location R0 into register D
// then we perform a bitwise NOT operation on D and store the result in R3
@0
D=M        // Load value from R0 
D=!D       // bitwise NOT on D
@3
M=D        // Store the result in R3

// step 2: calculate NOT R1
// similar to step 1, but using R1 instead of R0
@1
D=M        // load value from R1 
D=!D       // bitwise NOT on D
@4
M=D        // store the result R4

// step 3: calculate (R0 AND NOT R1)
// load NOT R1 from R4, then perform AND with R0
@4
D=M        // load NOT R1 from R4
@0
D=D&M      // AND between R0 and NOT R1
@5
M=D        // store the result in R5

// step 4: calculate (NOT R0 AND R1)
// load NOT R0 from R3, then perform AND with R1

@3
D=M        // load NOT R0 from R3 
@1
D=D&M      // AND between NOT R0 and R1

// step 5: final XOR Calculation
// Combine the results using OR operation
// XOR is calculated as: (R0 AND NOT R1) OR (NOT R0 AND R1)
@5
D=D|M      // OR between previous result and value in R5

// step 6: store Final Result
// Store the computed XOR result in memory location R2
@2
M=D        // store final XOR result in R2