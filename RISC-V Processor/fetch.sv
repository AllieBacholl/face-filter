module fetch(
    input clk, rst, EXT_in, interrupt_en,
    input [31:0] interrupt_handling_addr,
    input [31:0] branch_jump_addr, alu_result_EXE, // pc from id stage
    input pc_next_sel, pcJalSrc_EXE,
    input stall,

    output [31:0] pcPlus4, pc, // pc is current_pc
    output [31:0] instr,
    output err
);

logic [31:0] pc_back, pc_next;

assign pc_back = pc_next_sel ? (pcJalSrc_EXE ? alu_result_EXE : branch_jump_addr) : pcPlus4;
assign pc_next = interrupt_en ? interrupt_handling_addr : pc_back;

// FF storing the current PC
pc_reg PC_REG (.q(pc), .d(pc_next), .clk(clk), .rst(rst), .stall(stall));

// instruction memory
instr_mem IM (.clk(clk), .addr(pc), .rd_en(1'b1), .instr(instr));

assign pcPlus4 = pc + 32'h4;


endmodule