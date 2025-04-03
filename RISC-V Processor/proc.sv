// https://github.com/AllieBacholl/face-filter.git

module proc(
    input clk, rst, EXT,
    output err
);

// Intermediate Signals
wire EXT_ID, EXT_EXE, EXT_MEM;
wire [31:0] interrupt_handling_addr, branch_jump_addr;
wire pc_next_sel;
wire pcJalSrc_ID, pcJalSrc_EXE;
wire [31:0] pc_FETCH, pc_ID, pc_EXE, pc_MEM, pc_WB;
wire [31:0] pcPlus4_FETCH, pcPlus4_ID, pcPlus4_EXE, pcPlus4_MEM, pcPlus4_WB;
wire [31:0] instr_FETCH, instr_ID, instr_EXE, instr_MEM, instr_WB;
wire err_FETCH, err_ID;
wire [4:0] rs1_ID, rs1_EXE, rs1_MEM, rs1_WB;
wire [4:0] rs2_ID, rs2_EXE, rs2_MEM, rs2_WB;
wire [4:0] rd_ID, rd_EXE, rd_MEM, rd_WB;
wire [31:0] rs1_data_ID, rs1_data_EXE, rs1_data_MEM, rs1_data_WB;
wire [31:0] rs2_data_ID, rs2_data_EXE, rs2_data_MEM, rs2_data_WB;
wire [31:0] imm_res_ID, imm_res_EXE;
wire reg_write_ID, reg_write_EXE, reg_write_MEM, reg_write_WB;
wire mem_write_en_ID, mem_write_en_EXE, mem_write_en_MEM;
wire mem_read_ID, mem_read_EXE, mem_read_MEM;
wire mem_sign_ID, mem_sign_EXE, mem_sign_MEM;
wire [1:0] mem_length_ID, mem_length_EXE, mem_length_MEM;
wire jump_ID, jump_EXE;
wire branch_ID, branch_EXE;
wire result_spcJalSrc_IDel_ID;

wire [1:0] result_sel_EXE, result_sel_MEM, result_sel_WB, alu_src_sel_B_ID;
wire [1:0] alu_src_sel_B_EXE, alu_src_sel_B_in, result_sel_out;
wire [4:0] alu_op_ID, alu_op_EXE;
wire [2:0] imm_ctrl_ID, imm_ctrl_EXE;
wire [1:0] forwarding_a, forwarding_b;
wire [31:0] alu_result_EXE, alu_result_MEM;
wire [31:0] mem_data_MEM, mem_data_WB;
wire err_FETCH_out, err_ID_out;
wire [31:0] write_data_WB, alu_result_WB;
wire [1:0] result_sel_ID;

wire [31:0] write_data_EXE, write_data_MEM;

wire interrupt_ctrl, interrupt_en, forwarding_mem;
wire flush_IF_ID, flush_ID_EXE, stall_IF, stall_IF_ID;

assign err = 1'b0;

// Fetch
fetch fetch(
    // Input
    .clk(clk), 
    .rst(rst), 
    .EXT_in(EXT), 
    .interrupt_en(interrupt_en),
    .interrupt_handling_addr(interrupt_handling_addr),
    .branch_jump_addr(branch_jump_addr), 
    .alu_result_EXE(alu_result_EXE),
    .pc_next_sel(pc_next_sel), 
    .pcJalSrc_EXE(pcJalSrc_EXE),
    .stall(stall_IF),
    // Output
    .pcPlus4(pcPlus4_FETCH), 
    .pc(pc_FETCH),
    .instr(instr_FETCH),
    .err(err_FETCH)
);

// IF_ID
IF_ID IF_ID(
    // Input
    .clk(clk), 
    .rst(rst), 
    .err_in(err_FETCH),
    .EXT(EXT), 
    .pc_in(pc_FETCH),
    .instr_in(instr_FETCH),
    .pcPlus4_in(pcPlus4_FETCH),
    .stall(stall_IF_ID),
    .flush(flush_IF_ID),
    .mem_read_in(mem_read_ID),
    .mem_sign_in(mem_sign_ID),
    .mem_length_in(mem_length_ID),
    // Output
    .err_out(err_FETCH_out),
    .EXT_out(EXT_ID), 
    .pc_out(pc_ID),
    .instr_out(instr_ID),
    .pcPlus4_out(pcPlus4_ID),
    .mem_read_out(mem_read_EXE),
    .mem_sign_out(mem_sign_EXE),
    .mem_length_out(mem_length_EXE)
);


