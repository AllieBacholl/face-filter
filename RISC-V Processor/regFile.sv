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
        end
    endgenerate

Register reg0  (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[0]),  .dataIn(writeData), .dataOut(readReg[0]));
Register reg1  (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[1]),  .dataIn(writeData), .dataOut(readReg[1]));
Register reg2  (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[2]),  .dataIn(writeData), .dataOut(readReg[2]));
Register reg3  (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[3]),  .dataIn(writeData), .dataOut(readReg[3]));
Register reg4  (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[4]),  .dataIn(writeData), .dataOut(readReg[4]));
Register reg5  (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[5]),  .dataIn(writeData), .dataOut(readReg[5]));
Register reg6  (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[6]),  .dataIn(writeData), .dataOut(readReg[6]));
Register reg7  (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[7]),  .dataIn(writeData), .dataOut(readReg[7]));

Register reg8  (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[8]),  .dataIn(writeData), .dataOut(readReg[8]));
Register reg9  (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[9]),  .dataIn(writeData), .dataOut(readReg[9]));
Register reg10 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[10]), .dataIn(writeData), .dataOut(readReg[10]));
Register reg11 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[11]), .dataIn(writeData), .dataOut(readReg[11]));
Register reg12 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[12]), .dataIn(writeData), .dataOut(readReg[12]));
Register reg13 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[13]), .dataIn(writeData), .dataOut(readReg[13]));
Register reg14 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[14]), .dataIn(writeData), .dataOut(readReg[14]));
Register reg15 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[15]), .dataIn(writeData), .dataOut(readReg[15]));

Register reg16 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[16]), .dataIn(writeData), .dataOut(readReg[16]));
Register reg17 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[17]), .dataIn(writeData), .dataOut(readReg[17]));
Register reg18 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[18]), .dataIn(writeData), .dataOut(readReg[18]));
Register reg19 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[19]), .dataIn(writeData), .dataOut(readReg[19]));
Register reg20 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[20]), .dataIn(writeData), .dataOut(readReg[20]));
Register reg21 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[21]), .dataIn(writeData), .dataOut(readReg[21]));
Register reg22 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[22]), .dataIn(writeData), .dataOut(readReg[22]));
Register reg23 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[23]), .dataIn(writeData), .dataOut(readReg[23]));

Register reg24 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[24]), .dataIn(writeData), .dataOut(readReg[24]));
Register reg25 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[25]), .dataIn(writeData), .dataOut(readReg[25]));
Register reg26 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[26]), .dataIn(writeData), .dataOut(readReg[26]));
Register reg27 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[27]), .dataIn(writeData), .dataOut(readReg[27]));
Register reg28 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[28]), .dataIn(writeData), .dataOut(readReg[28]));
Register reg29 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[29]), .dataIn(writeData), .dataOut(readReg[29]));
Register reg30 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[30]), .dataIn(writeData), .dataOut(readReg[30]));
Register reg31 (.clk(clk), .reset(rst), .writeEnable(writeEnableSignals[31]), .dataIn(writeData), .dataOut(readReg[31]));

    
    // Handle register 0 differently - it's always 0 in RISC-V
    assign writeEnableSignals[0] = 1'b0; // Never write to register 0
    
    // Error checking
    // Modified error logic for 32-bit data
    assign err = ((writeEn != 1'b0) & (writeEn != 1'b1)) ? 1'b1 : 1'b0;

endmodule