module regFile (
                // Outputs
                read1Data, read2Data, err,
                // Inputs
                clk, rst, read1RegSel, read2RegSel, writeRegSel, writeData, writeEn
                );

    input        clk, rst;
    input [4:0]  read1RegSel;    // Modified to 5 bits for 32 registers
    input [4:0]  read2RegSel;    // Modified to 5 bits for 32 registers
    input [4:0]  writeRegSel;    // Modified to 5 bits for 32 registers
    input [31:0] writeData;      // Modified to 32 bits
    input        writeEn;
    
    output [31:0] read1Data;     // Modified to 32 bits
    output [31:0] read2Data;     // Modified to 32 bits
    output        err;
    
    /* RISC-V Register File Implementation */
    parameter WIDTH = 32;        // Width is 32 bits for RISC-V
    wire [31:0] writeEnableSignals;  // Expanded to 32 registers
    wire [WIDTH - 1:0] readReg [31:0]; // Expanded to 32 registers
    
    // RISC-V special case: Register 0 always reads as 0
    assign readReg[0] = 32'b0;
    
    // Read port 1 logic with 32 registers
    assign read1Data = readReg[read1RegSel];
    
    // Read port 2 logic with 32 registers
    assign read2Data = readReg[read2RegSel];
    
    // Generate write enable signals for each register
    genvar i;
    generate
        for (i = 1; i < 32; i = i + 1) begin : write_enables
            assign writeEnableSignals[i] = (writeRegSel == i) & writeEn;
            
            Register reg_inst (
                .clk(clk),
                .reset(rst),
                .writeEnable(writeEnableSignals[i]),
                .dataIn(writeData),
                .dataOut(readReg[i])
            );
        end
    endgenerate
    
    // Handle register 0 differently - it's always 0 in RISC-V
    assign writeEnableSignals[0] = 1'b0; // Never write to register 0
    
    // Error checking
    // Modified error logic for 32-bit data
    assign err = ((writeEn != 1'b0) & (writeEn != 1'b1)) ? 1'b1 : 1'b0;

endmodule