// Decode
decode decode(
    // Input
    .rst(rst),
    .instr(instr_ID),
    .writeData(write_data_WB), // from WB stage
    .reg_write_WB(reg_write_WB),
    .rd_WB(rd_WB),
    // Outputs
    .imm_res_ID(imm_res_ID),
    .reg_write_ID(reg_write_ID), 
    .mem_write_en_ID(mem_write_en_ID), 
    .jump_ID(jump_ID), 
    .branch_ID(branch_ID),
    .result_sel_ID(result_sel_ID),
    .pcJalSrc_ID(pcJalSrc_ID),
    .alu_src_sel_B_ID(alu_src_sel_B_EXE),
    .alu_src_sel_A_ID(), // TODO do we need
    .alu_op_ID(alu_op_ID),
    .imm_ctrl_ID(imm_ctrl_ID),
    .instr_12_ID(), 
    .instr_14_ID(),
    .rs1_ID(rs1_ID), 
    .rs2_ID(rs2_ID), 
    .rd_ID(rd_ID),
    .rs1_data_ID(rs1_data_ID), 
    .rs2_data_ID(rs2_data_ID),
    .mem_read_ID(mem_read_ID), 
    .mem_sign_ID(mem_sign_ID),
    .mem_length_ID(mem_length_ID),
    .err_ID(err_ID)
);

// ID_EXE
ID_EX ID_EX(
    // Input
    .clk(clk), 
    .rst(rst), 
    .err_in(err_ID), // TODO do we need
    .EXT(EXT_ID), 
    .flush(flush_ID_EXE),
    .pc_in(pc_ID),
    .pcPlus4_in(pcPlus4_ID),
    .rs1_data_in(rs1_data_ID), 
    .rs2_data_in(rs2_data_ID),
    .imm_res_in(imm_res_ID),
    .rs1_in(rs1_ID), 
    .rs2_in(rs2_ID), 
    .rd_in(rd_ID),
    .reg_write_in(reg_write_ID), 
    .mem_write_en_in(mem_write_en_ID), 
    .jump_in(jump_ID), 
    .branch_in(branch_ID),
    .result_sel_in(result_sel_ID),
    .pcJalSrc_in(pcJalSrc_ID),
    .alu_src_sel_B_in(alu_src_sel_B_ID),
    .alu_src_sel_A_in(), 
    .alu_op_in(alu_op_ID),
    .imm_ctrl_in(imm_ctrl_ID),
    .mem_read_in(mem_read_ID),
    .mem_sign_in(mem_sign_ID),
    .mem_length_in(mem_length_ID),
    .instr_in(instr_ID),
    // Output
    .err_out(err_ID_out),
    .EXT_out(EXT_EXE),
    .pc_out(pc_EXE), 
    .pcPlus4_out(pcPlus4_EXE),
    .rs1_data_out(rs1_data_EXE), 
    .rs2_data_out(rs2_data_EXE),
    .imm_res_out(imm_res_EXE),
    .rs1_out(rs1_EXE), 
    .rs2_out(rs2_EXE), 
    .rd_out(rd_EXE),
    .reg_write_out(reg_write_EXE), 
    .mem_write_en_out(mem_write_en_EXE), 
    .jump_out(jump_EXE), 
    .branch_out(branch_EXE),
    .result_sel_out(result_sel_EXE),
    .pcJalSrc_out(pcJalSrc_EXE),
    .alu_src_sel_B_out(alu_src_sel_B_EXE),
    .alu_src_sel_A_out(), 
    .alu_op_out(alu_op_EXE),
    .imm_ctrl_out(imm_ctrl_EXE),
    .mem_read_out(mem_read_EXE),
    .mem_sign_out(mem_sign_EXE),
    .mem_length_out(mem_length_EXE),
    .instr_out(instr_EXE)
);

// Execute
execute execute(
    // Input
    .rst(rst), 
    .EXT(EXT_EXE),
    .pcPlus4_in(pcPlus4_EXE), 
    .pc_in(pc_EXE),
    .instr_in(instr_EXE),
    .jump_EXE(jump_EXE), 
    .branch_EXE(branch_EXE),
    .alu_src_sel_B_EXE(alu_src_sel_B_EXE),
    .imm_ctrl_EXE(imm_ctrl_EXE),
    .aluOp(alu_op_EXE),
    .rs1_EXE(rs1_EXE), 
    .rs2_EXE(rs2_EXE), 
    .rd_EXE(rd_EXE),
    .rs1_data_EXE(rs1_data_EXE), 
    .rs2_data_EXE(rs2_data_EXE), // rs2_data = write_data_MEM
    .imm_res_EXE(imm_res_EXE),
    // Forwarding
    .forwarding_a(forwarding_a), 
    .forwarding_b(forwarding_b),
    .rs1_data_MEM(rs1_data_MEM),
    .rs2_data_MEM(rs2_data_MEM),
    .rs1_data_WB(rs1_data_WB),
    .rs2_data_WB(rs2_data_WB),
    // Output
    .EXT_out(EXT_EXE),
    .pc_next_sel(pc_next_sel),
    .branch_jump_addr(branch_jump_addr),
    .alu_result_EXE(alu_result_EXE) ,   // Result of computation
    .write_data_EXE(write_data_EXE)
);

