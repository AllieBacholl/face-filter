module immediate_execution(
    input [31:0] instruction,         // Complete 32-bit instruction
    input [2:0] imm_ctrl_ID,          // Control signal for immediate type
    output logic [31:0] imm_res_ID    // Generated immediate value
);

    // imm_ctrl_ID encoding based on instruction types:
    // 3'b000: I-type immediate (imm[11:0])
    // 3'b001: S-type immediate (imm[11:5], imm[4:0])
    // 3'b010: B-type immediate (imm[12], imm[10:5], imm[4:1], imm[11])
    // 3'b011: U-type immediate (imm[31:12])
    // 3'b100: J-type immediate (imm[20], imm[10:1], imm[11], imm[19:12])
    // 3'b101: SHAMT immediate (for shift operations)
    // 3'b110: Zero immediate
    // 3'b111: Reserved
    
    always_comb begin
        case(imm_ctrl_ID)
            // I-type immediate
            3'b000: begin
                // From diagram: imm[11:0] is in instruction[31:20]
                imm_res_ID = {{20{instruction[31]}}, instruction[31:20]};
            end
            
            // S-type immediate
            3'b001: begin
                // From diagram: imm[11:5] is in instruction[31:25], imm[4:0] is in instruction[11:7]
                imm_res_ID = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end
            
            // B-type immediate
            3'b010: begin
                // From diagram: imm[12,10:5] is in instruction[31:25], imm[4:1,11] is in instruction[11:7]
                // Need to reorder: imm[12|10:5|4:1|11|0] where imm[0] is always 0
                imm_res_ID = {{19{instruction[31]}}, instruction[31], instruction[7], 
                             instruction[30:25], instruction[11:8], 1'b0};
            end
            
            // U-type immediate
            3'b011: begin
                // From diagram: imm[31:12] is in instruction[31:12]
                imm_res_ID = {instruction[31:12], 12'b0};
            end
            
            // J-type immediate
            3'b100: begin
                // From diagram: imm[20|10:1|11|19:12] is derived from instruction fields
                // Need to reorder: imm[20|10:1|11|19:12|0] where imm[0] is always 0
                imm_res_ID = {{11{instruction[31]}}, instruction[31], instruction[19:12], 
                             instruction[20], instruction[30:21], 1'b0};
            end
            
            // SHAMT immediate (for shift operations)
            3'b101: begin
                // From diagram: for shift operations, use 5-bit unsigned immediate
                // Located in rs2 field: instruction[24:20]
                imm_res_ID = {27'b0, instruction[24:20]};
            end
            
            // Zero immediate
            3'b110: begin
                imm_res_ID = 32'b0;
            end
            
            // Default case
            default: begin
                imm_res_ID = 32'b0;
            end
        endcase
    end

endmodule