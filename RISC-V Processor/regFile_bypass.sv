module regFile_bypass (
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
    
    /* RISC-V Register File Bypass Implementation */
    wire [31:0] read1Data_buffer, read2Data_buffer;
    
    // Instantiate the main register file
    regFile rf (
       .clk(clk),
       .rst(rst),
       .read1RegSel(read1RegSel),
       .read2RegSel(read2RegSel),
       .writeRegSel(writeRegSel),
       .writeData(writeData),
       .writeEn(writeEn),
       .read1Data(read1Data_buffer),
       .read2Data(read2Data_buffer),
       .err(err)
    );
    
    // Bypassing logic with RISC-V's x0 handling
    // Register 0 always reads as 0 regardless of bypassing
    assign read1Data = (read1RegSel == 5'b00000) ? 32'b0 :
                      ((read1RegSel == writeRegSel) & writeEn) ? writeData : read1Data_buffer;
                      
    assign read2Data = (read2RegSel == 5'b00000) ? 32'b0 :
                      ((read2RegSel == writeRegSel) & writeEn) ? writeData : read2Data_buffer;

   

endmodule