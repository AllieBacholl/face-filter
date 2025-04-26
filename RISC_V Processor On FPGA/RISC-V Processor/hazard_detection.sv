module hazard_detection(
    input mem_write_en_ID, interrupt_ctrl,
    input [4:0] rs1_ID, rs2_ID,
    input pc_next_sel,
    input [4:0] rs1_EXE, rs2_EXE, rd_EXE,
    input [1:0] result_sel_EXE, result_sel_MEM,
    input [4:0] rs1_MEM, rs2_MEM, rd_MEM,
    input [4:0] rd_WB,
    input reg_write_WB,
    output logic flush_IF_ID, flush_ID_EXE, flush_EXE_MEM, stall_IF, stall_IF_ID, stall_ID_EXE,
    output logic interrupt_en,
    output logic [1:0] forwarding_A, forwarding_B,
    output logic forwarding_mem
);

    // Register for ALU forwarding control
    logic [1:0] forward_A, forward_B;
    logic forward_mem;
    logic load_use_hazard, load_store_hazard, branch_hazard;
    logic interrupt_allowed;

    // Data Hazard Detection Logic
    always @(*) begin
        // Initialize forwarding signals
        forwarding_A = 2'b00;  // Default: use rs1_EXE
        forwarding_B = 2'b00;  // Default: use rs2_EXE
        forwarding_mem = 1'b0; // Default: use write_data_EXE

        // EX Hazard - Forward from MEM stage
        // If rd_MEM is not x0 and matches rs1_EXE
        if ((rd_MEM != 5'b00000) && (rd_MEM == rs1_EXE)) begin
            forwarding_A = 2'b10; // Forward from ALU result in MEM stage
        end
        
        // If rd_MEM is not x0 and matches rs2_EXE
        if ((rd_MEM != 5'b00000) && (rd_MEM == rs2_EXE)) begin
            forwarding_B = 2'b10; // Forward from ALU result in MEM stage
        end

        // MEM Hazard - Forward from WB stage
        // If rd_WB is not x0, doesn't match rd_MEM (to avoid conflicts), and matches rs1_EXE
        if ((rd_WB != 5'b00000) && (rd_WB != rd_MEM) && (rd_WB == rs1_EXE) && reg_write_WB) begin
            forwarding_A = 2'b01; // Forward from WB stage
        end
        
        // If rd_WB is not x0, doesn't match rd_MEM (to avoid conflicts), and matches rs2_EXE
        if ((rd_WB != 5'b00000) && (rd_WB != rd_MEM) && (rd_WB == rs2_EXE) && reg_write_WB) begin
            forwarding_B = 2'b01; // Forward from WB stage
        end

        // Memory forwarding for store instructions
        // If we're writing to memory in MEM stage and the source register is being written in WB
        if ((rd_WB != 5'b00000) && (rd_WB == rs2_MEM) && reg_write_WB) begin
            forwarding_mem = 1'b1; // Forward from WB stage to MEM stage
        end
    end

    // Load-Use Hazard Detection
    always @(*) begin
        // Default: no stall
        load_use_hazard = 1'b0;
        load_store_hazard = 1'b0;
        
        // Detect load-use hazard:
        // If instruction in EXE stage is a load (result_sel_EXE == 2'b01)
        // and its destination register is used by the instruction in ID stage
        if (result_sel_EXE == 2'b01 && rd_EXE != 5'b00000) begin
            if ((rs1_ID == rd_EXE) || (rs2_ID == rd_EXE)) begin
                load_use_hazard = 1'b1;
            end
        end

        // for extreme cases, check LB before SB such that LB X2, 0(X3) followed by SB X1, 0(X2)
        if(result_sel_MEM ==2'b01 && mem_write_en_ID) begin
            if (rd_MEM == rs2_EXE) begin
                load_store_hazard = 1'b0;     
            end
        end
    end

    // Branch/Jump Hazard Detection
    always @(*) begin
        // Default: no branch hazard
        branch_hazard = 1'b0;
        
        // If branch or jump is taken (pc_next_sel == 1)
        // we need to flush the pipeline
        if (pc_next_sel == 1'b1) begin
            branch_hazard = 1'b1;
        end
    end

    // Interrupt Handling Logic
    always @(*) begin
        interrupt_allowed = 1'b0;
        
        // Only allow interrupts when there are no hazards
        if (!load_use_hazard && !branch_hazard) begin
            interrupt_allowed = 1'b1;
        end
        
        // Enable interrupt if requested and allowed
        interrupt_en = interrupt_ctrl && interrupt_allowed;
    end

    // Pipeline Control Logic
    always @(*) begin
        // Default: no stall or flush
        stall_IF = 1'b0;
        stall_IF_ID = 1'b0;
        stall_ID_EXE = 1'b0;
        
        flush_IF_ID = 1'b0;
        flush_ID_EXE = 1'b0;
        flush_EXE_MEM = 1'b0;
        
        // Handle load-use hazard
        if (load_use_hazard) begin
            stall_IF = 1'b1;     // Stall IF stage
            stall_IF_ID = 1'b1;  // Stall ID stage
            flush_ID_EXE = 1'b1; // Flush EXE stage (insert bubble)
        end

        if(load_store_hazard) begin
            stall_IF = 1'b1;     // Stall IF stage
            stall_IF_ID = 1'b1;  // Stall ID stage
            stall_ID_EXE = 1'b1; // Flush EXE stage (insert bubble)
            flush_EXE_MEM = 1'b1; // Flush MEM stage (insert bubble)
        end
        
        // Handle branch/jump hazard
        if (branch_hazard) begin
            flush_IF_ID = 1'b1;  // Flush instructions in IF and ID stages
            flush_ID_EXE = 1'b1; // Flush EXE stage for branch
        end
        
        // Handle interrupt
        if (interrupt_en) begin
            flush_IF_ID = 1'b1;  // Flush instructions in IF and ID stages
            flush_ID_EXE = 1'b1; // Flush instruction in EXE stage
        end
    end

endmodule