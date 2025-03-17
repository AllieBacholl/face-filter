module ID_EX(
    input clk, rst, err_in, EXT,
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

    


);




endmodule