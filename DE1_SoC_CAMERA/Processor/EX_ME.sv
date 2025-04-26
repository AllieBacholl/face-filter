module EX_ME(
    input clk, rst, EXT, stall, flush,
    input [31:0] pc_in,
    input [31:0] pcPlus4_in,
    input [31:0] rs1_data_in, rs2_data_in,
    input [4:0] rs1_in, rs2_in, rd_in,

    input reg_write_in, mem_write_en_in,
    input [1:0] result_sel_in,
    input mem_read_in, mem_sign_in,
    input [1:0] mem_length_in,
    input [31:0] write_data_in,
    input [31:0] alu_result_in,

    output [31:0] pc_out, pcPlus4_out,
    output [31:0] rs1_data_out, rs2_data_out,
    output [4:0] rs1_out, rs2_out, rd_out,

    output reg_write_out, mem_write_en_out,
    output [1:0] result_sel_out,
    output EXT_out,
    output mem_read_out, mem_sign_out,
    output [31:0] write_data_out,
    output [31:0] alu_result_out,
    output [1:0] mem_length_out
);


my_dff pc [31:0]( .clk(clk), .rst(rst), .d(flush ? 1'b0 : (stall ? pc_out : pc_in)), .q(pc_out) );
my_dff pcPlus4 [31:0]( .clk(clk), .rst(rst), .d(flush ? 1'b0 : (stall ? pcPlus4_out : pcPlus4_in)), .q(pcPlus4_out) );
my_dff rs1_data [31:0]( .clk(clk), .rst(rst), .d(flush ? 1'b0 : (stall ? rs1_data_out : rs1_data_in)), .q(rs1_data_out) );
my_dff rs2_data [31:0]( .clk(clk), .rst(rst), .d(flush ? 1'b0 : (stall ? rs2_data_out : rs2_data_in)), .q(rs2_data_out) );
my_dff rs1 [4:0]( .clk(clk), .rst(rst), .d(flush ? 1'b0 : (stall ? rs1_out : rs1_in)), .q(rs1_out) );
my_dff rs2 [4:0]( .clk(clk), .rst(rst), .d(flush ? 1'b0 : (stall ? rs2_out : rs2_in)), .q(rs2_out) );
my_dff rd [4:0]( .clk(clk), .rst(rst), .d(flush ? 1'b0 : (stall ? rd_out : rd_in)), .q(rd_out) );

my_dff reg_write( .clk(clk), .rst(rst), .d(flush ? 1'b0 : (stall ? reg_write_out : reg_write_in)), .q(reg_write_out) );
my_dff mem_write_en( .clk(clk), .rst(rst), .d(flush ? 1'b0 : (stall ? mem_write_en_out : mem_write_en_in)), .q(mem_write_en_out) );
my_dff result_sel [1:0]( .clk(clk), .rst(rst), .d(flush ? 1'b0 : (stall ? result_sel_out : result_sel_in)), .q(result_sel_out) );
my_dff imm_ctrl( .clk(clk), .rst(rst), .d(flush ? 1'b0 : (stall ? imm_ctrl_out : imm_ctrl_in)), .q(imm_ctrl_out) );
my_dff ext(.q(EXT_out), .d(flush ? 1'b0 : EXT), .clk(clk), .rst(rst));
my_dff mem_read(.q(mem_read_out), .d(flush ? 1'b0 : mem_read_in), .clk(clk), .rst(rst));
my_dff mem_sign(.q(mem_sign_out), .d(flush ? 1'b0 : mem_sign_in), .clk(clk), .rst(rst));
my_dff mem_length [1:0](.q(mem_length_out), .d(flush ? 1'b0 : mem_length_in), .clk(clk), .rst(rst));

my_dff write_data [31:0](.clk(clk), .rst(rst), .d(flush ? 1'b0 : (stall ? write_data_out : write_data_in)), .q(write_data_out));
my_dff alu_result [31:0](.clk(clk), .rst(rst), .d(flush ? 1'b0 : (stall ? alu_result_out : alu_result_in)), .q(alu_result_out));

endmodule