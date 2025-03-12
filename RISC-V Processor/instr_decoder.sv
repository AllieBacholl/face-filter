module instr_decoder(
    input [6:0] opcode, 
    input [2:0] funct3,
    input funct7,

    output reg_write, mem_write_en, jump, branch,
    output [1:0] result_sel,
    output pcJalSrc,
    output [1:0] alu_src_sel_A, alu_src_sel_B,
    output [2:0] alu_ctrl,
    output [1:0] imm_ctrl
);




endmodule
