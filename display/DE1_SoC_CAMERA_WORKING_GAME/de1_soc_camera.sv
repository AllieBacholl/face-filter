// ============================================================================
// Copyright (c) 2013 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//  
//  
//                     web: http://www.terasic.com/  
//                     email: support@terasic.com
//
// ============================================================================
//Date:  Thu Jul 11 11:26:45 2013
// ============================================================================

//`define ENABLE_HPS
//`define ENABLE_USB
`default_nettype none
module DE1_SoC_CAMERA(

      ///////// ADC /////////
      inout              ADC_CS_N,
      output             ADC_DIN,
      input              ADC_DOUT,
      output             ADC_SCLK,

      ///////// AUD /////////
      input              AUD_ADCDAT,
      inout              AUD_ADCLRCK,
      inout              AUD_BCLK,
      output             AUD_DACDAT,
      inout              AUD_DACLRCK,
      output             AUD_XCK,

      ///////// CLOCK2 /////////
      input              CLOCK2_50,

      ///////// CLOCK3 /////////
      input              CLOCK3_50,

      ///////// CLOCK4 /////////
      input              CLOCK4_50,

      ///////// CLOCK /////////
      input              CLOCK_50,

      ///////// DRAM /////////
      output      [12:0] DRAM_ADDR,
      output      [1:0]  DRAM_BA,
      output             DRAM_CAS_N,
      output             DRAM_CKE,
      output             DRAM_CLK,
      output             DRAM_CS_N,
      inout       [15:0] DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_RAS_N,
      output             DRAM_UDQM,
      output             DRAM_WE_N,

      ///////// FAN /////////
      output             FAN_CTRL,

      ///////// FPGA /////////
      output             FPGA_I2C_SCLK,
      inout              FPGA_I2C_SDAT,

      ///////// GPIO /////////
      inout     [35:0]   GPIO_0,
	
      ///////// HEX0 /////////
      output      [6:0]  HEX0,

      ///////// HEX1 /////////
      output      [6:0]  HEX1,

      ///////// HEX2 /////////
      output      [6:0]  HEX2,

      ///////// HEX3 /////////
      output      [6:0]  HEX3,

      ///////// HEX4 /////////
      output      [6:0]  HEX4,

      ///////// HEX5 /////////
      output      [6:0]  HEX5,

`ifdef ENABLE_HPS
      ///////// HPS /////////
      input              HPS_CONV_USB_N,
      output      [14:0] HPS_DDR3_ADDR,
      output      [2:0]  HPS_DDR3_BA,
      output             HPS_DDR3_CAS_N,
      output             HPS_DDR3_CKE,
      output             HPS_DDR3_CK_N,
      output             HPS_DDR3_CK_P,
      output             HPS_DDR3_CS_N,
      output      [3:0]  HPS_DDR3_DM,
      inout       [31:0] HPS_DDR3_DQ,
      inout       [3:0]  HPS_DDR3_DQS_N,
      inout       [3:0]  HPS_DDR3_DQS_P,
      output             HPS_DDR3_ODT,
      output             HPS_DDR3_RAS_N,
      output             HPS_DDR3_RESET_N,
      input              HPS_DDR3_RZQ,
      output             HPS_DDR3_WE_N,
      output             HPS_ENET_GTX_CLK,
      inout              HPS_ENET_INT_N,
      output             HPS_ENET_MDC,
      inout              HPS_ENET_MDIO,
      input              HPS_ENET_RX_CLK,
      input       [3:0]  HPS_ENET_RX_DATA,
      input              HPS_ENET_RX_DV,
      output      [3:0]  HPS_ENET_TX_DATA,
      output             HPS_ENET_TX_EN,
      inout       [3:0]  HPS_FLASH_DATA,
      output             HPS_FLASH_DCLK,
      output             HPS_FLASH_NCSO,
      inout              HPS_GSENSOR_INT,
      inout              HPS_I2C1_SCLK,
      inout              HPS_I2C1_SDAT,
      inout              HPS_I2C2_SCLK,
      inout              HPS_I2C2_SDAT,
      inout              HPS_I2C_CONTROL,
      inout              HPS_KEY,
      inout              HPS_LED,
      inout              HPS_LTC_GPIO,
      output             HPS_SD_CLK,
      inout              HPS_SD_CMD,
      inout       [3:0]  HPS_SD_DATA,
      output             HPS_SPIM_CLK,
      input              HPS_SPIM_MISO,
      output             HPS_SPIM_MOSI,
      inout              HPS_SPIM_SS,
      input              HPS_UART_RX,
      output             HPS_UART_TX,
      input              HPS_USB_CLKOUT,
      inout       [7:0]  HPS_USB_DATA,
      input              HPS_USB_DIR,
      input              HPS_USB_NXT,
      output             HPS_USB_STP,
