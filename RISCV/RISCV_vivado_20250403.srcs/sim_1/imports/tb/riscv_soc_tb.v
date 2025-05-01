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
`define DRAM_DEPTH 2048

`ifndef INSTR_FILE
    `define INSTR_FILE "rv32ui-p-add.txt"
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
	
	initial begin
		clk <= 1'b0 ;
		rst_n <= 1'b0;
		#30;
		rst_n <= 1'b1;	
	end
	always #10 clk = ~clk;
	
	integer r;
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
        `Dram[j][31:0] <= 32'b0;
    end
end	

//initialize iram
initial begin
    $display("Loading test file: %s", `INSTR_FILE);
    $readmemh(`INSTR_FILE, `Iram);
end

endmodule


