`default_nettype none
module alu_control (opcode, funct3, funct7, aluOp);

   input wire [6:0]    opcode;        // Bottom 7 bits of instruction
   input wire [2:0]    funct3;        // Differentiate between different R and I instructions
   input wire          funct7;        // 31st bit for shifting logical or arithmetic/adding or subtracting
   
   output wire [4:0]   aluOp;         // Opcode going to the alu
                                      // [Do nothing][funct7][funct3]
   
   assign aluOp =
                     // I type instructions 
                    (opcode == 7'b0010011)          ?                   // If I instruction that uses ALU
                    (funct3 == 3'b000)              ?   5'b10000 :      // add ALU Operation
                    (funct3 == 3'b001)              ?   5'b10001 :      // sll ALU Operation
                    (funct3 == 3'b010)              ?   5'b10010 :      // slt ALU Operation
                    (funct3 == 3'b011)              ?   5'b10011 :      // sltu ALU Operation
                    (funct3 == 3'b100)              ?   5'b10100 :      // xor ALU Operation
                    (funct3 == 3'b101)              ?                   // sr ALU Operation
                    (funct7 == 1'b0)    ?  5'b10101 :   5'b11101 :      // set if srl or sra
                    (funct3 == 3'b110)              ?   5'b10110 :      // or ALU Operation
                    5'b10111                        :                   // and ALU Operation
                    
                    // R type instructions 
                    (opcode == 7'b0110011)          ?                   // If R instruction that doesn't use ALU
                    (funct3 == 3'b000)              ?                   // add or sub ALU Operation
                    (funct7 == 1'b0)    ?  5'b10000 :   5'b11000 :      // set if add or sub
                    (funct3 == 3'b001)              ?   5'b10001 :      // sll ALU Operation
                    (funct3 == 3'b010)              ?   5'b10010 :      // slt ALU Operation
                    (funct3 == 3'b011)              ?   5'b10011 :      // sltu ALU Operation
                    (funct3 == 3'b100)              ?   5'b10100 :      // xor ALU Operation
                    (funct3 == 3'b101)              ?                   // sr ALU Operation
                    (funct7 == 1'b0)    ?  5'b10101 :   5'b11101 :      // set if srl or sra
                    (funct3 == 3'b110)              ?   5'b10110 :      // or ALU Operation
                    5'b10111                        :                   // and ALU Operation

                    // B type instructions
                    (opcode == 7'b1100011)          ?                   // If B instruction, sub ALU operation
                    5'b11000                        :

                    // J type instructions
                    (opcode == 7'b1100111)          ?                   // If jalr instruction, add ALU operation
                    5'b10000                        :

                    // Don't use ALU
                    // Load/Store
                    // Jump
                    5'b00000                        ;                   // ALU out = input B
endmodule
`default_nettype wire