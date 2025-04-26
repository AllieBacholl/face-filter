//VGA显示界面控制
module vga_disp
#(
	parameter	H_DISP	=	12'd1024			,
	parameter	V_DISP =	12'd768 			,
	parameter	RED		=	24'HFF_00_00		,		
	parameter	GREEN	=	24'H00_FF_00		,
	parameter	BLUE	=	24'H00_00_FF		,
	parameter	YELLOW	=	24'HFF_FF_00		,
	parameter	PURPLE	=	24'HFF_00_FF		,
	parameter	CYAN	=	24'H00_FF_FF		,
	parameter	WHITE	=	24'HFF_FF_FF		,
	parameter	BLACK	=	24'H00_00_00
)
(
	input	wire			clk_in			,
	input	wire			rst_n			,
	input	wire			rom_en			,
	input	wire			data_en			,
	input	wire	[11:0]	x_pos			,
	input	wire	[11:0]	y_pos			,
	
	output	reg 	[23:0]	data_out		 
);

//parameter define
localparam 	ROM_ADDR_MAX = 65536 ;//0~65535

//reg or wire define
reg 	[15:0]    	rom_addr		;
wire	[7:0]		rom_data		;
reg		[1:0]		rom_en_r		;

//main code
//rom_en_r
always @(posedge clk_in) begin
	rom_en_r[1]<=rom_en_r[0];
	rom_en_r[0]<=rom_en;
end

//rom_addr
always @(posedge clk_in or negedge rst_n) begin
	if(!rst_n)
		rom_addr<=16'd0;
	else if(rom_en) begin
		if(rom_addr==ROM_ADDR_MAX - 1'B1)
			rom_addr<=16'd0;
		else
			rom_addr<=rom_addr+1'B1;
	end 
	else
		rom_addr<=rom_addr;
end 

//data_out
always @(posedge clk_in or negedge rst_n) begin
	if(!rst_n)
		data_out<=23'd0;
	else if(rom_en_r[1])
		data_out<={rom_data[7:5],5'b00000,rom_data[4:2],5'b00000,rom_data[1:0],6'b000000};//[3 3 2]
	else if(x_pos< (H_DISP>>2'D3)) //显示红色
		data_out<=RED;
	else if((x_pos>= (H_DISP>>2'D3)*1) && (x_pos<= (H_DISP>>2'D3)*2)) //显示绿色
		data_out<=GREEN;
	else if((x_pos>= (H_DISP>>2'D3)*2) && (x_pos<= (H_DISP>>2'D3)*3)) //显示蓝色
		data_out<=BLUE;
	else if((x_pos>= (H_DISP>>2'D3)*3) && (x_pos<= (H_DISP>>2'D3)*4)) //显示黄色
		data_out<=YELLOW;
	else if((x_pos>= (H_DISP>>2'D3)*4) && (x_pos<= (H_DISP>>2'D3)*5)) //显示紫色
		data_out<=PURPLE;
	else if((x_pos>= (H_DISP>>2'D3)*5) && (x_pos<= (H_DISP>>2'D3)*6)) //显示青色
		data_out<=CYAN;
	else if((x_pos>= (H_DISP>>2'D3)*6) && (x_pos<= (H_DISP>>2'D3)*7)) //显示黑色
		data_out<=BLACK;
	else if((x_pos>= (H_DISP>>2'D3)*7) && (x_pos<= H_DISP)) //显示白色
		data_out<=WHITE; 
end

//Instantiation
image_rom	image_rom_inst 
(
	.address 	( rom_addr 		)	,
	.clock 		( clk_in 		)	,
	.q 			( rom_data 		)	 //相对地址延时两个时钟周期
);


endmodule