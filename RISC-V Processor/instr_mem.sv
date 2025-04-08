module instr_mem(
    input clk,
    input [31:0] addr,
    input rd_en,               // Enable signal for instruction read operation
    output reg [31:0] instr    // 32-bit instruction output
);

    // Instruction memory array: 1024 words of 32 bits each
    reg [31:0] instr_mem[0:1023];
    
    // Memory read operation occurs on the falling edge of the clock
    always @(negedge clk) begin
        if (rd_en) begin
            instr <= instr_mem[addr];
        end
    end
    
    // Initialize instruction memory from external hex file
    initial begin
        $readmemh("../hex.file/brch.hex", instr_mem);
    end
    
endmodule