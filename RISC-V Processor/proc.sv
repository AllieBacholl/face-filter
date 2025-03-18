// https://github.com/AllieBacholl/face-filter.git

module proc(
    input clk, rst, EXT
    output err
);

// Intermediate Signals
wire EXT_ID, EXT_EXE, EXT_MEM, EXT_WB;
wire interrupt_en;
wire [31:0] interrupt_handling_addr, branch_jump_addr;
wire pc_next_sel;
wire pcJalSrc_ID, pcJalSrc_EXE;
wire pc_FETCH, pc_ID, pc_EXE, pc_MEM, pc_WB;
wire pcPlus4_FETCH, pcPlus4_ID, pcPlus4_EXE, pcPlus4_MEM, pcPlus4_WB;
wire instr_FETCH, instr_ID, instr_EXE, instr_MEM, instr_WB;
wire err_FETCH, err_ID;
wire [4:0] rs1_ID, rs1_EXE, rs1_MEM, rs1_WB;
wire [4:0] rs2_ID, rs2_EXE, rs2_MEM, rs2_WB;
wire [4:0] rd_ID, rd_EXE, rd_MEM, rd_WB;
wire [31:0] rs1_data_ID, rs1_data_EXE, rs1_data_MEM, rs1_data_WB;
wire [31:0] rs2_data_ID, rs2_data_EXE, rs2_data_MEM, rs2_data_WB;
wire [31:0] imm_res_ID, imm_res_EXE:
wire reg_write_ID, reg_write_EXE, reg_write_MEM, reg_write_WB;
wire mem_write_en_ID, mem_write_en_EXE, mem_write_en_MEM;
wire mem_read_ID, mem_read_EXE, mem_read_MEM;
wire mem_sign_ID, mem_sign_EXE, mem_sign_MEM;
wire [1:0] mem_length_ID, mem_length_EXE, mem_length_MEM;
wire jump_ID, jump_EXE;
wire branch_ID, branch_EXE;
wire result_spcJalSrc_IDel_ID, result_sel_EXE, result_sel_MEM, result_sel_WB;
wire pcJalSrc_ID, pcJalSrc_EXE;
wire [1:0] alu_src_sel_B_EXE;
wire [4:0] alu_op_ID, alu_op_EXE;
wire [2:0] imm_ctrl_ID, imm_ctrl_EXE;
wire [1:0] forwarding_a, forwarding_b;
wire [31:0] alu_result_EXE, alu_result_MEM;
wire pc_next_sel;
wire [31:0] mem_data_MEM, mem_data_WB;

wire interrupt_ctrl, interrupt_en, forwarding_mem;
wire flush_IF_ID, flush_ID_EXE, stall_IF, stall_IF_ID;


// Fetch
fetch(
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
    .stall(),
    // Output
    .pcPlus4(pcPlus4_FETCH), 
    .pc(pc_FETCH),
    .instr(instr_FETCH),
    .err(err_FETCH)
);

// Decode
decode (
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
    .alu_src_sel_A_ID(),
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

// Execute
execute (
    // Input
    .rst(rst), 
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
    .pc_next_sel(pc_next_sel),
    .branch_jump_addr(branch_jump_addr),
    .alu_result_EXE(alu_result_EXE)    // Result of computation
);

// Forwarding mem mux
wire [31:0] input_mem_data;
assign input_mem_data = (forwarding_mem) ? write_data_WB : rs2_data_MEM;

// Memory
memory (
    // Input
    .rst(rst),
    .reg_write_MEM(reg_write_MEM), 
    .mem_write_en_MEM(mem_write_en_MEM), 
    .mem_read_en_MEM(mem_read_en_MEM),
    .length_MEM(mem_length_MEM),
    .sign_MEM(mem_sign_MEM),
    .alu_result_MEM(alu_result_MEM),
    .write_data_MEM(input_mem_data),
    // Output
    .mem_data_MEM(mem_data_MEM)
);

// Writeback
writeback (
    // Input
    .result_set_WB(result_sel_WB),
    .alu_result_WB(alu_result_WB),
    .mem_data_WB(mem_data_WB),
    .pcPlus4_WB(pcPlus4_WB),
    // Output
    .write_data_WB(write_data_WB)
);

// Hazard Detection
hazard_detection(
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
interrupt_handler(
    // Input
    clk(clk), 
    rst(rst),
    external(EXT_MEM),
    // Output
    interrupt_handling_addr(interrupt_handling_addr),
    interrupt_ctrl(interrupt_ctrl)
);


endmodule