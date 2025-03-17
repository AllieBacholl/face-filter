module hazard_detection(
    input mem_write_en_ID, interrupt_ctrl,
    input [4:0] rs1_ID, rs2_ID,
    input pc_next_sel, 
    input [4:0] rs1_EXE, rs2_EXE, rd_EXE,
    input [1:0] result_sel_EXE,
    input [4:0] rs1_MEM, rs2_MEM, rd_MEM, 

    input rd_WB, reg_write_WB,

    output flush_IF_ID, flush_ID_EXE, stall_IF, stall_IF_ID,
    output interrupt_en,
    output [1:0] forwarding_A, forwarding_B,
    output forwarding_mem,

);

// forwardingA == 00 then rs1_EXE; 01 then result_WB; 11 then alu_res_MEM
// similar for forwardingB but just rs2

//forwarding_mem determines the data into memory; 0 indicates write_data_mem(forwarded from prev pipeline like write_data_EXE)
// 1 indicates result_WB


endmodule