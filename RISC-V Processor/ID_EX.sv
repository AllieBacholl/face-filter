module ID_EX(
    input clk, rst, err_in, EXT, flush,
    input [31:0] pc_in,
    input [31:0] pcPlus4_in,
    input [31:0] rs1_data_in, rs2_data_in,
    input [31:0] imm_res_in,
    input [4:0] rs1_in, rs2_in, rd_in,

    input reg_write_in, mem_write_en_in, jump_in, branch_in,
    input [1:0] result_sel_in,
    input pcJalSrc_in,
    input [1:0] alu_src_sel_B_in,
    input alu_src_sel_A_in,
    input [4:0] alu_op_in,
    input [2:0] imm_ctrl_in,
    input mem_read_in, mem_sign_in,
    input [1:0] mem_length_in,

    output [31:0] pc_out, pcPlus4_out,
    output [31:0] rs1_data_out, rs2_data_out,
    output [31:0] imm_res_out,
    output [4:0] rs1_out, rs2_out, rd_out,

    output reg_write_out, mem_write_en_out, jump_out, branch_out,
    output [1:0] result_sel_out,
    output pcJalSrc_out,
    output [1:0] alu_src_sel_B_out,
    output alu_src_sel_A_out,
    output [4:0] alu_op_out,
    output [2:0] imm_ctrl_out,
    output EXT_out,
    output mem_read_out, mem_sign_out,
    output [1:0] mem_length_out,
    output err_out
);


dff pc [31:0] ( .clk(clk), .rst(rst), .d(flush ? 1'b0 : pc_in), .q(pc_out) );
dff pcPlus4 [31:0] ( .clk(clk), .rst(rst), .d(flush ? 1'b0 : pcPlus4_in), .q(pcPlus4_out) );
dff rs1_data [31:0] ( .clk(clk), .rst(rst), .d(flush ? 1'b0 : rs1_data_in), .q(rs1_data_out) );
dff rs2_data [31:0] ( .clk(clk), .rst(rst), .d(flush ? 1'b0 : rs2_data_in), .q(rs2_data_out) );
dff imm_res [31:0] (.clk(clk), .rst(rst), .d(flush ? 1'b0 : imm_res_in), .q(imm_res_out) );
dff rs1 [4:0] ( .clk(clk), .rst(rst), .d(flush ? 1'b0 : rs1_in), .q(rs1_out) );
dff rs2 [4:0] ( .clk(clk), .rst(rst), .d(flush ? 1'b0 : rs2_in), .q(rs2_out) );
dff rd [4:0] ( .clk(clk), .rst(rst), .d(flush ? 1'b0 : rd_in), .q(rd_out) );

dff reg_write ( .clk(clk), .rst(rst), .d(flush ? 1'b0 : reg_write_in), .q(reg_write_out) );
dff mem_write_en ( .clk(clk), .rst(rst), .d(flush ? 1'b0 : mem_write_en_in), .q(mem_write_en_out) );
dff jump ( .clk(clk), .rst(rst), .d(flush ? 1'b0 : jump_in), .q(jump_out) );
dff branch( .clk(clk), .rst(rst), .d(flush ? 1'b0 : branch_in), .q(branch_out) );
dff result_sel [1:0] ( .clk(clk), .rst(rst), .d(flush ? 1'b0 : result_sel_in), .q(result_sel_out) );
dff pcJalSrc( .clk(clk), .rst(rst), .d(flush ? 1'b0 : pcJalSrc_in), .q(pcJalSrc_out) );
dff alu_src_sel_B [1:0] ( .clk(clk), .rst(rst), .d(flush ? 1'b0 : alu_src_sel_B_in), .q(alu_src_sel_B_out) );
dff alu_src_sel_A( .clk(clk), .rst(rst), .d(flush ? 1'b0 : alu_src_sel_A_in), .q(alu_src_sel_A_out) );
dff alu_op [4:0] ( .clk(clk), .rst(rst), .d(flush ? 1'b0 : alu_op_in), .q(alu_op_out) );
dff imm_ctrl [2:0] ( .clk(clk), .rst(rst), .d(flush ? 1'b0 : imm_ctrl_in), .q(imm_ctrl_out) );
dff err(.q(err_out), .d(flush ? 1'b0 : err_in), .clk(clk), .rst(rst));
dff ext(.q(EXT_out), .d(flush ? 1'b0: EXT), .clk(clk), .rst(rst));
dff mem_read(.q(mem_read_out), .d(flush ? 1'b0: mem_read_in), .clk(clk), .rst(rst));
dff mem_sign(.q(mem_sign_out), .d(flush ? 1'b0 : mem_sign_in), .clk(clk), .rst(rst));
dff mem_length [1:0] (.q(mem_length_out), .d(flush ? 1'b0: mem_length_in), .clk(clk), .rst(rst));

endmodule