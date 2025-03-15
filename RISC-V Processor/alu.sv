module alu (InA, InB, Oper, Out, zf, sf);

    parameter OPERAND_WIDTH = 32;    
    parameter NUM_OPERATIONS = 5;
       
    input  [OPERAND_WIDTH-1:0]  InA ; // Input operand A
    input  [OPERAND_WIDTH-1:0]  InB ; // Input operand B
    input  [NUM_OPERATIONS-1:0] Oper; // Operation type
    output [OPERAND_WIDTH-1:0]  Out ; // Result of computation
    output                      sf  ; // Signal if Out is negative or positive
    output                      zf  ; // Signal if Out is 0

    /* YOUR CODE HERE */
    // Intermediate signals
    wire [OPERAND_WIDTH-1:0] B_int;
    wire [OPERAND_WIDTH-1:0] shift_result, sum, xor_result, or_result, and_result;
    wire                     of;    // 1'b1 if there is overflow
    wire                     sltu;  // Set less than unsigned 

    // Invert B for subtraction
    // 2's complement for subtraction, A - B
    assign B_int = (Oper == 5'b11000) ? (~InB) + 1'b1 : InB;
    
    // Shift operation: sll, srl, or sla
    assign shift_result = ((Oper == 5'b10001) ? InA << B_int) : ((Oper == 5'b10101) ? InA >> B_int) : InA >>> B_int;

    // Arithmetic addition
    sum = InA + B_int;
    
    // Bitwise XOR, OR, and AND
    assign xor_result  = InA ^ B_int;
    assign or_result  = InA | B_int;
    assign and_result = InA & B_int;
    
    // Zero flag
    assign zf = (sum == 16'b0) ? 1'b1 : 1'b0;

    // Sign flag, equal to MSB of output
    assign of = (InA[OPERAND_WIDTH-1] ~^ B_int[OPERAND_WIDTH-1]) & (sum[OPERAND_WIDTH-1] ^ InA[OPERAND_WIDTH-1]);
    assign sf = (of) ? ((InA[OPERAND_WIDTH-1]) ? 1'b0 : 1'b1) : sum[OPERAND_WIDTH-1];

    // stlu flag
    assign sltu = ($unsigned(InA) < $unsigned(B_int));

    // Output mux to select the correct operation result
    assign Out =    (Oper == 5'b10000 | Oper == 5'b11000)                       ?   sum                 :       // add or sub
                    (Oper == 5'b10001 | Oper == 5'b10101 | Oper == 5'b11101)    ?   shift_result        :       // sll, srl, sra    
                    (Oper == 5'b10100)                                          ?   xor_result          :       // xor
                    (Oper == 5'b10110)                                          ?   or_result           :       // or
                    (Oper == 5'b10111)                                          ?   and_result          :       // and
                    (Oper == 5'b10010)                                          ?   {31'b0, (~zf & sf)} :       // slt, set if A < B, A - B sign
                    // stlu
                    (Oper == 5'b10010)                                          ?   sltu                :       // slt, set if A < B, A - B sign
                    InB;                                                                                        // Pass B input through
endmodule