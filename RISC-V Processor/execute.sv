module execute (
    input rst,
    input EXT,
    // control signals input
    input [31:0] pcPlus4_in, pc_in,
    input [31:0] instr_in,
    input jump_EXE, branch_EXE,
    input [1:0] alu_src_sel_B_EXE,
    input [2:0] imm_ctrl_EXE,
    input [4:0] aluOp,


    // data signals input
    input [4:0] rs1_EXE, rs2_EXE, rd_EXE,
    input [31:0] rs1_data_EXE, rs2_data_EXE, // rs2_data = write_data_MEM
    input [31:0] imm_res_EXE,

    // Forwarding
    input [1:0] forwarding_a, forwarding_b,
    input [31:0] rs1_data_MEM,
    input [31:0] rs2_data_MEM,
    input [31:0] rs1_data_WB,
    input [31:0] rs2_data_WB,

    // control signals outputs
    output EXT_out,
    output pc_next_sel,

    // data signals outputs
    output [31:0]  branch_jump_addr,
    output [31:0]  alu_result_EXE ,   // Result of computation
    output [31:0] write_data_EXE
);


wire [31:0]  InA;               // Input operand A
wire [31:0]  InB;               // Input operand B
wire [31:0]  InB_forwarding;

wire         sf;                // Signal if Out is negative or positive
wire         zf;                // Signal if Out is 0

// ALU
assign InA = (forwarding_a == 2'b00) ? rs1_data_EXE : 
             (forwarding_a == 2'b01) ? rs1_data_WB : rs1_data_MEM;

assign InB_forwarding = (forwarding_b == 2'b00) ? rs2_data_EXE : 
                        (forwarding_b == 2'b01) ? rs2_data_WB : rs2_data_MEM;

assign InB = (alu_src_sel_B_EXE == 2'b00) ? InB_forwarding : 
             (alu_src_sel_B_EXE == 2'b01) ? imm_res_EXE : branch_jump_addr;

// alu_control ialu_control(.opcode(instr_in[6:0]), .funct3(instr_in[14:12]), .funct7(instr_in[31]), .aluOp(aluOp));
alu alu(.InA(InA), .InB(InB), .Oper(aluOp), .Out(alu_result_EXE), .zf(zf), .sf(sf));

// Branch control
assign branch_jump_addr = imm_res_EXE + pcPlus4_in;

assign write_data_EXE = InB_forwarding;

wire beq = (zf & instr_in[14:12] == 3'b000);
wire bne = (~zf & instr_in[14:12] == 3'b001);
wire blt = (sf & instr_in[14:12] == 3'b100);
wire bge = ((~sf | zf) & instr_in[14:12] == 3'b101);
wire bltu = (($unsigned(rs1_EXE) < $unsigned(rs2_EXE)) & instr_in[14:12] == 3'b110);
wire bgeu = (($unsigned(rs1_EXE) >= $unsigned(rs2_EXE)) & instr_in[14:12] == 3'b111);

assign pc_next_sel = ((beq | bne | blt | bge | bltu | bgeu) & branch_EXE) | jump_EXE;



endmodule
