
//=======================================================
//  Description:在DE2-115开发板上实现图片显示
//	author:麝月小兴兴
//=======================================================
`include "vga_param.v"

module vga_pic(

	//////////// CLOCK //////////
	input 		          		CLOCK_50,
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	
	input						RESET_KEY,

	//////////// VGA //////////
	output		     [7:0]		VGA_B,
	output		          		VGA_BLANK_N,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
wire		rst_n	;
wire		clk_75m	;
wire		clk_25m	;
wire		locked	;

wire			rom_en		;
wire			data_en		;
wire	[23:0]	data_temp	;
wire	[11:0]	x_pos		;
wire	[11:0]	y_pos		;


//=======================================================
//  main code
//=======================================================
assign rst_n = RESET_KEY & locked ;

//生成不同频率的时钟
clk_gen	clk_gen_inst (
	.rst ( ~RESET_KEY ),
	.refclk ( CLOCK_50 ),
	.outclk_1 ( clk_75m ),
	.outclk_0 ( clk_25m ),
	.locked ( locked )
	);

vga_ctrl
#(
	. H_FRONT (`H_FRONT)	,
	. H_SYNC  (`H_SYNC )	,
	. H_BACK  (`H_BACK )	,
	. H_DISP  (`H_DISP )	,
	. H_TOTAL (`H_TOTAL) 	,
	. V_FRONT (`V_FRONT)	,
	. V_SYNC  (`V_SYNC )	,
	. V_BACK  (`V_BACK )	,
	. V_DISP  (`V_DISP )	,
	. V_TOTAL (`V_TOTAL)	
)vga_ctrl_inst
(
	. clk_in		(clk_25m	)	,//clk_75m	)	,
	. rst_n			(rst_n		)	,
	. data_in		(data_temp	)	,
	. rom_en		(rom_en		)	,
	. data_en		(data_en    )	,
	. x_pos			(x_pos		)	,
	. y_pos			(y_pos		)	,

	. vga_hs		(VGA_HS		)	,
	. vga_vs		(VGA_VS		)	,
	. vga_de		()	,
	. vga_r			(VGA_R		)	,//红色分量
	. vga_g			(VGA_G		)	,//绿色分量
	. vga_b			(VGA_B		)	,//蓝色分量

	. vga_clk		(VGA_CLK	)	,
	. vga_sync_n	(VGA_SYNC_N	)	,
	. vga_blank_n	(VGA_BLANK_N)	
);

//生成图片像素
vga_disp
#(
	. H_DISP	(`H_DISP )	,
	. V_DISP  	(`V_DISP )	,
	. RED		(`RED	 )	,		
	. GREEN		(`GREEN	 )	,
	. BLUE		(`BLUE	 )	,
	. YELLOW	(`YELLOW )	,
	. PURPLE	(`PURPLE )	,
	. CYAN		(`CYAN	 )	,
	. WHITE		(`WHITE	 )	,
	. BLACK		(`BLACK	 )		
)vga_disp_inst
(
	. clk_in	(clk_25m)	,//clk_75m	)	,
	. rst_n		(rst_n	)	,
	. rom_en	(rom_en )	,
	. data_en	(data_en)	,
	. x_pos		(x_pos	)	,
	. y_pos		(y_pos	)	,

	. data_out	(data_temp)	 
);

endmodule
