/*** 
 * Author: Stephen Dai
 * Date: 2023-08-22 20:36:05
 * LastEditors: Stephen Dai
 * LastEditTime: 2025-04-03 20:23:23
 * FilePath: \RISCV_vivado_20250403.srcs\sim_1\imports\tb\riscv_soc_tb.v
 * Description: testbench
 * 
 */
`define IRAM_DW    32  
`define IRAM_DEPTH 2048
`define DRAM_DW    32  
`define DRAM_DEPTH 2048 << 4

`ifndef INSTR_FILE
    `define INSTR_FILE "/filespace/h/hlyu42/ECE554/face-filter/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sim_1/imports/tb/compiled_c.hex"
`endif

`ifndef DATA_FILE
    `define DATA_FILE "/filespace/h/hlyu42/ECE554/face-filter/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sim_1/imports/tb/data_mem.hex"
`endif

`define Regs riscv_soc_tb.u_riscv_soc.u_riscv_core.u_regs.regs
`define Dram riscv_soc_tb.u_riscv_soc.u_dram.u_dual_ram.mem
`define Iram riscv_soc_tb.u_riscv_soc.u_iram.mem

module riscv_soc_tb;

	reg clk;
	reg rst_n;

	wire x3  = `Regs[3] ; 
	wire x26 = `Regs[26];
	wire x27 = `Regs[27];

	function string DecodeInst (input logic [31:0] Instruction, output string Assembly);
		logic [6:0] OpCode;
		logic [2:0] Func3;
		logic [6:0] Func7;
		logic [31:0] Immediate;
		logic [5:0] Rs1;
		logic [5:0] Rs2;
		logic [5:0] Rd;
		logic [12:0] CSR;

		string Assembly1;
		string Assembly2;
		string Assembly3;
		string Assembly4;

		OpCode = Instruction[6:0];
		Func3 = Instruction[14:12];
		Func7 = Instruction[31:25];
		Rs1 = Instruction[19:15];
		Rs2 = Instruction[24:20];
		Rd = Instruction[11:7];
		CSR = Instruction[31:20];

		case(Instruction[6:0])
			7'b1110011 : Immediate = {Instruction[31] ? 21'h1FFFFF : 21'b0, Instruction[30:20]}; // I-Immediateediate
			7'b0000011 : Immediate = {Instruction[31] ? 21'h1FFFFF : 21'b0, Instruction[30:20]}; // I-Immediateediate
			7'b0010011 : Immediate = ((Instruction[31:25] == 7'b0100000) && (Instruction[14:12] == 3'b101)) ? {27'b0, Instruction[24:20]} : // I-Immediateediate SRAI
						{Instruction[31] ? 21'h1FFFFF : 21'b0, Instruction[30:20]}; // I-Immediateediate
			7'b1100111 : Immediate = {Instruction[31] ? 21'h1FFFFF : 21'b0, Instruction[30:20]}; // I-Immediateediate
			7'b0000001 : Immediate = {Instruction[31] ? 21'h1FFFFF : 21'b0, Instruction[30:20]}; // I-Immediateediate
			7'b1101111 : Immediate = {Instruction[31] ? 11'h7FF : 11'b0, Instruction[31], Instruction[19:12], Instruction[20], Instruction[30:21], 1'b0}; // J-Immediateediate
			7'b1100011 : Immediate = {Instruction[31] ? 20'hFFFFF : 20'b0, Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}; // B-Immediateediate
			7'b0110111 : Immediate = {Instruction[31:12], 12'b0}; // U-Immediateediate LUI
			7'b0010111 : Immediate = {Instruction[31:12], 12'b0}; // U-Immediateediate AUIPC
			7'b0100011 : Immediate = {Instruction[31] ? 21'h1FFFFF : 21'b0, Instruction[30:25], Instruction[11:8], Instruction[7]}; // S-Immediateediate
			default : Immediate = 32'b0;
		endcase


		case(OpCode)
			7'b1110011: begin
				case(Func3)
					3'b010: begin
						Assembly1 = "csrr ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(CSR);
						Assembly3 = {"csr", Assembly3};
						Assembly4 = "";
					end

					3'b001: begin
						Assembly1 = "csrw ";
						Assembly2.itoa(CSR);
						Assembly2 = {"csr", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3};
						Assembly4 = "";
					end
				endcase
			end

			7'b0110011: begin
				case(Func3)
					3'b000: begin
						case(Func7)
							7'b0000000: begin
								Assembly1 = "add ";
								Assembly2.itoa(Rd);
								Assembly2 = {"x", Assembly2, ", "};
								Assembly3.itoa(Rs1);
								Assembly3 = {"x", Assembly3, ", "};
								Assembly4.itoa(Rs2);
								Assembly4 = {"x", Assembly4};
							end

							7'b0100000: begin
								Assembly1 = "sub ";
								Assembly2.itoa(Rd);
								Assembly2 = {"x", Assembly2, ", "};
								Assembly3.itoa(Rs1);
								Assembly3 = {"x", Assembly3, ", "};
								Assembly4.itoa(Rs2);
								Assembly4 = {"x", Assembly4};
							end

							7'b0100001: begin
								Assembly1 = "mul ";
								Assembly2.itoa(Rd);
								Assembly2 = {"x", Assembly2, ", "};
								Assembly3.itoa(Rs1);
								Assembly3 = {"x", Assembly3, ", "};
								Assembly4.itoa(Rs2);
								Assembly4 = {"x", Assembly4};
							end
						endcase
					end

					3'b111: begin
						Assembly1 = "and ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa(Rs2);
						Assembly4 = {"x", Assembly4};
					end

					3'b110: begin
						Assembly1 = "or ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa(Rs2);
						Assembly4 = {"x", Assembly4};
					end

					3'b100: begin
						Assembly1 = "xor ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa(Rs2);
						Assembly4 = {"x", Assembly4};
					end

					3'b010: begin
						Assembly1 = "slt ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa(Rs2);
						Assembly4 = {"x", Assembly4};
					end

					3'b011: begin
						Assembly1 = "sltu ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa(Rs2);
						Assembly4 = {"x", Assembly4};
					end

					3'b101: begin
						case(Func7)
							7'b0100000: begin
								Assembly1 = "sra ";
								Assembly2.itoa(Rd);
								Assembly2 = {"x", Assembly2, ", "};
								Assembly3.itoa(Rs1);
								Assembly3 = {"x", Assembly3, ", "};
								Assembly4.itoa(Rs2);
								Assembly4 = {"x", Assembly4};
							end

							7'b0000000: begin
								Assembly1 = "srl ";
								Assembly2.itoa(Rd);
								Assembly2 = {"x", Assembly2, ", "};
								Assembly3.itoa(Rs1);
								Assembly3 = {"x", Assembly3, ", "};
								Assembly4.itoa(Rs2);
								Assembly4 = {"x", Assembly4};
							end
						endcase
					end

					3'b001: begin

						Assembly1 = "sll ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa(Rs2);
						Assembly4 = {"x", Assembly4};
					end
				endcase
			end

			7'b0010011: begin
				case(Func3)
					3'b000: begin
						// if(Rs1 == 0) begin
						// 	Assembly1 = "li ";
						// 	Assembly2.itoa(Rd);
						// 	Assembly2 = {"x", Assembly2, ", "};
						// 	Assembly3.itoa($signed(Immediate));
						// 	Assembly4 = "";
						// end else 
						if (Immediate == 0) begin
							Assembly1 = "mv ";
							Assembly2.itoa(Rd);
							Assembly2 = {"x", Assembly2, ", "};
							Assembly3.itoa(Rs1);
							Assembly4 = "";
						end else begin
							Assembly1 = "addi ";
							Assembly2.itoa(Rd);
							Assembly2 = {"x", Assembly2, ", "};
							Assembly3.itoa(Rs1);
							Assembly3 = {"x", Assembly3, ", "};
							Assembly4.itoa($signed(Immediate));
						end
					end

					3'b111: begin
						Assembly1 = "andi ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa($signed(Immediate));
					end

					3'b110: begin
						Assembly1 = "ori ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa($signed(Immediate));
					end

					3'b100: begin
						Assembly1 = "xori ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa($signed(Immediate));
					end

					3'b010: begin
						Assembly1 = "slti ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa($signed(Immediate));
					end

					3'b011: begin
						Assembly1 = "sltiu ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa($signed(Immediate));
					end

					3'b101: begin
						case(Func7)
							7'b0100000: begin
								Assembly1 = "srai ";
								Assembly2.itoa(Rd);
								Assembly2 = {"x", Assembly2, ", "};
								Assembly3.itoa(Rs1);
								Assembly3 = {"x", Assembly3, ", "};
								Assembly4.itoa($signed(Instruction[24:20]));
							end

							7'b0000000: begin
								Assembly1 = "srli ";
								Assembly2.itoa(Rd);
								Assembly2 = {"x", Assembly2, ", "};
								Assembly3.itoa(Rs1);
								Assembly3 = {"x", Assembly3, ", "};
								Assembly4.itoa($signed(Instruction[24:20]));
							end
						endcase
					end

					3'b001: begin
						Assembly1 = "slli ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", "};
						Assembly3.itoa(Rs1);
						Assembly3 = {"x", Assembly3, ", "};
						Assembly4.itoa($signed(Instruction[24:20]));
					end

				endcase
			end

			7'b0110111: begin
				Assembly1 = "lui ";
				Assembly2.itoa(Rd);
				Assembly2 = {"x", Assembly2, ", "};
				Assembly3.itoa($signed(Instruction[31:12]));
				Assembly3 = {Assembly3, ", "};
				Assembly4 = {""};
			end

			7'b0010111: begin
				Assembly1 = "auipc ";
				Assembly2.itoa(Rd);
				Assembly2 = {"x", Assembly2, ", "};
				Assembly3.itoa($signed(Instruction[31:12]));
				Assembly3 = {Assembly3, ", "};
				Assembly4 = {""};
			end

			7'b0000011: begin
				Assembly1 = "lw ";
				Assembly2.itoa(Rd);
				Assembly2 = {"x", Assembly2, ", "};
				Assembly3.itoa(Rs1);
				Assembly4.itoa($signed(Instruction[31:20]));
				Assembly3 = {Assembly4, "(x", Assembly3, ")"};
				Assembly4 = {""};
			end

			7'b0100011: begin
				Assembly1 = "sw ";
				Assembly2.itoa(Rs2);
				Assembly2 = {"x", Assembly2, ", "};
				Assembly3.itoa(Rs1);
				Assembly4.itoa($signed({Instruction[31:25], Instruction[11:7]}));
				Assembly3 = {Assembly4, "(x", Assembly3, ")"};
				Assembly4 = {""};
			end

			7'b1101111: begin
				Assembly1 = "jal ";
				Assembly2.itoa(Rd);
				Assembly2 = {"x", Assembly2, ", "};
				Assembly3.itoa($signed(Immediate));
				Assembly3 = {Assembly3, ", "};
				Assembly4 = {""};
			end

			7'b1100111: begin
				case(Rd)
					5'b00000: begin
						Assembly1 = "jr x";
						Assembly2.itoa(Rs1);
						Assembly3 = {""};
						Assembly4 = {""};
					end

					default: begin
						Assembly1 = "jalr ";
						Assembly2.itoa(Rd);
						Assembly2 = {"x", Assembly2, ", x"};
						Assembly3.itoa(Rs1);
						Assembly3 = {Assembly3, ", "};
						Assembly4.itoa($signed(Immediate));
						Assembly4 = {Assembly4, ""};
					end
				endcase
			end

			7'b1100011: begin
				case(Func3)
					3'b000: begin
						Assembly1 = "beq ";
						Assembly2.itoa(Rs1);
						Assembly2 = {"x", Assembly2, ", x"};
						Assembly3.itoa(Rs2);
						Assembly3 = {Assembly3, ", "};
						Assembly4.itoa($signed({Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}));
						Assembly4 = {Assembly4, ""};
					end

					3'b001: begin
						Assembly1 = "bne ";
						Assembly2.itoa(Rs1);
						Assembly2 = {"x", Assembly2, ", x"};
						Assembly3.itoa(Rs2);
						Assembly3 = {Assembly3, ", "};
						Assembly4.itoa($signed({Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}));
						Assembly4 = {Assembly4, ""};
					end

					3'b100: begin
						Assembly1 = "blt ";
						Assembly2.itoa(Rs1);
						Assembly2 = {"x", Assembly2, ", x"};
						Assembly3.itoa(Rs2);
						Assembly3 = {Assembly3, ", "};
						Assembly4.itoa($signed({Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}));
						Assembly4 = {Assembly4,""};
					end

					3'b101: begin
						Assembly1 = "bge ";
						Assembly2.itoa(Rs1);
						Assembly2 = {"x", Assembly2, ", x"};
						Assembly3.itoa(Rs2);
						Assembly3 = {Assembly3, ", "};
						Assembly4.itoa($signed({Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}));
						Assembly4 = {Assembly4, ""};
					end

					3'b110: begin
						Assembly1 = "bltu ";
						Assembly2.itoa(Rs1);
						Assembly2 = {"x", Assembly2, ", x"};
						Assembly3.itoa(Rs2);
						Assembly3 = {Assembly3, ", "};
						Assembly4.itoa($signed({Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}));
						Assembly4 = {Assembly4, ""};
					end

					3'b111: begin
						Assembly1 = "bgeu ";
						Assembly2.itoa(Rs1);
						Assembly2 = {"x", Assembly2, ", x"};
						Assembly3.itoa(Rs2);
						Assembly3 = {Assembly3, ", "};
						Assembly4.itoa($signed({Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}));
						Assembly4 = {Assembly4, ""};
					end
				endcase
			end

			default: begin
				Assembly1 = "nop ";
				Assembly2 = "";
				Assembly3 = "";
				Assembly4 = "";
			end

		endcase

		Assembly = {Assembly1, Assembly2, Assembly3, Assembly4};
	endfunction
	
	initial begin
		clk <= 1'b0 ;
		rst_n <= 1'b0;
		#30;
		rst_n <= 1'b1;	
	end
	always #1 clk = ~clk;

	integer m;
	integer r;
	integer n;
	// initial begin
	// 	#8000000 
	// 	$display("timed out");
	// 	m = $fopen("data_dump.txt", "w");
	// 	for(n=0;n<`DRAM_DEPTH;n=n+1)begin
	// 		$fdisplay(m, "%h %h", n << 2, `Dram[n][31:0]);
	// 	end
	// 	$finish;
	// end
	
	initial begin
		wait(x26 == 32'b1);
		
		#40;
		if(x27 == 32'b1) begin
			$display("############################");
			$display("########  pass  !!!#########");
			$display("############################");
		end
		else begin
			$display("############################");
			$display("########  fail  !!!#########");
			$display("############################");
			$display("fail testnum = %2d", x3);
			for(r = 0;r < 31; r = r + 1)begin
				$display("x%2d register value is %d",r,`Regs[r]);	
			end	
		end
		m = $fopen("data_dump.txt", "w");
		for(n=0;n<`DRAM_DEPTH;n=n+1)begin
			$fdisplay(m, "%h %h", n << 2, `Dram[n][31:0]);
		end
		$finish;
	end
	
	riscv_soc #(
		.IRAM_DW    (`IRAM_DW   ),
		.IRAM_DEPTH (`IRAM_DEPTH),
		.DRAM_DW    (`DRAM_DW   ),
		.DRAM_DEPTH (`DRAM_DEPTH)   
	)u_riscv_soc (
		.clk   (clk   ),
		.rst_n (rst_n )
	);

//initialize regs
integer i;
initial begin
    for(i=0;i<32;i=i+1)begin
        `Regs[i][31:0] <= 32'b0;
    end
end

//initialize dram
integer j;
initial begin 
	for(j=0;j<`DRAM_DEPTH;j=j+1)begin
        `Dram[j][31:0] = 32'b0;
    end
	#5
	$readmemh(`DATA_FILE, `Dram);
end	

always @(posedge clk) begin
	if (riscv_soc_tb.u_riscv_soc.u_dram.u_dual_ram.wen) begin
		$display("data written to %32h is %h", {riscv_soc_tb.u_riscv_soc.u_dram.u_dual_ram.w_addr_i, 2'b00}, riscv_soc_tb.u_riscv_soc.u_dram.u_dual_ram.w_data_i);
	end
end

//initialize iram
initial begin
    $display("Loading test file: %s", `INSTR_FILE);
    $readmemh(`INSTR_FILE, `Iram);
end
integer k;
string IF;
// always @(riscv_soc_tb.u_riscv_soc.u_iram.r_addr_i) begin
// 	$display("--------------------------------------------------");
// 	$display("PC = %h", riscv_soc_tb.u_riscv_soc.u_iram.r_addr_i);
// 	DecodeInst(riscv_soc_tb.u_riscv_soc.u_iram.r_data_o, IF);
// 	$display(IF);
// 	$display("%h", riscv_soc_tb.u_riscv_soc.u_iram.r_data_o);
// 	$display("--------------------------------------------------");
// end

endmodule