// EX_ME
EX_ME EX_ME(
    // Inputs
    .clk(clk), 
    .rst(rst), 
    .EXT(EXT_EXE), 
    .stall(1'b0),
    .pc_in(pc_EXE),
    .pcPlus4_in(pcPlus4_EXE),
    .rs1_data_in(rs1_data_EXE), 
    .rs2_data_in(rs2_data_EXE),
    .rs1_in(rs1_EXE), 
    .rs2_in(rs2_EXE), 
    .rd_in(rd_EXE),
    .reg_write_in(reg_write_EXE), 
    .mem_write_en_in(mem_write_en_EXE),
    .result_sel_in(result_sel_EXE),
    .mem_sign_in(mem_sign_EXE),
    .mem_length_in(mem_length_EXE),
    .mem_read_in(mem_read_EXE),
    .alu_result_in(alu_result_EXE),
    .write_data_in(write_data_EXE),
    // Outputs
    .pc_out(pc_MEM), 
    .pcPlus4_out(pcPlus4_MEM),
    .rs1_data_out(rs1_data_MEM), 
    .rs2_data_out(rs2_data_MEM),
    .rs1_out(rs1_MEM), 
    .rs2_out(rs2_MEM), 
    .rd_out(rd_MEM),
    .reg_write_out(reg_write_MEM), 
    .mem_write_en_out(mem_write_en_MEM),
    .result_sel_out(result_sel_MEM),
    .mem_sign_out(mem_sign_MEM),
    .mem_length_out(mem_length_MEM),
    .mem_read_out(mem_read_MEM),
    .alu_result_out(alu_result_MEM),
    .write_data_out(write_data_MEM),
    .EXT_out(EXT_MEM)
);

// Forwarding mem mux
wire [31:0] input_mem_data;
assign input_mem_data = (forwarding_mem) ? write_data_WB : write_data_MEM;

// Memory
memory memory(
    // Input
    .clk(clk),
    .rst(rst),
    .reg_write_MEM(reg_write_MEM), 
    .mem_write_en_MEM(mem_write_en_MEM), 
    .mem_read_en_MEM(mem_read_MEM),
    .length_MEM(mem_length_MEM),
    .sign_MEM(mem_sign_MEM),
    .alu_result_MEM(alu_result_MEM),
    .write_data_MEM(input_mem_data),
    // Output
    .mem_data_MEM(mem_data_MEM)
);

// ME_WB
ME_WB ME_WB(
    // Inputs
    .clk(clk), 
    .rst(rst), 
    .stall(1'b0),
    .pc_in(pc_MEM),
    .pcPlus4_in(pcPlus4_MEM),
    .rs1_data_in(rs1_data_MEM), 
    .rs2_data_in(rs2_data_MEM),
    .rs1_in(rs1_MEM), 
    .rs2_in(rs2_MEM), 
    .rd_in(rd_MEM),
    .reg_write_in(reg_write_MEM), 
    .mem_data_in(mem_data_MEM),
    .result_sel_in(result_sel_MEM),
    .alu_result_in(alu_result_MEM),
    // Outputs
    .pc_out(pc_WB), 
    .pcPlus4_out(pcPlus4_WB),
    .rs1_data_out(rs1_data_WB), 
    .rs2_data_out(rs2_data_WB),
    .rs1_out(rs1_WB), 
    .rs2_out(rs2_WB), 
    .rd_out(rd_WB),
    .reg_write_out(reg_write_WB), 
    .mem_data_out(mem_data_WB),
    .result_sel_out(result_sel_WB),
    .alu_result_out(alu_result_WB)
);

// Writeback
writeback writeback(
    // Input
    .result_set_WB(result_sel_WB),
    .alu_result_WB(alu_result_WB),
    .mem_data_WB(mem_data_WB),
    .pcPlus4_WB(pcPlus4_WB),
    // Output
    .write_data_WB(write_data_WB)
);

// Hazard Detection
hazard_detection hazard_detection(
    // Input
    .mem_write_en_ID(mem_write_en_ID), 
    .interrupt_ctrl(interrupt_ctrl),
    .rs1_ID(rs1_ID), 
    .rs2_ID(rs2_ID),
    .pc_next_sel(pc_next_sel),
    .rs1_EXE(rs1_EXE), 
    .rs2_EXE(rs2_EXE), 
    .rd_EXE(rd_EXE),
    .result_sel_EXE(result_sel_EXE),
    .rs1_MEM(rs1_MEM), 
    .rs2_MEM(rs2_MEM), 
    .rd_MEM(rd_MEM),
    .rd_WB(rd_WB), 
    .reg_write_WB(reg_write_WB),
    // Output
    .flush_IF_ID(flush_IF_ID), 
    .flush_ID_EXE(flush_ID_EXE), 
    .stall_IF(stall_IF), 
    .stall_IF_ID(stall_IF_ID),
    .interrupt_en(interrupt_en),
    .forwarding_A(forwarding_a), 
    .forwarding_B(forwarding_b),
    .forwarding_mem(forwarding_mem)
);

// Interrupt Handler
interrupt_handler interrupt_handler(
    // Input
    .clk(clk), 
    .rst(rst),
    .external(EXT_MEM),
    // Output
    .interrupt_handling_addr(interrupt_handling_addr),
    .interrupt_ctrl(interrupt_ctrl)
);


endmodule