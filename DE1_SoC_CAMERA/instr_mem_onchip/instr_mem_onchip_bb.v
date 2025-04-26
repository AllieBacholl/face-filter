
module instr_mem_onchip (
	clk_clk,
	mem_address,
	mem_clken,
	mem_chipselect,
	mem_write,
	mem_readdata,
	mem_writedata,
	mem_byteenable,
	reset_reset_n);	

	input		clk_clk;
	input	[9:0]	mem_address;
	input		mem_clken;
	input		mem_chipselect;
	input		mem_write;
	output	[31:0]	mem_readdata;
	input	[31:0]	mem_writedata;
	input	[3:0]	mem_byteenable;
	input		reset_reset_n;
endmodule
