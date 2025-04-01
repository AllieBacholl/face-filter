`timescale 1ns/1ps

module fetch_tb;

    // Inputs
    reg clk = 0;
    reg rst;
    reg EXT_in = 1'bx;
    reg interrupt_en = 1'bx;
    reg [31:0] interrupt_handling_addr = 32'hxxxxxxxx;
    reg [31:0] branch_jump_addr = 32'hxxxxxxxx;
    reg [31:0] alu_result_EXE = 32'hxxxxxxxx;
    reg pc_next_sel = 1'bx;
    reg pcJalSrc_EXE = 1'bx;
    reg stall = 1'b0;

    // Outputs
    wire [31:0] pcPlus4, pc;
    wire [31:0] instr;
    wire err;

    // Instantiate the fetch module
    fetch uut (
        .clk(clk),
        .rst(rst),
        .EXT_in(EXT_in),
        .interrupt_en(interrupt_en),
        .interrupt_handling_addr(interrupt_handling_addr),
        .branch_jump_addr(branch_jump_addr),
        .alu_result_EXE(alu_result_EXE),
        .pc_next_sel(pc_next_sel),
        .pcJalSrc_EXE(pcJalSrc_EXE),
        .stall(stall),
        .pcPlus4(pcPlus4),
        .pc(pc),
        .instr(instr),
        .err(err)
    );

    // Generate clock
    always #5 clk = ~clk;

    initial begin
        $display("Time\tPC\t\tPC+4");
        $monitor("%0dns\t0x%08x\t0x%08x", $time, pc, pcPlus4);

        // Reset
        rst = 1; #10;
        rst = 0;

        // Let PC run a few cycles
        #10000;

        $stop;
    end

endmodule
