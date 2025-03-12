module fetch(
    input clk, rst, EXT_in, interrupt_en,
    input [31:0] interrupt_handling_addr,
    input [31:0] branch_jump_addr, alu_resultFromID, // pc from id stage
    input pc_next_sel, pcJalSrcFromEXE,

    output [31:0] pcPlus4, pc, // pc is current_pc
    output [31:0] instr,
    output EXT_out, // output EXT
    output err
);

logic [31:0] pc_back, pc_next;

assign pc_back = pc_next_sel ? (pcJalSrcFromEXE ? alu_resultFromID : branch_jump_addr) : pcPlus4;
assign pc_next = interrupt_en ? interrupt_handling_addr : pc_back;

// FF storing the current PC
dff pc_reg (.q(pc), .d(pc_next), .clk(clk), .rst(rst));

// instruction memory
instr_mem IM (.clk(clk), .addr(pc), .rd_en(1'b1), .instr(instr));

assign pcPlus4 = pc + 32'h4;


endmodule