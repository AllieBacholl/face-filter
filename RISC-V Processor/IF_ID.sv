module IF_ID(
    input clk, rst, err_in,
    input [31:0] pc_in,
    input [31:0] instr_in,
    input [31:0] pcPlus4_in,
    input stall, flush,

    output [31:0] pc_out,
    output [31:0] instr_out,
    output [31:0] pcPlus4_out,
    output err_out

);

// pc
dff pc(.q(pc_out), .d(pc_in), .clk(clk), .rst(rst));

dff instr(.q(instr_out), .d(instr_in), .clk(clk), .rst(rst));

dff pcPlus4(.q(pcPlus4_out), .d(pcPlus4_in), .clk(clk), .rst(rst));

dff err(.q(err_out), .d(err_in), .clk(clk), .rst(rst));


endmodule