`endif /*ENABLE_HPS*/

      ///////// IRDA /////////
      input              IRDA_RXD,
      output             IRDA_TXD,

      ///////// KEY /////////
      input       [3:0]  KEY,

      ///////// LEDR /////////
      output      [9:0]  LEDR,

      ///////// PS2 /////////
      inout              PS2_CLK,
      inout              PS2_CLK2,
      inout              PS2_DAT,
      inout              PS2_DAT2,

      ///////// SW /////////
      input       [9:0]  SW,

      ///////// TD /////////
      input              TD_CLK27,
      input      [7:0]   TD_DATA,
      input              TD_HS,
      output             TD_RESET_N,
      input              TD_VS,

`ifdef ENABLE_USB
      ///////// USB /////////
      input              USB_B2_CLK,
      inout       [7:0]  USB_B2_DATA,
      output             USB_EMPTY,
      output             USB_FULL,
      input              USB_OE_N,
      input              USB_RD_N,
      input              USB_RESET_N,
      inout              USB_SCL,
      inout              USB_SDA,
      input              USB_WR_N,
`endif /*ENABLE_USB*/

      ///////// VGA /////////
      output      [7:0]  VGA_B,
      output             VGA_BLANK_N,
      output             VGA_CLK,
      output      [7:0]  VGA_G,
      output             VGA_HS,
      output      [7:0]  VGA_R,
      output             VGA_SYNC_N,
      output             VGA_VS,
		
		//////////// GPIO1, GPIO1 connect to D5M - 5M Pixel Camera //////////
	   input		   [11:0] D5M_D,
      input		          D5M_FVAL,
      input		          D5M_LVAL,
      input		          D5M_PIXLCLK,
      output		       D5M_RESET_N,
      output		       D5M_SCLK,
      inout		          D5M_SDATA,
      input		          D5M_STROBE,
      output		       D5M_TRIGGER,
      output		       D5M_XCLKIN
);


//=======================================================
//  REG/WIRE declarations
//=======================================================
wire			 [15:0]			Read_DATA1;
wire	       [15:0]			Read_DATA2;

wire			 [11:0]			mCCD_DATA;
wire								mCCD_DVAL;
wire								mCCD_DVAL_d;
wire	       [15:0]			X_Cont;
wire	       [15:0]			Y_Cont;
wire	       [9:0]			X_ADDR;
wire	       [31:0]			Frame_Cont;
wire								DLY_RST_0;
wire								DLY_RST_1;
wire								DLY_RST_2;
wire								DLY_RST_3;
wire								DLY_RST_4;
wire								DLY_RST_DISP_0;
wire								DLY_RST_DISP_1;
wire								DLY_RST_DISP_2;
wire								DLY_RST_DISP_3;
wire								DLY_RST_DISP_4;
wire								Read;
reg		    [11:0]			rCCD_DATA;
reg								rCCD_LVAL;
reg								rCCD_FVAL;
wire	       [11:0]			sCCD_R;
wire	       [11:0]			sCCD_G;
wire	       [11:0]			sCCD_B;
wire								sCCD_DVAL;

wire								sdram_ctrl_clk;
wire	       [9:0]			oVGA_R;   				//	VGA Red[9:0]
wire	       [9:0]			oVGA_G;	 				//	VGA Green[9:0]
wire	       [9:0]			oVGA_B;   				//	VGA Blue[9:0]

//power on start
wire             				auto_start;

// UART
wire 		[7:0] 	rx_data;
wire 					write;
wire 					rxd;
wire					txd;
wire					tbr;
reg					tx_en;
reg 		[19:0]	tx_count;

// Display
wire		[9:0] 	iRed;
wire		[9:0] 	iGreen;
wire		[9:0] 	iBlue;
reg		[7:0] 	cur_img;
wire		[22:0] 	read_addr;
wire		[22:0] 	max_read_addr;
wire		[22:0] 	sel_addr;
reg 		[9:0] 	disp_sync_d;
reg					dispRst_ff;
reg 					prev_button;   
reg 					trigger;

// Resize
reg               resize_start;
reg               resize_valid;
wire 		[7:0]    resize_pix;
wire              resize_wr;
wire              resize_rd;
wire     [22:0]   resize_addr;

// RAM
wire 		[9:0]		addressRam;
wire		[7:0]		ramData;

//=======================================================
//  Structural coding
//=======================================================

// UART
assign rxd = GPIO_0[5];
assign GPIO_0[3] = txd;

assign sel_addr = 
	(cur_img == 8'd0)  ? 23'h050000 :
	(cur_img == 8'd1)  ? 23'h050000 + (76800*1) :
	(cur_img == 8'd2)  ? 23'h050000 + (76800*1) :
	(cur_img == 8'd3)  ? 23'h050000 + (76800*2) :
	(cur_img == 8'd4)  ? 23'h050000 + (76800*3) :
	(cur_img == 8'd5)  ? 23'h050000 + (76800*4) :
	(cur_img == 8'd6)  ? 23'h050000 + (76800*5) :
	(cur_img == 8'd7)  ? 23'h050000 + (76800*6) :
	(cur_img == 8'd8)  ? 23'h050000 + (76800*7) :
	(cur_img == 8'd9)  ? 23'h050000 + (76800*8) :
	(cur_img == 8'd10) ? 23'h050000 + (76800*9) :
	(cur_img == 8'd11) ? 23'h050000 + (76800*10) :
	(cur_img == 8'd12) ? 23'h050000 + (76800*11) :
	(cur_img == 8'd13) ? 23'h050000 + (76800*12) :
	(cur_img == 8'd14) ? 23'h050000 + (76800*13) :
	(cur_img == 8'd15) ? 23'h050000 + (76800*14) :
	(cur_img == 8'd16) ? 23'h050000 + (76800*15) :
	(cur_img == 8'd17) ? 23'h050000 + (76800*16) :
	(cur_img == 8'd18) ? 23'h050000 + (76800*17) :
	(cur_img == 8'd19) ? 23'h050000 + (76800*18) :
	(cur_img == 8'd20) ? 23'h050000 + (76800*38) :
	(cur_img == 8'd21) ? 23'h050000 + (76800*19) :
	(cur_img == 8'd22) ? 23'h050000 + (76800*20) :
	(cur_img == 8'd23) ? 23'h050000 + (76800*21) :
	(cur_img == 8'd24) ? 23'h050000 + (76800*22) :
	(cur_img == 8'd25) ? 23'h050000 + (76800*23) :
	(cur_img == 8'd26) ? 23'h050000 + (76800*24) :
	(cur_img == 8'd27) ? 23'h050000 + (76800*25) :
	(cur_img == 8'd28) ? 23'h050000 + (76800*19) :
	(cur_img == 8'd29) ? 23'h050000 + (76800*26) :
	(cur_img == 8'd30) ? 23'h050000 + (76800*27) :
	(cur_img == 8'd31) ? 23'h050000 + (76800*28) :
	(cur_img == 8'd32) ? 23'h050000 + (76800*29) :
	(cur_img == 8'd33) ? 23'h050000 + (76800*30) :
	(cur_img == 8'd34) ? 23'h050000 + (76800*1) :
	(cur_img == 8'd35) ? 23'h050000 + (76800*7) :
	(cur_img == 8'd36) ? 23'h050000 + (76800*31) :
	(cur_img == 8'd37) ? 23'h050000 + (76800*32) :
	(cur_img == 8'd38) ? 23'h050000 + (76800*33) :
	(cur_img == 8'd39) ? 23'h050000 + (76800*34) :
	(cur_img == 8'd40) ? 23'h050000 + (76800*35) :
	(cur_img == 8'd41) ? 23'h050000 + (76800*29) :
	(cur_img == 8'd42) ? 23'h050000 + (76800*36) :
	(cur_img == 8'd43) ? 23'h050000 + (76800*37) :
	(cur_img == 8'd44) ? 23'h050000 + (76800*38) :
	(cur_img == 8'd45) ? 23'h050000 + (76800*39) :
	23'h050000 + (76800*40); // 46

// UART Display Selectio
assign read_addr 	= SW[8] ? 23'h000000 : sel_addr;
assign max_read_addr = SW[8] ? 640*480 : 320*240;

always @(posedge CLOCK_50 or negedge DLY_RST_0) begin
  if (!DLY_RST_0) begin
    cur_img <= 8'h00;
  end else if (write & !SW[7]) begin	// Only change the current image when SW[7] not flipped
    cur_img <= rx_data;
  end else begin
	 cur_img <= cur_img;
  end
end

// TX Reset
always @(posedge CLOCK_50) begin
    prev_button <= !KEY[2]; // Store the current button value in the next cycle
end

always @(posedge CLOCK_50) begin
    if (!KEY[2] && !prev_button) begin // Rising edge detected
        trigger <= 1'b1;             // Set the trigger signal
    end else begin
        trigger <= 1'b0;             // Reset the trigger signal
    end
end

// Resize start and TX Enable
always@(negedge DLY_RST_0 or posedge CLOCK_50 or posedge trigger or negedge KEY[3])
begin
	if (!DLY_RST_0 | !KEY[3]) begin
		resize_start <= 1'b0;
		tx_en <= 1'b0;
	end
	else if (trigger) begin
		resize_start <= 1'b1;
		tx_en <= 1'b0;
	end
	else if (resize_valid) begin
		tx_en <= 1'b1;
		resize_start <= 1'b0;
	end
	else if (tx_count >= 1024) begin
		tx_en <= 1'b0;
		resize_start <= 1'b0;
	end else begin
		resize_start <= 1'b0;
	end
end

always@(posedge CLOCK_50 or negedge DLY_RST_0 or negedge KEY[2])
begin
	if (!DLY_RST_0) begin
		tx_count <= 1'b0;
	end
	else if (!KEY[2]) begin
		tx_count <= 1'b0;
	end
	else if (tbr & tx_en) begin
		tx_count <= tx_count + 1'b1;
	end
end

// Display Reset
// Sample switches
always @(posedge CLOCK_50 or negedge DLY_RST_0) begin
  if (!DLY_RST_0) begin
    disp_sync_d  <= 9'h000;
  end else begin
    disp_sync_d  <= {cur_img, SW[8]};	// Only need 7 bits for 47 image select
  end
end

// Detect SW change
wire disp_changed = ({cur_img, SW[8]} != disp_sync_d);

// Generate rst
always @(posedge CLOCK_50 or negedge DLY_RST_0) begin
  if (!DLY_RST_0)
    dispRst_ff <= 1'b1;
  else if (disp_changed)
    dispRst_ff <= 1'b0;     // pulse low when a switch toggles
  else
    dispRst_ff <= 1'b1;     // otherwise stay high
end

// RAM Address
always @(posedge CLOCK_50 or negedge DLY_RST_0) begin
  if (!DLY_RST_0) begin
    addressRam <= 10'h000;
  end else if (resize_valid) begin
    addressRam <= 10'h000;
  end else if (addressRam >= 1024) begin
    addressRam <= 10'h000;
  end else if ((tbr & tx_en) | resize_wr) begin
	 addressRam <= addressRam + 1'b1;
  end
end

// D5M
assign	D5M_TRIGGER	=	1'b1;  // tRIGGER
assign	D5M_RESET_N	=	DLY_RST_1;

wire 		VGA_CTRL_CLK;


assign	LEDR		=	Y_Cont;

//fetch the high 8 bits
// assign  VGA_R = oVGA_R[9:2];
// assign  VGA_G = oVGA_G[9:2];
// assign  VGA_B = oVGA_B[9:2];

//D5M read 
always@(posedge D5M_PIXLCLK)
begin
	rCCD_DATA	<=	D5M_D;
	rCCD_LVAL	<=	D5M_LVAL;
	rCCD_FVAL	<=	D5M_FVAL;
end

//auto start when power on
assign auto_start = (((SW[0])&&(DLY_RST_3)&&(!DLY_RST_4))|((dispRst_ff)&&(DLY_RST_DISP_3)&&(!DLY_RST_DISP_4)))? 1'b1:1'b0;
//Reset module
Reset_Delay			u2	(	
							.iCLK(CLOCK_50),
							.iRST(KEY[0]),
							.oRST_0(DLY_RST_0),
							.oRST_1(DLY_RST_1),
							.oRST_2(DLY_RST_2),
							.oRST_3(DLY_RST_3),
							.oRST_4(DLY_RST_4)
						   );
							
 Reset_Delay			u22	(	
 							.iCLK(CLOCK_50),
 							.iRST(dispRst_ff),
 							.oRST_0(DLY_RST_DISP_0),
 							.oRST_1(DLY_RST_DISP_1),
 							.oRST_2(DLY_RST_DISP_2),
 							.oRST_3(DLY_RST_DISP_3),
 							.oRST_4(DLY_RST_DISP_4)
						   );

//D5M image capture
CCD_Capture			u3	(	
							.oDATA(mCCD_DATA),
							.oDVAL(mCCD_DVAL),
							.oX_Cont(X_Cont),
							.oY_Cont(Y_Cont),
							.oFrame_Cont(Frame_Cont),
							.iDATA(rCCD_DATA),
							.iFVAL(rCCD_FVAL),
							.iLVAL(rCCD_LVAL),
							.iSTART(!KEY[3]|auto_start),
							.iEND(!KEY[2]),
							.iCLK(~D5M_PIXLCLK),
							.iRST(DLY_RST_2 & DLY_RST_DISP_2)
						   );

//D5M raw date convert to RGB data
RAW2RGB				u4	(	
							.iCLK(D5M_PIXLCLK),
							.iRST(DLY_RST_1),
							.iDATA(mCCD_DATA),
							.iDVAL(mCCD_DVAL),
							.oRed(sCCD_R),
							.oGreen(sCCD_G),
							.oBlue(sCCD_B),
							.oDVAL(sCCD_DVAL),
							.iX_Cont(X_Cont),
							.iY_Cont(Y_Cont)
						   );

// //Frame count display
// SEG7_LUT_6 			u5	(	
// 							.oSEG0(HEX0),.oSEG1(HEX1),
// 							.oSEG2(HEX2),.oSEG3(HEX3),
// 							.oSEG4(HEX4),.oSEG5(HEX5),
// 							.iDIG({7'h00, tx_en, rx_data, cur_img})
// 						   );
												
sdram_pll 			u6	(
							.refclk(CLOCK_50),
							.rst(1'b0),
							.outclk_0(sdram_ctrl_clk),
							.outclk_1(DRAM_CLK),
							.outclk_2(D5M_XCLKIN),    //25M
					      .outclk_3(VGA_CTRL_CLK)   //25M
						   );

//SDRam Read and Write as Frame Buffer
Sdram_Control	   u7	(	//	HOST Side						
						   .RESET_N(SW[0]),
							.CLK(sdram_ctrl_clk),

							//	FIFO Write Side 1
							.WR1_DATA({8'h00, rx_data}),
							.WR1(write & SW[7]),	// Only write whats recieved when SW[7] is asserted
							.WR1_ADDR(23'h050000),
                     .WR1_MAX_ADDR(23'h050000+(76800*47)), // for 47 images
						   .WR1_LENGTH(8'h50),
		               .WR1_LOAD(!DLY_RST_0),
							.WR1_CLK(~CLOCK_50), // D5M_PIXLCLK

							//	FIFO Write Side 2
							.WR2_DATA({4'h0, sCCD_R[11:0]}),  
							.WR2(sCCD_DVAL), // sCCD_DVAL
							.WR2_ADDR(0),
							.WR2_MAX_ADDR(640*480),
							.WR2_LENGTH(8'h50),
							.WR2_LOAD(!DLY_RST_0 | !DLY_RST_DISP_0),				
							.WR2_CLK(~D5M_PIXLCLK),

							//	FIFO Read Side 1, Resize
						   .RD1_DATA(Read_DATA1),
				        	.RD1(resize_rd), // resize_rd
				        	.RD1_ADDR(resize_addr),
                     .RD1_MAX_ADDR(resize_addr+20),
							.RD1_LENGTH(8'h14),
							.RD1_LOAD(!DLY_RST_0),
							.RD1_CLK(~CLOCK_50),
							
                     //	FIFO Read Side 2
						   .RD2_DATA(Read_DATA2),
				        	.RD2(Read),
				        	.RD2_ADDR(read_addr),
                     .RD2_MAX_ADDR(read_addr+(max_read_addr)),
							.RD2_LENGTH(8'h50),
							.RD2_LOAD(!DLY_RST_0 | !DLY_RST_DISP_0),
							.RD2_CLK(~VGA_CTRL_CLK),
										
							//	SDRAM Side
						   .SA(DRAM_ADDR),
							.BA(DRAM_BA),
							.CS_N(DRAM_CS_N),
							.CKE(DRAM_CKE),
							.RAS_N(DRAM_RAS_N),
							.CAS_N(DRAM_CAS_N),
							.WE_N(DRAM_WE_N),
							.DQ(DRAM_DQ),
							.DQM({DRAM_UDQM,DRAM_LDQM})
						   );
							
				
//D5M I2C control
I2C_CCD_Config 	u8	(	//	Host Side
							.iCLK(CLOCK2_50),
							.iRST_N(SW[0]),
							.iEXPOSURE_ADJ(),
							.iEXPOSURE_DEC_p(),
							.iZOOM_MODE_SW(),
							//	I2C Side
							.I2C_SCLK(D5M_SCLK),
							.I2C_SDAT(D5M_SDATA)
						   );
							

							
//VGA DISPLAY
VGA_Controller	  u1	(	//	Host Side
							.oRequest(Read),
							.iRed(SW[8] ? {Read_DATA2[11:2]} : {Read_DATA2[7:5], 7'h00}),
					      .iGreen(SW[8] ? {Read_DATA2[11:2]} : {Read_DATA2[4:2], 7'h00}),
						   .iBlue(SW[8] ? {Read_DATA2[11:2]} : {Read_DATA2[1:0], 8'h00}),
							.iSize(SW[8]),
							//	VGA Side
							.oVGA_R(oVGA_R),
							.oVGA_G(oVGA_G),
							.oVGA_B(oVGA_B),
							.oVGA_H_SYNC(),
							.oVGA_V_SYNC(),
							.oVGA_SYNC(),
							.oVGA_BLANK(),
							//	Control Signal
							.iCLK(VGA_CTRL_CLK),
							.iRST_N(DLY_RST_2 & DLY_RST_DISP_2),
							.iZOOM_MODE_SW(SW[9])
						   );


uart_rx 					#(
							.UART_BPS    (20'd115200),   
							.CLK_FREQ    (26'd50_000_000))     
							uart_rx_inst (
							.sys_clk     (CLOCK_50),
							.sys_rst_n   (SW[0]),
							.rx          (rxd),
							.po_data     (rx_data),
							.po_flag     (write)
							);

uart_tx					uart_tx_inst (
							.clk(CLOCK_50), 
							.rst_n(SW[0]),		
							.trmt(tbr & tx_en),				
							.tx_data(ramData),		
							.TX(txd),				
							.tx_done(tbr)
							);


vgatest vgatest(
.clk_50m(CLOCK_50),
.rst_n(SW[0]),
.direction_ori({KEY[3], KEY[2], KEY[1], KEY[0]}),
.shoot(SW[9]),
.red(VGA_R),
.green(VGA_G),
.blue(VGA_B),
.hsync(VGA_HS),
.vsync(VGA_VS),
.dac_clk(VGA_CLK),
.dac_sync(VGA_SYNC_N),
.dac_blank(VGA_BLANK_N),
.seg0(HEX0),
.seg1(HEX1),
.seg2(HEX2),
.seg3(HEX3),
.seg4(HEX4),
.seg5(HEX5),
.direction_reg(),//debug
.bullet_exit24(),//debug

.random(),//debug
.live_debug(),
.bullet_exit_debug()
);

//Image Resizer
image_resize     u12 (
                     .clk(CLOCK_50),       
                     .rst_n(DLY_RST_0),     
                     .iStart(resize_start),    
                     .iPix(Read_DATA1[11:4]),
                     .oSdramRd(resize_rd),  
                     .oSdramAddr(resize_addr),
                     .oSdramWr(resize_wr),  
                     .oPix(resize_pix),      
                     .oResizeValid(resize_valid)
                     );
							
// // RAM Storing resized image							
// RESIZED_IMG u100(
// 	.address(addressRam),
// 	.clock(CLOCK_50),
// 	.data(resize_pix),
// 	.wren(resize_wr),
// 	.q(ramData));

endmodule