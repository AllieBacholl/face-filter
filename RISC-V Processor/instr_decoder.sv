module instr_decoder(
    input [6:0] opcode, 
    input [2:0] funct3,
    input [6:0] funct7,

    output logic reg_write, mem_write_en, jump, branch,
    output logic [1:0] result_sel,
    output logic pcJalSrc,
    output logic [1:0] alu_src_sel_B,
    output logic alu_src_sel_A,
    output logic [4:0] alu_op,
    output logic [2:0] imm_ctrl,
    output logic mem_read, mem_sign,// mem_sign 00-byte, 01-half-word, 10-word
    output logic [1:0] mem_length,
    output logic jalr_en,
    output err
);

// unused signals for now for later debugging
logic [16:0] alu_ctrl;
logic err_temp;

assign err = err_temp;

// RISC-V Instruction Type and Opcode Defines
`define OP_R_TYPE      7'b0110011  // R-type
`define OP_I_TYPE_ALU  7'b0010011  // I-type ALU
`define OP_I_TYPE_LOAD 7'b0000011  // I-type Load
`define OP_I_TYPE_JALR 7'b1100111  // I-type JALR
`define OP_S_TYPE      7'b0100011  // S-type
`define OP_B_TYPE      7'b1100011  // B-type
`define OP_U_TYPE_LUI  7'b0110111  // U-type LUI
`define OP_U_TYPE_AUIPC 7'b0010111 // U-type AUIPC
`define OP_J_TYPE_JAL  7'b1101111  // J-type JAL
`define OP_FENCE       7'b0001111  // Fence
`define OP_SYSTEM      7'b1110011  // System

// Function3 values for different instruction types
`define F3_ADD_SUB     3'b000
`define F3_SLL         3'b001
`define F3_SLT         3'b010
`define F3_SLTU        3'b011
`define F3_XOR         3'b100
`define F3_SRL_SRA     3'b101
`define F3_OR          3'b110
`define F3_AND         3'b111

// Function7 values
`define F7_ADD         7'b0000000
`define F7_SUB         7'b0100000
`define F7_SRL         7'b0000000
`define F7_SRA         7'b0100000

// Instruction identification macros for case statements
`define LUI            {`OP_U_TYPE_LUI, 3'bxxx, 7'bxxxxxxx}
`define AUIPC          {`OP_U_TYPE_AUIPC, 3'bxxx, 7'bxxxxxxx}
`define JAL            {`OP_J_TYPE_JAL, 3'bxxx, 7'bxxxxxxx}
`define JALR           {`OP_I_TYPE_JALR, `F3_ADD_SUB, 7'bxxxxxxx}
`define BEQ            {`OP_B_TYPE, 3'b000, 7'bxxxxxxx}
`define BNE            {`OP_B_TYPE, 3'b001, 7'bxxxxxxx}
`define BLT            {`OP_B_TYPE, 3'b100, 7'bxxxxxxx}
`define BGE            {`OP_B_TYPE, 3'b101, 7'bxxxxxxx}
`define BLTU           {`OP_B_TYPE, 3'b110, 7'bxxxxxxx}
`define BGEU           {`OP_B_TYPE, 3'b111, 7'bxxxxxxx}
`define LB             {`OP_I_TYPE_LOAD, 3'b000, 7'bxxxxxxx}
`define LH             {`OP_I_TYPE_LOAD, 3'b001, 7'bxxxxxxx}
`define LW             {`OP_I_TYPE_LOAD, 3'b010, 7'bxxxxxxx}
`define LBU            {`OP_I_TYPE_LOAD, 3'b100, 7'bxxxxxxx}
`define LHU            {`OP_I_TYPE_LOAD, 3'b101, 7'bxxxxxxx}
`define SB             {`OP_S_TYPE, 3'b000, 7'bxxxxxxx}
`define SH             {`OP_S_TYPE, 3'b001, 7'bxxxxxxx}
`define SW             {`OP_S_TYPE, 3'b010, 7'bxxxxxxx}
`define ADDI           {`OP_I_TYPE_ALU, 3'b000, 7'bxxxxxxx}
`define SLTI           {`OP_I_TYPE_ALU, 3'b010, 7'bxxxxxxx}
`define SLTIU          {`OP_I_TYPE_ALU, 3'b011, 7'bxxxxxxx}
`define XORI           {`OP_I_TYPE_ALU, 3'b100, 7'bxxxxxxx}
`define ORI            {`OP_I_TYPE_ALU, 3'b110, 7'bxxxxxxx}
`define ANDI           {`OP_I_TYPE_ALU, 3'b111, 7'bxxxxxxx}
`define SLLI           {`OP_I_TYPE_ALU, 3'b001, 7'b0000000}
`define SRLI           {`OP_I_TYPE_ALU, 3'b101, 7'b0000000}
`define SRAI           {`OP_I_TYPE_ALU, 3'b101, 7'b0100000}
`define ADD            {`OP_R_TYPE, 3'b000, 7'b0000000}
`define SUB            {`OP_R_TYPE, 3'b000, 7'b0100000}
`define SLL            {`OP_R_TYPE, 3'b001, 7'b0000000}
`define SLT            {`OP_R_TYPE, 3'b010, 7'b0000000}
`define SLTU           {`OP_R_TYPE, 3'b011, 7'b0000000}
`define XOR            {`OP_R_TYPE, 3'b100, 7'b0000000}
`define SRL            {`OP_R_TYPE, 3'b101, 7'b0000000}
`define SRA            {`OP_R_TYPE, 3'b101, 7'b0100000}
`define OR             {`OP_R_TYPE, 3'b110, 7'b0000000}
`define AND            {`OP_R_TYPE, 3'b111, 7'b0000000}
`define FENCE          {`OP_FENCE, 3'b000, 7'bxxxxxxx}
`define ECALL          {`OP_SYSTEM, 3'b000, 7'b0000000}
`define EBREAK         {`OP_SYSTEM, 3'b000, 7'b0000000}

