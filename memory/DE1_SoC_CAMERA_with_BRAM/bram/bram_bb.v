
module bram (
	clk_clk,
	reset_reset_n,
	mem_data_2_address,
	mem_data_2_clken,
	mem_data_2_chipselect,
	mem_data_2_write,
	mem_data_2_readdata,
	mem_data_2_writedata,
	mem_data_2_byteenable,
	mem_data_3_address,
	mem_data_3_chipselect,
	mem_data_3_clken,
	mem_data_3_write,
	mem_data_3_readdata,
	mem_data_3_writedata,
	mem_data_3_byteenable,
	mem_data_1_address,
	mem_data_1_chipselect,
	mem_data_1_clken,
	mem_data_1_write,
	mem_data_1_readdata,
	mem_data_1_writedata,
	mem_data_1_byteenable,
	mem_data_0_address,
	mem_data_0_clken,
	mem_data_0_chipselect,
	mem_data_0_write,
	mem_data_0_readdata,
	mem_data_0_writedata,
	mem_data_0_byteenable);	

	input		clk_clk;
	input		reset_reset_n;
	input	[9:0]	mem_data_2_address;
	input		mem_data_2_clken;
	input		mem_data_2_chipselect;
	input		mem_data_2_write;
	output	[63:0]	mem_data_2_readdata;
	input	[63:0]	mem_data_2_writedata;
	input	[7:0]	mem_data_2_byteenable;
	input	[9:0]	mem_data_3_address;
	input		mem_data_3_chipselect;
	input		mem_data_3_clken;
	input		mem_data_3_write;
	output	[63:0]	mem_data_3_readdata;
	input	[63:0]	mem_data_3_writedata;
	input	[7:0]	mem_data_3_byteenable;
	input	[9:0]	mem_data_1_address;
	input		mem_data_1_chipselect;
	input		mem_data_1_clken;
	input		mem_data_1_write;
	output	[63:0]	mem_data_1_readdata;
	input	[63:0]	mem_data_1_writedata;
	input	[7:0]	mem_data_1_byteenable;
	input	[9:0]	mem_data_0_address;
	input		mem_data_0_clken;
	input		mem_data_0_chipselect;
	input		mem_data_0_write;
	output	[63:0]	mem_data_0_readdata;
	input	[63:0]	mem_data_0_writedata;
	input	[7:0]	mem_data_0_byteenable;
endmodule
