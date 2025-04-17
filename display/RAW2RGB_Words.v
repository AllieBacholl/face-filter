module RAW2RGB_Words(
    output reg  [11:0] oRed,
    output reg  [11:0] oGreen,
    output reg  [11:0] oBlue,
    output reg         oDVAL,
    input       [10:0] iX_Cont,  // 0…1279
    input       [10:0] iY_Cont,  // 0…959
    input       [11:0] iDATA,    // unused
    input              iDVAL,    // pixel-valid from timing generator
    input              iCLK,
    input              iRST
);

  // ------------------------------------------------------------------
  // Parameters for centering a 10×10 image in 1280×960
  // ------------------------------------------------------------------
  localparam H_ACTIVE = 640;
  localparam V_ACTIVE =  480;
  localparam WIDTH    =   10;
  localparam HEIGHT   =   10;

  localparam X_START = (H_ACTIVE - WIDTH )/2;  // 635
  localparam Y_START = (V_ACTIVE - HEIGHT)/2;  // 475

 
  localparam NPIX = WIDTH * HEIGHT;  // 100

  reg [23:0] frame_buffer [0:NPIX-1];
//   initial $readmemh("image.hex", frame_buffer);




  wire in_frame = 
       (iX_Cont >= X_START) && (iX_Cont <  X_START + WIDTH)  &&
       (iY_Cont >= Y_START) && (iY_Cont <  Y_START + HEIGHT) &&
       iDVAL;

  // Compute local coords (0…9)
  wire [3:0] x_local = iX_Cont - X_START;
  wire [3:0] y_local = iY_Cont - Y_START;

  reg        in_frame_r;
  reg  [3:0] x_r, y_r;
  always @(posedge iCLK or negedge iRST) begin
    if (!iRST) begin
      in_frame_r <= 1'b0;
      x_r        <= 4'd0;
      y_r        <= 4'd0;
    end else begin
      in_frame_r <= in_frame;
      x_r        <= x_local;
      y_r        <= y_local;
    end
  end

  wire [6:0] addr = y_r * WIDTH + x_r;  // up to 100 entries → 7 bits
  reg  [23:0] pix_data;
  always @(posedge iCLK) begin
    // only valid when in_frame_r; out‑of‑frame reads same address but we’ll ignore data
    pix_data <= frame_buffer[addr];
  end

  always @(posedge iCLK or negedge iRST) begin
    if (!iRST) begin
      {oRed, oGreen, oBlue} <= 36'd0;
      oDVAL                 <= 1'b0;
    end else begin
      if (in_frame_r) begin
        // 8‑bit→12‑bit zero extension
        oRed   <= { pix_data[23:16], 4'b0000 };
        oGreen <= { pix_data[15: 8], 4'b0000 };
        oBlue  <= { pix_data[ 7: 0], 4'b0000 };
        oDVAL  <= 1'b1;
      end else begin
        oRed   <= 12'd0;
        oGreen <= 12'd0;
        oBlue  <= 12'd0;
        oDVAL  <= 1'b0;
      end
    end
  end

endmodule
