module ME_WB(
    input clk, rst, stall,
    input [31:0] pc_in,
    input [31:0] pcPlus4_in,
    input [31:0] rs1_data_in, rs2_data_in,
    input [4:0] rs1_in, rs2_in, rd_in,

    input reg_write_in, 
    input [31:0] mem_data_in,
    input [1:0] result_sel_in,
    input [31:0] alu_result_in,

    output [31:0] pc_out, pcPlus4_out,
    output [31:0] rs1_data_out, rs2_data_out,
    output [4:0] rs1_out, rs2_out, rd_out,

    output reg_write_out, 
    output [31:0] mem_data_out,
    output [1:0] result_sel_out,
    output [31:0] alu_result_out
);


dff_proc pc [31:0]( .clk(clk), .rst(rst), .d(stall ? pc_out : pc_in), .q(pc_out) );
dff_proc pcPlus4 [31:0]( .clk(clk), .rst(rst), .d(stall ? pcPlus4_out : pcPlus4_in), .q(pcPlus4_out) );
dff_proc rs1_data [31:0]( .clk(clk), .rst(rst), .d(stall ? rs1_data_out : rs1_data_in), .q(rs1_data_out) );
dff_proc rs2_data [31:0]( .clk(clk), .rst(rst), .d(stall ? rs2_data_out : rs2_data_in), .q(rs2_data_out) );
dff_proc rs1 [4:0]( .clk(clk), .rst(rst), .d(stall ? rs1_out : rs1_in), .q(rs1_out) );
dff_proc rs2 [4:0]( .clk(clk), .rst(rst), .d(stall ? rs2_out : rs2_in), .q(rs2_out) );
dff_proc rd [4:0]( .clk(clk), .rst(rst), .d(stall ? rd_out : rd_in), .q(rd_out) );

dff_proc reg_write( .clk(clk), .rst(rst), .d(stall ? reg_write_out : reg_write_in), .q(reg_write_out) );
dff_proc mem_write_en [31:0]( .clk(clk), .rst(rst), .d(stall ? mem_data_out : mem_data_in), .q(mem_data_out) );
dff_proc result_sel [1:0]( .clk(clk), .rst(rst), .d(stall ? result_sel_out : result_sel_in), .q(result_sel_out) );
dff_proc imm_ctrl ( .clk(clk), .rst(rst), .d(stall ? imm_ctrl_out : imm_ctrl_in), .q(imm_ctrl_out) );
dff_proc alu_result[31:0](.clk(clk), .rst(rst), .d(stall ? alu_result_out : alu_result_in), .q(alu_result_out));

endmodule