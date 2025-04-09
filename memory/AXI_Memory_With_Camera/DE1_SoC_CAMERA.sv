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

`define ENABLE_HPS
`define ENABLE_USB
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
      inout              HPS_CONV_USB_N,
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
      inout       		 HPS_LTC_GPIO,
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
wire								Read;
reg		    [11:0]			rCCD_DATA;
reg								rCCD_LVAL;
reg								rCCD_FVAL;
wire	       [11:0]			sCCD_R;
wire	       [11:0]			sCCD_G;
wire	       [11:0]			sCCD_B;
wire	       [11:0]			sCCD_R_BW;
wire	       [11:0]			sCCD_G_BW;
wire	       [11:0]			sCCD_B_BW;
wire	       [11:0]			sCCD_R_RGB;
wire	       [11:0]			sCCD_G_RGB;
wire	       [11:0]			sCCD_B_RGB;
wire								sCCD_DVAL;
wire							   sCCD_DVAL_BW;
wire								sCCD_DVAL_RGB;

wire								sdram_ctrl_clk;
wire	       [9:0]			oVGA_R;   				//	VGA Red[9:0]
wire	       [9:0]			oVGA_G;	 				//	VGA Green[9:0]
wire	       [9:0]			oVGA_B;   				//	VGA Blue[9:0]

//power on start
wire             				auto_start;

//=======================================================
// HPS_to_FPGA FIFO state machine
//=======================================================
// --Check for data
//
// --Read data 
// --add one
// --write to SRAM
// --signal HPS data_ready
//=======================================================
// Controls for Qsys sram slave exported in system module
//=======================================================
wire [31:0] sram_readdata ;
reg [31:0] sram_writedata ;
reg [7:0] sram_address; 
reg sram_write ;
wire sram_clken = 1'b1;
wire sram_chipselect = 1'b1;
reg [7:0] state ;

//=======================================================
// Controls for HPS_to_FPGA FIFO
//=======================================================

reg [31:0] hps_to_fpga_readdata ; 
reg hps_to_fpga_read ; // read command
// status addresses
// base => fill level
// base+1 => status bits; 
//           bit0==1 if full
//           bit1==1 if empty
wire [31:0] hps_to_fpga_out_csr_address = 32'd1 ; // fill_level
reg[31:0] hps_to_fpga_out_csr_readdata ;
reg hps_to_fpga_out_csr_read ; // status regs read cmd
reg [7:0] HPS_to_FPGA_state ;
reg [31:0] data_buffer ;
reg data_buffer_valid ;

//=======================================================
// Controls for FPGA_to_HPS FIFO
//=======================================================

reg [31:0] fpga_to_hps_in_writedata ; 
reg fpga_to_hps_in_write ; // write command
// status addresses
// base => fill level
// base+1 => status bits; 
//           bit0==1 if full
//           bit1==1 if empty
wire [31:0] fpga_to_hps_in_csr_address = 32'd1 ; // fill_level
reg[31:0] fpga_to_hps_in_csr_readdata ;
reg fpga_to_hps_in_csr_read ; // status regs read cmd
reg [7:0] FPGA_to_HPS_state ;

