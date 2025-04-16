	instr_mem_onchip u0 (
		.clk_clk        (<connected-to-clk_clk>),        //   clk.clk
		.mem_address    (<connected-to-mem_address>),    //   mem.address
		.mem_clken      (<connected-to-mem_clken>),      //      .clken
		.mem_chipselect (<connected-to-mem_chipselect>), //      .chipselect
		.mem_write      (<connected-to-mem_write>),      //      .write
		.mem_readdata   (<connected-to-mem_readdata>),   //      .readdata
		.mem_writedata  (<connected-to-mem_writedata>),  //      .writedata
		.mem_byteenable (<connected-to-mem_byteenable>), //      .byteenable
		.reset_reset_n  (<connected-to-reset_reset_n>)   // reset.reset_n
	);

