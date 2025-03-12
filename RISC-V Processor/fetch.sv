module fetch(
    input clk, rst, EXT,
    input [31:0] interrupt_handling_addr,
    input pc_next_sel,
    input pcJalSrcFromEXE,

    output [31:0] pcPlus4, pc, // pc is current_pc
    output [31:0] instr,


    output err
);



endmodule