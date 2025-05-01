module IF_ID(
    input clk, rst, err_in,
    input [31:0] pc_in,
    input [31:0] instr_in,
    input [31:0] pcPlus4_in,
    input stall, flush,
    input EXT, // immediate value

    output [31:0] pc_out,
    output [31:0] instr_out,
    output [31:0] pcPlus4_out,
    output err_out,
    output EXT_out

);

// pc
dff_proc pc [31:0] (.q(pc_out), .d(flush ? 1'b0 : (stall ? pc_out : pc_in)), .clk(clk), .rst(rst));

dff_proc instr [31:0] (.q(instr_out), .d(flush ? 1'b0 : (stall ? instr_out : instr_in)), .clk(clk), .rst(rst));

dff_proc pcPlus4 [31:0] (.q(pcPlus4_out), .d(flush ? 1'b0 : (stall ? pcPlus4_out : pcPlus4_in)), .clk(clk), .rst(rst));

dff_proc err(.q(err_out), .d(flush ? 1'b0 : (stall ? err_out : err_in)), .clk(clk), .rst(rst));


endmodule