//=======================================================
// do the work outlined above
always @(posedge CLOCK_50) begin // CLOCK_50

   // reset state machine and read/write controls
	if (~KEY[0]) begin
		HPS_to_FPGA_state <= 8'd0 ;
		sram_write <= 1'b0 ;
	end
	
	// =================================
	// HPS_to_FPGA state machine
	//==================================
	// Is there data in HPS_to_FPGA FIFO
	// and the last transfer is complete
	if (HPS_to_FPGA_state == 8'd0 && !(hps_to_fpga_out_csr_readdata[1]) && !data_buffer_valid)  begin
		hps_to_fpga_read <= 1'b1 ;
		HPS_to_FPGA_state <= 8'd2 ; //
	end
	
	// delay
	if (HPS_to_FPGA_state == 8'd2) begin
		// zero the read request BEFORE the data appears 
		// in the next state!
		hps_to_fpga_read <= 1'b0 ;
		HPS_to_FPGA_state <= 8'd4 ;
	end
	
	// read the word from the FIFO
	if (HPS_to_FPGA_state == 8'd4) begin
		data_buffer <= hps_to_fpga_readdata ; // send back data
		data_buffer_valid <= 1'b1 ; // set the data ready flag
		hps_to_fpga_read <= 1'b0 ;
		HPS_to_FPGA_state <= 8'd0 ; //6
	end
	
	// =================================
	// FPGA_to_HPS state machine
	//================================== 
	// is there space in the 
	// FPGA_to_HPS FIFO
	// and data is available
	if (FPGA_to_HPS_state==0 && !(fpga_to_hps_in_csr_readdata[0]) && data_buffer_valid) begin
		fpga_to_hps_in_writedata <= data_buffer ;	
		fpga_to_hps_in_write <= 1'b1 ;
		FPGA_to_HPS_state <= 8'd4 ;
	end
	
	// finish the write to FPGA_to_HPS FIFO
	//if (HPS_to_FPGA_state == 8'd8) begin
	if (FPGA_to_HPS_state==4) begin
		fpga_to_hps_in_write <= 1'b0 ;
		data_buffer_valid <= 1'b0 ; // used the data, so clear flag
		FPGA_to_HPS_state <= 8'd0 ;
	end
	
	//==================================c
end // always @(posedge state_clock)

//=======================================================
//  Structural coding
//=======================================================
// D5M
assign	D5M_TRIGGER	=	1'b1;  // tRIGGER
assign	D5M_RESET_N	=	DLY_RST_1;

assign   VGA_CTRL_CLK = VGA_CLK;

assign	LEDR		=	Y_Cont;

//fetch the high 8 bits
assign  VGA_R = oVGA_R[9:2];
assign  VGA_G = oVGA_G[9:2];
assign  VGA_B = oVGA_B[9:2];

//D5M read 
always@(posedge D5M_PIXLCLK)
begin
	rCCD_DATA	<=	D5M_D;
	rCCD_LVAL	<=	D5M_LVAL;
	rCCD_FVAL	<=	D5M_FVAL;
end

//auto start when power on
assign auto_start = ((KEY[0])&&(DLY_RST_3)&&(!DLY_RST_4))? 1'b1:1'b0;
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
							.iRST(DLY_RST_2)
						   );
//D5M raw date convert to RGB data
// Switch between grayscale and rgb output
assign sCCD_R = SW[0] ? sCCD_R_BW : sCCD_R_RGB;
assign sCCD_G = SW[0] ? sCCD_G_BW : sCCD_G_RGB;
assign sCCD_B = SW[0] ? sCCD_B_BW : sCCD_B_RGB;
assign sCCD_DVAL = SW[0] ? sCCD_DVAL_BW : sCCD_DVAL_RGB;

// Module written for this lab
img_proc				u10	(	
							.iCLK(D5M_PIXLCLK),
							.iRST(DLY_RST_1),
							.iDATA(mCCD_DATA),
							.iDVAL(mCCD_DVAL),
							.oRed(sCCD_R_BW),
							.oGreen(sCCD_G_BW),
							.oBlue(sCCD_B_BW),
							.oDVAL(sCCD_DVAL_BW),
							.iX_Cont(X_Cont),
							.iY_Cont(Y_Cont),
                     .iSW(SW[1]),
                     .iSW1(SW[2])
						   );

// Already written module
RAW2RGB				u4	(	
							.iCLK(D5M_PIXLCLK),
							.iRST(DLY_RST_1),
							.iDATA(mCCD_DATA),
							.iDVAL(mCCD_DVAL),
							.oRed(sCCD_R_RGB),
							.oGreen(sCCD_G_RGB),
							.oBlue(sCCD_B_RGB),
							.oDVAL(sCCD_DVAL_RGB),
							.iX_Cont(X_Cont),
							.iY_Cont(Y_Cont)
						   );
                  

//Frame count display
SEG7_LUT_6 			u5	(	
							.oSEG0(HEX0),.oSEG1(HEX1),
							.oSEG2(HEX2),.oSEG3(HEX3),
							.oSEG4(HEX4),.oSEG5(HEX5),
							.iDIG(Frame_Cont[23:0])
						   );
												
sdram_pll 			u6	(
							.refclk(CLOCK_50),
							.rst(DLY_RST_0),
							.outclk_0(sdram_ctrl_clk),
							.outclk_1(DRAM_CLK),
							.outclk_2(D5M_XCLKIN),    //25M
					      .outclk_3(VGA_CLK)       //25M

						   );



//SDRam Read and Write as Frame Buffer
Sdram_Control	   u7	(	//	HOST Side						
						   .RESET_N(DLY_RST_0),
							.CLK(sdram_ctrl_clk),

							//	FIFO Write Side 1
							.WR1_DATA({1'b0,sCCD_G[11:7],sCCD_B[11:2]}),
							.WR1(sCCD_DVAL),
							.WR1_ADDR(0),
                     .WR1_MAX_ADDR(640*480),
						   .WR1_LENGTH(8'h50),
		               .WR1_LOAD(!DLY_RST_0),
							.WR1_CLK(~D5M_PIXLCLK),

							//	FIFO Write Side 2
							.WR2_DATA({1'b0,sCCD_G[6:2],sCCD_R[11:2]}),
							.WR2(sCCD_DVAL),
							.WR2_ADDR(23'h100000),
							.WR2_MAX_ADDR(23'h100000+640*480),
							.WR2_LENGTH(8'h50),
							.WR2_LOAD(!DLY_RST_0),				
							.WR2_CLK(~D5M_PIXLCLK),

                     //	FIFO Read Side 1
						   .RD1_DATA(Read_DATA1),
				        	.RD1(Read),
				        	.RD1_ADDR(0),
                     .RD1_MAX_ADDR(640*480),
							.RD1_LENGTH(8'h50),
							.RD1_LOAD(!DLY_RST_0),
							.RD1_CLK(~VGA_CTRL_CLK),
							
							//	FIFO Read Side 2
						   .RD2_DATA(Read_DATA2),
							.RD2(Read),
							.RD2_ADDR(23'h100000),
                     .RD2_MAX_ADDR(23'h100000+640*480),
							.RD2_LENGTH(8'h50),
                   	.RD2_LOAD(!DLY_RST_0),
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
							.iRST_N(DLY_RST_2),
							.iEXPOSURE_ADJ(KEY[1]),
							.iEXPOSURE_DEC_p(SW[0]),
							.iZOOM_MODE_SW(SW[9]),
							//	I2C Side
							.I2C_SCLK(D5M_SCLK),
							.I2C_SDAT(D5M_SDATA)
						   );
//VGA DISPLAY
VGA_Controller	  u1	(	//	Host Side
							.oRequest(Read),
							.iRed(Read_DATA2[9:0]),
					      .iGreen({Read_DATA1[14:10],Read_DATA2[14:10]}),
						   .iBlue(Read_DATA1[9:0]),
						
							//	VGA Side
							.oVGA_R(oVGA_R),
							.oVGA_G(oVGA_G),
							.oVGA_B(oVGA_B),
							.oVGA_H_SYNC(VGA_HS),
							.oVGA_V_SYNC(VGA_VS),
							.oVGA_SYNC(VGA_SYNC_N),
							.oVGA_BLANK(VGA_BLANK_N),
							//	Control Signal
							.iCLK(VGA_CTRL_CLK),
							.iRST_N(DLY_RST_2),
							.iZOOM_MODE_SW(SW[9])
						   );

`ifdef ENABLE_HPS
Computer_System The_System (
	////////////////////////////////////
	// FPGA Side
	////////////////////////////////////

	// Global signals
	.system_pll_ref_clk_clk				(CLOCK_50),
	.system_pll_ref_reset_reset			(KEY[0]),
	
	// SRAM shared block with HPS
	.onchip_sram_s1_address               (sram_address),               
	.onchip_sram_s1_clken                 (sram_clken),                 
	.onchip_sram_s1_chipselect            (sram_chipselect),            
	.onchip_sram_s1_write                 (sram_write),                 
	.onchip_sram_s1_readdata              (sram_readdata),              
	.onchip_sram_s1_writedata             (sram_writedata),             
	.onchip_sram_s1_byteenable            (4'b1111), 

	// 50 MHz clock bridge
	.clock_bridge_0_in_clk_clk            (CLOCK_50), //(CLOCK_50), 
	
	// HPS to FPGA FIFO
	.fifo_hps_to_fpga_out_readdata      (hps_to_fpga_readdata),      //  fifo_hps_to_fpga_out.readdata
	.fifo_hps_to_fpga_out_read          (hps_to_fpga_read),          //   out.read
	.fifo_hps_to_fpga_out_waitrequest   (),                            //   out.waitrequest
	.fifo_hps_to_fpga_out_csr_address   (32'd1), //(hps_to_fpga_out_csr_address),   // fifo_hps_to_fpga_out_csr.address
	.fifo_hps_to_fpga_out_csr_read      (1'b1), //(hps_to_fpga_out_csr_read),      //   csr.read
	.fifo_hps_to_fpga_out_csr_writedata (),                              //   csr.writedata
	.fifo_hps_to_fpga_out_csr_write     (1'b0),                           //   csr.write
	.fifo_hps_to_fpga_out_csr_readdata  (hps_to_fpga_out_csr_readdata),		//   csr.readdata
	
	// FPGA to HPS FIFO
	.fifo_fpga_to_hps_in_writedata      (fpga_to_hps_in_writedata),      // fifo_fpga_to_hps_in.writedata
	.fifo_fpga_to_hps_in_write          (fpga_to_hps_in_write),          //                     .write
	.fifo_fpga_to_hps_in_csr_address    (32'd1), //(fpga_to_hps_in_csr_address),    //  fifo_fpga_to_hps_in_csr.address
	.fifo_fpga_to_hps_in_csr_read       (1'b1), //(fpga_to_hps_in_csr_read),       //                         .read
	.fifo_fpga_to_hps_in_csr_writedata  (),  //                         .writedata
	.fifo_fpga_to_hps_in_csr_write      (1'b0),      //                         .write
	.fifo_fpga_to_hps_in_csr_readdata   (fpga_to_hps_in_csr_readdata),    //                         .readdata
	
	////////////////////////////////////
	// HPS Side
	////////////////////////////////////
	// DDR3 SDRAM
	.memory_mem_a			(HPS_DDR3_ADDR),
	.memory_mem_ba			(HPS_DDR3_BA),
	.memory_mem_ck			(HPS_DDR3_CK_P),
	.memory_mem_ck_n		(HPS_DDR3_CK_N),
	.memory_mem_cke		(HPS_DDR3_CKE),
	.memory_mem_cs_n		(HPS_DDR3_CS_N),
	.memory_mem_ras_n		(HPS_DDR3_RAS_N),
	.memory_mem_cas_n		(HPS_DDR3_CAS_N),
	.memory_mem_we_n		(HPS_DDR3_WE_N),
	.memory_mem_reset_n	(HPS_DDR3_RESET_N),
	.memory_mem_dq			(HPS_DDR3_DQ),
	.memory_mem_dqs		(HPS_DDR3_DQS_P),
	.memory_mem_dqs_n		(HPS_DDR3_DQS_N),
	.memory_mem_odt		(HPS_DDR3_ODT),
	.memory_mem_dm			(HPS_DDR3_DM),
	.memory_oct_rzqin		(HPS_DDR3_RZQ),
		  
	// Ethernet
	.hps_io_hps_io_gpio_inst_GPIO35	(HPS_ENET_INT_N),
	.hps_io_hps_io_emac1_inst_TX_CLK	(HPS_ENET_GTX_CLK),
	.hps_io_hps_io_emac1_inst_TXD0	(HPS_ENET_TX_DATA[0]),
	.hps_io_hps_io_emac1_inst_TXD1	(HPS_ENET_TX_DATA[1]),
	.hps_io_hps_io_emac1_inst_TXD2	(HPS_ENET_TX_DATA[2]),
	.hps_io_hps_io_emac1_inst_TXD3	(HPS_ENET_TX_DATA[3]),
	.hps_io_hps_io_emac1_inst_RXD0	(HPS_ENET_RX_DATA[0]),
	.hps_io_hps_io_emac1_inst_MDIO	(HPS_ENET_MDIO),
	.hps_io_hps_io_emac1_inst_MDC		(HPS_ENET_MDC),
	.hps_io_hps_io_emac1_inst_RX_CTL	(HPS_ENET_RX_DV),
	.hps_io_hps_io_emac1_inst_TX_CTL	(HPS_ENET_TX_EN),
	.hps_io_hps_io_emac1_inst_RX_CLK	(HPS_ENET_RX_CLK),
	.hps_io_hps_io_emac1_inst_RXD1	(HPS_ENET_RX_DATA[1]),
	.hps_io_hps_io_emac1_inst_RXD2	(HPS_ENET_RX_DATA[2]),
	.hps_io_hps_io_emac1_inst_RXD3	(HPS_ENET_RX_DATA[3]),

	// Flash
	.hps_io_hps_io_qspi_inst_IO0	(HPS_FLASH_DATA[0]),
	.hps_io_hps_io_qspi_inst_IO1	(HPS_FLASH_DATA[1]),
	.hps_io_hps_io_qspi_inst_IO2	(HPS_FLASH_DATA[2]),
	.hps_io_hps_io_qspi_inst_IO3	(HPS_FLASH_DATA[3]),
	.hps_io_hps_io_qspi_inst_SS0	(HPS_FLASH_NCSO),
	.hps_io_hps_io_qspi_inst_CLK	(HPS_FLASH_DCLK),

	// Accelerometer
	.hps_io_hps_io_gpio_inst_GPIO61	(HPS_GSENSOR_INT),

	//.adc_sclk                        (ADC_SCLK),
	//.adc_cs_n                        (ADC_CS_N),
	//.adc_dout                        (ADC_DOUT),
	//.adc_din                         (ADC_DIN),

	// I2C
	.hps_io_hps_io_gpio_inst_GPIO48	(HPS_I2C_CONTROL),
	.hps_io_hps_io_i2c0_inst_SDA		(HPS_I2C1_SDAT),
	.hps_io_hps_io_i2c0_inst_SCL		(HPS_I2C1_SCLK),
	.hps_io_hps_io_i2c1_inst_SDA		(HPS_I2C2_SDAT),
	.hps_io_hps_io_i2c1_inst_SCL		(HPS_I2C2_SCLK),

	// Pushbutton
	.hps_io_hps_io_gpio_inst_GPIO54	(HPS_KEY),

	// LED
	.hps_io_hps_io_gpio_inst_GPIO53	(HPS_LED),

	// SD Card
	.hps_io_hps_io_sdio_inst_CMD	(HPS_SD_CMD),
	.hps_io_hps_io_sdio_inst_D0	(HPS_SD_DATA[0]),
	.hps_io_hps_io_sdio_inst_D1	(HPS_SD_DATA[1]),
	.hps_io_hps_io_sdio_inst_CLK	(HPS_SD_CLK),
	.hps_io_hps_io_sdio_inst_D2	(HPS_SD_DATA[2]),
	.hps_io_hps_io_sdio_inst_D3	(HPS_SD_DATA[3]),

	// SPI
	.hps_io_hps_io_spim1_inst_CLK		(HPS_SPIM_CLK),
	.hps_io_hps_io_spim1_inst_MOSI	(HPS_SPIM_MOSI),
	.hps_io_hps_io_spim1_inst_MISO	(HPS_SPIM_MISO),
	.hps_io_hps_io_spim1_inst_SS0		(HPS_SPIM_SS),

	// UART
	.hps_io_hps_io_uart0_inst_RX	(HPS_UART_RX),
	.hps_io_hps_io_uart0_inst_TX	(HPS_UART_TX),

	`ifdef ENABLE_USB
	// USB
	.hps_io_hps_io_gpio_inst_GPIO09	(HPS_CONV_USB_N),
	.hps_io_hps_io_usb1_inst_D0		(HPS_USB_DATA[0]),
	.hps_io_hps_io_usb1_inst_D1		(HPS_USB_DATA[1]),
	.hps_io_hps_io_usb1_inst_D2		(HPS_USB_DATA[2]),
	.hps_io_hps_io_usb1_inst_D3		(HPS_USB_DATA[3]),
	.hps_io_hps_io_usb1_inst_D4		(HPS_USB_DATA[4]),
	.hps_io_hps_io_usb1_inst_D5		(HPS_USB_DATA[5]),
	.hps_io_hps_io_usb1_inst_D6		(HPS_USB_DATA[6]),
	.hps_io_hps_io_usb1_inst_D7		(HPS_USB_DATA[7]),
	.hps_io_hps_io_usb1_inst_CLK		(HPS_USB_CLKOUT),
	.hps_io_hps_io_usb1_inst_STP		(HPS_USB_STP),
	.hps_io_hps_io_usb1_inst_DIR		(HPS_USB_DIR),
	.hps_io_hps_io_usb1_inst_NXT		(HPS_USB_NXT)
	`endif /*ENABLE_USB*/
);
`endif /*ENABLE_HPS*/
`default_nettype wire

endmodule
