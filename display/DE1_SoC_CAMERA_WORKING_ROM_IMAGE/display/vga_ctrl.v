//VGA控制模块
//author:麝月小兴兴

module vga_ctrl
#(
	parameter	H_FRONT=	12'd24		,
	parameter	H_SYNC =	12'd136		,
	parameter	H_BACK =	12'd144		,
	parameter	H_DISP =	12'd1024	,
	parameter	H_TOTAL=	12'd1328 	,

	parameter	V_FRONT=	12'd3		,
	parameter	V_SYNC =	12'd6 		,
	parameter	V_BACK =	12'd29 		,
	parameter	V_DISP =	12'd768 	,
	parameter	V_TOTAL=	12'd806		
)
(
	input	wire			clk_in			,
	input	wire			rst_n			,
	input	wire	[23:0]	data_in			,
	output	wire			rom_en			,
	output	wire			data_en			,
	output	wire	[11:0]	x_pos			,
	output	wire	[11:0]	y_pos			,
	
	output	wire			vga_hs			,
	output	wire			vga_vs			,
	output	wire			vga_de			,
	output	wire	[7:0]	vga_r			,//红色分量
	output	wire	[7:0]	vga_g			,//绿色分量
	output	wire	[7:0]	vga_b			,//蓝色分量
	
	output	wire			vga_clk			,
	output	wire			vga_sync_n		,
	output	wire			vga_blank_n		
);

//parameter define
localparam 		X_START 	=	192		;
localparam 		Y_START		=	112		;
localparam 		PIC_WIDTH 	= 	64		;
localparam 		PIC_HEIGHT 	= 	64		;

//reg or wire define
reg		[11:0]		h_cnt		;
reg		[11:0]		v_cnt		;
wire				vga_href	;

//main code
//h_cnt
always @(posedge clk_in or negedge rst_n) begin
	if(!rst_n)
		h_cnt<=12'd0;
	else if(h_cnt==H_TOTAL-1'B1)
		h_cnt<=12'd0;
	else
		h_cnt<=h_cnt+1'b1;
end 

//v_cnt
always @ (posedge clk_in or negedge rst_n) begin
	if(!rst_n)
		v_cnt<=12'd0;
	else if(h_cnt==H_TOTAL-1'B1) begin
		if(v_cnt==V_TOTAL-1'B1)
			v_cnt<=12'd0;
		else
			v_cnt<=v_cnt+1'b1;
	end
	else
		v_cnt<=v_cnt;
end 

//video timing
assign vga_hs = (h_cnt<H_SYNC) ? 1'b0 : 1'b1 ;
assign vga_vs = (v_cnt<V_SYNC) ? 1'b0 : 1'b1 ;
assign vga_href = ((h_cnt>=H_SYNC+H_BACK)&&(h_cnt<H_SYNC+H_BACK+H_DISP) 
					&& (v_cnt>=V_SYNC+V_BACK)&&(v_cnt<V_SYNC+V_BACK+V_DISP)) ? 1'b1 : 1'b0 ;
assign vga_de		=	vga_href	;

assign vga_r  =vga_de ? data_in[23:16] : 8'd0 ;
assign vga_g  =vga_de ? data_in[15:8]  : 8'd0 ;
assign vga_b  =vga_de ? data_in[7:0]   : 8'd0 ;

assign vga_clk = ~clk_in ;
assign vga_sync_n = 1'b0 ;
assign vga_blank_n  =   vga_href    ;//当它为0的时候，RGB的像素会被忽略

assign data_en=((h_cnt>=H_SYNC+H_BACK-1'b1)&&(h_cnt<H_SYNC+H_BACK+H_DISP-1'b1) 
					&& (v_cnt>=V_SYNC+V_BACK)&&(v_cnt<V_SYNC+V_BACK+V_DISP)) ? 1'b1 : 1'b0 ;//比数据有效提前一个时钟周期
assign x_pos = data_en ? (h_cnt-(H_SYNC+H_BACK-1'b1)) : 12'd0 ;
assign y_pos = data_en ? (v_cnt-(V_SYNC+V_BACK)) : 12'd0 ;

assign rom_en=((h_cnt>=H_SYNC+H_BACK+X_START-2'd3)&&(h_cnt<H_SYNC+H_BACK+X_START+PIC_WIDTH-2'd3) 
					&& (v_cnt>=V_SYNC+V_BACK+Y_START)&&(v_cnt<V_SYNC+V_BACK+Y_START+PIC_HEIGHT)) ? 1'b1 : 1'b0 ;//比数据有效提前一个时钟周期				

endmodule
