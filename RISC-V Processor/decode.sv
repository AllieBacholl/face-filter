module decode (
    input EXT, rst,
    input [31:0] pc_in,
    input [31:0] instr_ID,
    input [31:0] pcPlus4_in,
    input [31:0] writeData,
    
    // control signals outputs
    output [31:0] pcPlus4_out, pc_out,
    output [31:0] instr_out,
    output reg_write_ID, mem_write_en_ID, jump_ID, branch_ID,
    output [1:0] result_sel_ID,
    output pcJalSrc_ID,
    output [1:0] alu_src_sel_B_ID,
    output alu_src_sel_A_ID,
    output [16:0] alu_ctrl_ID,
    output [2:0] imm_ctrl_ID,

    // data sinals outputs
    output instr_12_ID, instr_14_ID,
    output EXT_out,
    output [4:0] rs1_ID, rs2_ID, rd_ID,
    output [31:0] rs1_data_ID, rs2_data_ID,

);




endmodule