alu_control alu_control_logic(.opcode(opcode), .funct3(funct3), .funct7(funct7), .aluOp(alu_op));


always @* begin
        // Default assignments
        err_temp = 0;
        jalr_en = 0;
        
        // Combined instruction pattern for case statement
        casex ({opcode, funct3, funct7})
            // U-Type instructions
            `LUI: begin
                // Control signals for LUI
                reg_write = 1;
                alu_src_sel_A = 1;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `LUI;
                imm_ctrl = 3'b011;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 0;
                mem_length = 0;
                mem_read = 0;
                mem_sign = 0;
            end
            
            `AUIPC: begin
                // Control signals for AUIPC
                reg_write = 1;
                alu_src_sel_A = 1;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `AUIPC;
                imm_ctrl = 3'b011;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 0;
                mem_length = 0;
                mem_read = 0;
                mem_sign = 0;
            end
            
            // J-Type instruction
            `JAL: begin
                // Control signals for JAL
                reg_write = 1;
                alu_src_sel_A = 1'bx;
                alu_src_sel_B = 2'b10;
                alu_ctrl = `JAL;
                imm_ctrl = 3'b100;
                jump = 1;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b10;
                pcJalSrc = 1;
                mem_length = 0;
                mem_read = 0;
                mem_sign = 0;
            end
            
            // I-Type Jump instruction
            `JALR: begin
                // Control signals for JALR
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `JALR;
                imm_ctrl = 3'b000;
                jump = 1;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b10;
                pcJalSrc = 1;
                mem_length = 0;
                mem_read = 0;
                mem_sign = 0;
                jalr_en = 1; // Enable JALR
            end
            
            // B-Type instructions
            `BEQ: begin
                // Control signals for BEQ
                reg_write = 0;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl = `BEQ;
                imm_ctrl = 3'b010;
                jump = 0;
                branch = 1;
                mem_write_en = 0;
                result_sel = 2'bxx;
                pcJalSrc = 0;
                mem_length = 0;
                mem_read = 0;
                mem_sign = 0;
            end
            
            `BNE: begin
                // Control signals for BNE
                reg_write = 0;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl =  `BNE;
                imm_ctrl = 3'b010;
                jump = 0;
                branch = 1;
                mem_write_en = 0;
                result_sel = 2'bxx;
                pcJalSrc = 0;
                mem_length = 0;
                mem_read = 0;
                mem_sign = 0;
            end
            
            `BLT: begin
                // Control signals for BLT
                reg_write = 0;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl = `BLT;
                imm_ctrl = 3'b010;
                jump = 0;
                branch = 1;
                mem_write_en = 0;
                result_sel = 2'bxx;
                pcJalSrc = 0;
                mem_length = 0;
                mem_read = 0;
                mem_sign = 0;
            end
            
            `BGE: begin
                // Control signals for BGE
                reg_write = 0;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl =  `BGE;
                imm_ctrl = 3'b010;
                jump = 0;
                branch = 1;
                mem_write_en = 0;
                result_sel = 2'bxx;
                pcJalSrc = 0;
                mem_length = 0;
                mem_read = 0;
                mem_sign = 0;
            end
            
            `BLTU: begin
                // Control signals for BLTU
                reg_write = 0;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl = `BLTU;
                imm_ctrl = 3'b010;
                jump = 0;
                branch = 1;
                mem_write_en = 0;
                result_sel = 2'bxx;
                pcJalSrc = 0;
                mem_length = 0;
                mem_read = 0;
                mem_sign = 0;
            end
            
            `BGEU: begin
                // Control signals for BGEU
                reg_write = 0;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl =  `BGEU;
                imm_ctrl = 3'b010;
                jump = 0;
                branch = 1;
                mem_write_en = 0;
                result_sel = 2'bxx;
                pcJalSrc = 0;
                mem_length = 0;
                mem_read = 0;
                mem_sign = 0;
            end
            
            // I-Type Load instructions
            `LB: begin
                // Control signals for LB
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `LB;
                imm_ctrl = 3'b000;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b01;
                pcJalSrc = 1'bx;
                mem_length = 2'b00;
                mem_read = 1;
                mem_sign = 1;
            end
            
            `LH: begin
                // Control signals for LH
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `LH;
                imm_ctrl = 3'b000;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b01;
                pcJalSrc = 1'bx;
                mem_length = 2'b01;
                mem_read = 1;
                mem_sign = 1;
            end
            
            `LW: begin
                // Control signals for LW
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `LW;
                imm_ctrl = 3'b000;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b01;
                pcJalSrc = 1'bx;
                mem_length = 2'b10;
                mem_read = 1;
                mem_sign = 1'bx;
            end
            
            `LBU: begin
                // Control signals for LBU
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `LBU;
                imm_ctrl = 3'b000;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b01;
                pcJalSrc = 1'bx;
                mem_length = 2'b00;
                mem_read = 1;
                mem_sign = 0;
            end
            
            `LHU: begin
                // Control signals for LHU
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `LHU;
                imm_ctrl = 3'b000;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b01;
                pcJalSrc = 1'bx;
                mem_length = 2'b01;
                mem_read = 1;
                mem_sign = 0;
            end
            
            // S-Type Store instructions
            `SB: begin
                // Control signals for SB
                reg_write = 0;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `SB;
                imm_ctrl = 3'b001;
                jump = 0;
                branch = 0;
                mem_write_en = 1;
                result_sel = 2'bxx;
                pcJalSrc = 1'bx;
                mem_length = 2'b00;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `SH: begin
                // Control signals for SH
                reg_write = 0;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `SH;
                imm_ctrl = 3'b001;
                jump = 0;
                branch = 0;
                mem_write_en = 1;
                result_sel = 2'bxx;
                pcJalSrc = 1'bx;
                mem_length = 2'b01;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `SW: begin
                // Control signals for SW
                reg_write = 0;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `SW;
                imm_ctrl = 3'b001;
                jump = 0;
                branch = 0;
                mem_write_en = 1;
                result_sel = 2'bxx;
                pcJalSrc = 1'bx;
                mem_length = 2'b10;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            // I-Type ALU instructions
            `ADDI: begin
                // Control signals for ADDI
                reg_write = 1;
                alu_src_sel_A =0 ;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `ADDI;
                imm_ctrl = 3'b000;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `SLTI: begin
                // Control signals for SLTI
                reg_write = 1;
                alu_src_sel_A =0 ;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `SLTI;
                imm_ctrl = 3'b000;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `SLTIU: begin
                // Control signals for SLTIU ????
                reg_write = 1;
                alu_src_sel_A =0 ;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `SLTIU;
                imm_ctrl = 3'b000;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `XORI: begin
                // Control signals for XORI
                reg_write = 1;
                alu_src_sel_A =0 ;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `XORI;
                imm_ctrl = 3'b000;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `ORI: begin
                // Control signals for ORI
                reg_write = 1;
                alu_src_sel_A =0 ;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `ORI;
                imm_ctrl = 3'b000;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `ANDI: begin
                // Control signals for ANDI
                reg_write = 1;
                alu_src_sel_A =0 ;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `ANDI;
                imm_ctrl = 3'b000;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `SLLI: begin
                // Control signals for SLLI
                reg_write = 1;
                alu_src_sel_A =0 ;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `SLLI;
                imm_ctrl = 3'b101;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `SRLI: begin
                // Control signals for SRLI
                reg_write = 1;
                alu_src_sel_A =0 ;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `SRLI;
                imm_ctrl = 3'b101;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `SRAI: begin
                // Control signals for SRAI
                reg_write = 1;
                alu_src_sel_A =0 ;
                alu_src_sel_B = 2'b01;
                alu_ctrl = `SRAI;
                imm_ctrl = 3'b101;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            // R-Type instructions
            `ADD: begin
                // Control signals for ADD
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl = `ADD;
                imm_ctrl = 3'bxxx;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `SUB: begin
                // Control signals for SUB
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl = `SUB;
                imm_ctrl = 3'bxxx;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `SLL: begin
                // Control signals for SLL
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl = `SLL;
                imm_ctrl = 3'bxxx;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `SLT: begin
                // Control signals for SLT
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl = `SLT;
                imm_ctrl = 3'bxxx;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `SLTU: begin
                // Control signals for SLTU
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl = `SLTU;
                imm_ctrl = 3'bxxx;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `XOR: begin
                // Control signals for XOR
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl = `XOR;
                imm_ctrl = 3'bxxx;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `SRL: begin
                // Control signals for SRL
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl = `SRL;
                imm_ctrl = 3'bxxx;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `SRA: begin
                // Control signals for SRA
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl = `SRA;
                imm_ctrl = 3'bxxx;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `OR: begin
                // Control signals for OR
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl = `OR;
                imm_ctrl = 3'bxxx;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            `AND: begin
                // Control signals for AND
                reg_write = 1;
                alu_src_sel_A = 0;
                alu_src_sel_B = 2'b00;
                alu_ctrl = `AND;
                imm_ctrl = 3'bxxx;
                jump = 0;
                branch = 0;
                mem_write_en = 0;
                result_sel = 2'b00;
                pcJalSrc = 1'bx;
                mem_length = 2'bxx;
                mem_read = 0;
                mem_sign = 1'bx;
            end
            
            // System and Fence instructions
            `FENCE: begin
                // Control signals for FENCE
                err_temp = 1; // FENCE instruction not supported
            end
            
            `ECALL: begin
                // Special handling for ECALL may require additional logic
                // since it shares opcode/funct3/funct7 with EBREAK
                err_temp = 1; // ECALL instruction not supported
            end
            
            `EBREAK: begin
                // Special handling for EBREAK may require additional logic
                // since it shares opcode/funct3/funct7 with ECALL
                err_temp = 1; // EBREAK instruction not supported
            end
            
            default: err_temp = 1; // Unknown instruction
        endcase
    end

endmodule
