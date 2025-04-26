module decode (
    input rst, clk, 
    input [31:0] instr,
    input [31:0] writeData, // from WB stage
    input reg_write_WB,
    input [4:0] rd_WB,
    input [31:0] register_accelerator_in [0 : 7],
    
    // control signals outputs
    output [31:0] imm_res_ID,
    output reg_write_ID, mem_write_en_ID, jump_ID, branch_ID,
    output [1:0] result_sel_ID,
    output pcJalSrc_ID,
    output [1:0] alu_src_sel_B_ID,
    output alu_src_sel_A_ID,
    output [4:0] alu_op_ID,
    output [2:0] imm_ctrl_ID,
    output jalr_en_ID,

    // data sinals outputs
    output instr_12_ID, instr_14_ID,
    output [4:0] rs1_ID, rs2_ID, rd_ID,
    output [31:0] rs1_data_ID, rs2_data_ID, 
    output [31:0 ]register_accelerator_out [0 : 7],
    output mem_read_ID, mem_sign_ID,
    output [1:0] mem_length_ID,
    output err_ID,
    output polling

);

logic err_reg, err_decode;

logic polling_reg;

assign err_ID = err_reg | err_decode;

assign polling = polling_reg;

assign instr_12_ID = instr[12];
assign instr_14_ID = instr[14];

assign rs1_ID = instr[19:15];
assign rs2_ID = instr[24:20];
assign rd_ID = instr[11:7];

immediate_execution IE(
    .instruction(instr),         // Complete 32-bit instruction
    .imm_ctrl_ID(imm_ctrl_ID),          // Control signal for immediate type
    .imm_res_ID(imm_res_ID)    // Generated immediate value
);

instr_decoder instr_decoder(
    .opcode(instr[6:0]), 
    .funct3(instr[14:12]),
    .funct7(instr[31:25]),

    .reg_write(reg_write_ID), .mem_write_en(mem_write_en_ID), .jump(jump_ID), .branch(branch_ID),
    .result_sel(result_sel_ID),
    .pcJalSrc(pcJalSrc_ID),
    .alu_src_sel_B(alu_src_sel_B_ID),
    .alu_src_sel_A(alu_src_sel_A_ID),
    .alu_op(alu_op_ID),
    .imm_ctrl(imm_ctrl_ID),
    .mem_read(mem_read_ID),
    .mem_sign(mem_sign_ID),
    .mem_length(mem_length_ID),
    .jalr_en(jalr_en_ID),
    .err(err_decode)
);

// never use r0 and r1
regFile_bypass RF(
    .clk(clk), .rst(rst),
    .read1RegSel(rs1_ID), .read2RegSel(rs2_ID), .writeRegSel(rd_WB), .writeData(writeData), .writeEn(reg_write_WB),
    .read1Data(rs1_data_ID = (rs1_ID == 5'b00001) ? register_accelerator_out_reg[1] : rs1_data_ID), .read2Data(rs2_data_ID), .err(err_reg)
);

reg [31:0] register_accelerator_out_reg [0:7];
// Register accelerator for bypassing
assign register_accelerator_out[0] = register_accelerator_out_reg[0];
assign register_accelerator_out[1] = register_accelerator_out_reg[1];
assign register_accelerator_out[2] = register_accelerator_out_reg[2];
assign register_accelerator_out[3] = register_accelerator_out_reg[3];
assign register_accelerator_out[4] = register_accelerator_out_reg[4];
assign register_accelerator_out[5] = register_accelerator_out_reg[5];
assign register_accelerator_out[6] = register_accelerator_out_reg[6];
assign register_accelerator_out[7] = register_accelerator_out_reg[7];

always_ff @(negedge clk or posedge rst) begin
    if (rst) begin
        // Reset all 8 registers
        register_accelerator_out_reg[0] <= 32'h0;
        register_accelerator_out_reg[1] <= 32'h0;
        register_accelerator_out_reg[2] <= 32'h0;
        register_accelerator_out_reg[3] <= 32'h0;
        register_accelerator_out_reg[4] <= 32'h0;
        register_accelerator_out_reg[5] <= 32'h0;
        register_accelerator_out_reg[6] <= 32'h0;
        register_accelerator_out_reg[7] <= 32'h0; // for reset sdram
    end else if (reg_write_WB && rd_WB < 5'd8) begin
        // Write to the selected register if index is in bounds
        register_accelerator_out_reg[rd_WB] <= writeData;
    end
end


always @(*) begin
    polling_reg = 32'b0; // Default polling to 0
    
    if (register_accelerator_in[7] == 32'b0) begin // Branch instruction
        polling_reg = 1'b1; // Set polling to 1 for branch instructions
    end else begin
        polling_reg = 1'b0; // Reset polling for other instructions
    end
end

endmodule
