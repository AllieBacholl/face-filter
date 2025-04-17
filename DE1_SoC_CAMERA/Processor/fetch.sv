module fetch(
    input clk, rst, EXT_in, interrupt_en,
    input [31:0] interrupt_handling_addr,
    input [31:0] branch_jump_addr, alu_result_EXE, // pc from id stage
    input pc_next_sel, pcJalSrc_EXE,
    input stall, 
    input jalr_en,
    output [31:0] pcPlus4, pc, // pc is current_pc
    output [31:0] instr,
    output err
);

    wire [31:0] pc_back, pc_next;
    reg [31:0] pc_reg;
    
    // Logic for calculating pc_back and pc_next
    
        // assign pc_back = pc_next_sel ? (pcJalSrc_EXE ? alu_result_EXE : branch_jump_addr) : pcPlus4;
        // assign pc_next = interrupt_en ? interrupt_handling_addr : pc_back;

    assign err = 1'b0;

    assign pc_back = (pc_next_sel === 1'bx) ? pcPlus4 :
                    (pc_next_sel ? (pcJalSrc_EXE ? (jalr_en ? alu_result_EXE : alu_result_EXE - 4) : branch_jump_addr - 4) : pcPlus4);

    assign pc_next = (interrupt_en === 1'bx) ? pc_back :
                    (interrupt_en ? interrupt_handling_addr : pc_back);

    
    // PC register with reset and stall capability
    always @(posedge clk or posedge rst) begin
        if (rst) 
            pc_reg <= 32'h0; // Reset to initial value of 0
        else if (!stall)
            pc_reg <= pc_next; // Update PC when not stalled
    end
    
    // Assign pc output from pc_reg
    assign pc = pc_reg;
    
    // Calculate PC+4
    assign pcPlus4 = pc + 4;
    
    // Instruction memory
    // instr_mem IM [31:0] (.clk(clk), .addr(pc), .rd_en(1'b1), .instr(instr));
	 
	 instr_mem_onchip u0 (
        .clk_clk        (clk),        	//   clk.clk
        .mem_address    ((pc << 2)),    		//   mem.address
        .mem_clken      (1'b1),      	//      .clken
        .mem_chipselect (1'b1), 			//      .chipselect
        .mem_write      (1'b0),      	//      .write
        .mem_readdata   (instr),   		//      .readdata
        .mem_writedata  (),  				//      .writedata
        .mem_byteenable (4'b1111), 		//      .byteenable
        .reset_reset_n  (rst)   			// reset.reset_n
    );

    
endmodule