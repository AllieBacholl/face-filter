
module regFile (
	clk_clk,
	reset_reset_n,
	mem_address,
	mem_clken,
	mem_chipselect,
	mem_write,
	mem_readdata,
	mem_writedata,
	mem_byteenable);	

	input		clk_clk;
	input		reset_reset_n;
	input	[4:0]	mem_address;
	input		mem_clken;
	input		mem_chipselect;
	input		mem_write;
	output	[31:0]	mem_readdata;
	input	[31:0]	mem_writedata;
	input	[3:0]	mem_byteenable;
endmodule
