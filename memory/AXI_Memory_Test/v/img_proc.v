module img_proc(	oRed,
				oGreen,
				oBlue,
				oDVAL,
				iX_Cont,
				iY_Cont,
				iDATA,
				iDVAL,
				iCLK,
				iRST,
				iSW,
				iSW1
				);

input	[10:0]	iX_Cont;
input	[10:0]	iY_Cont;
input	[11:0]	iDATA;
input			iDVAL;
input			iCLK;
input			iRST;
input			iSW;
input			iSW1;
output	[11:0]	oRed;
output	[11:0]	oGreen;
output	[11:0]	oBlue;
output			oDVAL;

reg				mDVAL;
reg				mDVAL_conv;
reg [11:0] pixel_out, pixel_out_abs;
reg [11:0] pixel_2d, pixel_2dd;
reg [11:0] pixel_1d, pixel_1dd;
reg [11:0] pixel_0d, pixel0_dd;
wire [11:0] pixel_out_conv;
wire [11:0] pixel_out_conv_horz, pixel_out_conv_vert;
reg [12:0] pixel_out_conv_horz_13, pixel_out_conv_vert_13;

wire [11:0] pixel_0, pixel_1, pixel_2;

reg [11:0] shift_reg [10:0];

wire	[11:0]	mDATA_0;
wire	[11:0]	mDATA_1;
reg		[11:0]	mDATAd_0;
reg		[11:0]	mDATAd_1;

// SW1 controls if the output is grayscale or edge detection
assign oRed = iSW ? pixel_out_abs : pixel_out;
assign oGreen = iSW ? pixel_out_abs : pixel_out;
assign oBlue = iSW ? pixel_out_abs : pixel_out;
assign	oDVAL = iSW ? mDVAL : mDVAL;

assign pixel_out_conv_horz = pixel_out_conv_horz_13[11:0];
assign pixel_out_conv_vert = pixel_out_conv_vert_13[11:0];
// SW2 controls if the edge detection is horizontal or vertical
assign pixel_out_conv = iSW1 ? pixel_out_conv_horz : pixel_out_conv_vert;

// Line buffer to store values from the camera (already generator)
Line_Buffer1 u0(.clken(iDVAL),
					.clock(iCLK),
					.shiftin(iDATA),
					.taps0x(mDATA_1),
					.taps1x(mDATA_0));

// Line buffer to store grayscale values for convolution (generated for this lab)
buffer3 u1(.clken(mDVAL),
				.clock(iCLK),
				.shiftin(pixel_out),
				.taps0x(pixel_2),
				.taps1x(pixel_1),
				.taps2x(pixel_0));

always @(posedge iCLK or negedge iRST) begin
    if (!iRST) begin
        mDVAL <= 0;
		pixel_0d <= 0;
		pixel0_dd <= 0;
		pixel_1d <= 0;
		pixel_1dd <= 0;
		pixel_2d <= 0;
		pixel_2dd <= 0;
    end
    else begin
		mDATAd_0 <= mDATA_0;
       	mDATAd_1 <= mDATA_1;

		// Grayscale calculation (average of rgb values)
		pixel_out <= (((mDATAd_0 + mDATA_1) + (mDATA_0 + mDATAd_1))/4);
        mDVAL	  <= {iY_Cont[0]|iX_Cont[0]} ? 1'b0 : iDVAL;

		// Edge detection
		if (mDVAL) begin
			pixel_0d <= pixel_0;
			pixel0_dd <= pixel_0d;
			pixel_1d <= pixel_1;
			pixel_1dd <= pixel_1d;
			pixel_2d <= pixel_2;
			pixel_2dd <= pixel_2d;
		end

		// Vertical and horizontal filters following the filter coefficients given in writeup
		pixel_out_conv_vert_13 <= (~pixel0_dd + 1) + (pixel_0) + (~(pixel_1dd << 1) + 1) + (pixel_1 << 1) + (~pixel_2dd + 1) + (pixel_2);
		pixel_out_conv_horz_13 <= (~pixel0_dd + 1) + (~(pixel_0d << 1) + 1) + (~pixel_0 + 1) + (pixel_2dd) + (pixel_2d << 1) + (pixel_2);
		// Take the absolute value of the resulting filter convolution
		pixel_out_abs <= pixel_out_conv[11] ? (~pixel_out_conv + 1) : pixel_out_conv;

	end
end

   






endmodule

