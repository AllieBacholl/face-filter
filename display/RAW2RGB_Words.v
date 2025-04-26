module RAW2RGB_Words(
    output reg  [11:0] oRed,
    output reg  [11:0] oGreen,
    output reg  [11:0] oBlue,
    output reg         oDVAL,
    input       [10:0] iX_Cont,   // 0…639
    input       [10:0] iY_Cont,   // 0…479
    input       [11:0] iDATA,     // we’ll use iDATA[7:0] for loader
    input              iDVAL,     // strobe for both load & display
    input              iCLK,
    input              iRST       // active‐low reset
);

  // ---------------------------------------------------
  // 1) Parameters for centering a 10×10 in 640×480
  // ---------------------------------------------------
  localparam H_ACTIVE = 640;
  localparam V_ACTIVE = 480;
  localparam WIDTH    = 10;
  localparam HEIGHT   = 10;
  localparam X_START  = (H_ACTIVE - WIDTH )/2;  // =315
  localparam Y_START  = (V_ACTIVE - HEIGHT)/2;  // =235
  localparam NPIX     = WIDTH * HEIGHT;         // 100

  // ---------------------------------------------------
  // 2) Frame buffer: 100 entries of 24 bit
  // ---------------------------------------------------
  reg [23:0] frame_buffer [0:NPIX-1];

  // ---------------------------------------------------
  // 3) Loader state (before load_done=1)
  //    - uses iDVAL as load enable
  //    - uses iDATA[7:0] as incoming R/G/B bytes
  // ---------------------------------------------------
  reg [8:0]  load_cnt;     // 0…299
  reg [1:0]  byte_offset;  // 0→R,1→G,2→B
  reg [6:0]  load_pix;     // 0…99
  reg        load_done;

  always @(posedge iCLK or negedge iRST) begin
    if (!iRST) begin
      load_cnt    <= 0;
      byte_offset <= 0;
      load_pix    <= 0;
      load_done   <= 1'b0;
    end
    else if (iDVAL && !load_done) begin
      // capture next byte
      case (byte_offset)
        2'd0: frame_buffer[load_pix][23:16] <= iDATA[7:0]; // Red
        2'd1: frame_buffer[load_pix][15: 8] <= iDATA[7:0]; // Green
        2'd2: frame_buffer[load_pix][ 7: 0] <= iDATA[7:0]; // Blue
      endcase

      // advance counters
      byte_offset <= byte_offset + 1;
      if (byte_offset == 2) begin
        byte_offset <= 0;
        load_pix    <= load_pix + 1;
      end

      load_cnt <= load_cnt + 1;
      if (load_cnt == NPIX*3 - 1)
        load_done <= 1'b1;
    end
  end

  // ---------------------------------------------------
  // 4) Display logic: only after load_done
  // ---------------------------------------------------
  // detect centered window & valid strobe
  wire in_frame = load_done &&
                   (iX_Cont >= X_START) && (iX_Cont <  X_START + WIDTH)  &&
                   (iY_Cont >= Y_START) && (iY_Cont <  Y_START + HEIGHT) &&
                   iDVAL;

  // local (0…9) coords
  wire [3:0] x_local = iX_Cont - X_START;
  wire [3:0] y_local = iY_Cont - Y_START;

  // pipeline one cycle for BRAM latency
  reg        in_frame_r;
  reg  [3:0] x_r, y_r;
  always @(posedge iCLK or negedge iRST) begin
    if (!iRST) begin
      in_frame_r <= 1'b0;
      x_r        <= 0;
      y_r        <= 0;
    end else begin
      in_frame_r <= in_frame;
      x_r        <= x_local;
      y_r        <= y_local;
    end
  end

  // fetch pixel data (one‐cycle BRAM read)
  wire [6:0] addr = y_r * WIDTH + x_r;  // 0…99
  reg  [23:0] pix_data;
  always @(posedge iCLK) begin
    pix_data <= frame_buffer[addr];
  end

  // final output: zero‐extend 8→12 bits or black
  always @(posedge iCLK or negedge iRST) begin
    if (!iRST) begin
      {oRed, oGreen, oBlue} <= 36'd0;
      oDVAL                 <= 1'b0;
    end else if (in_frame_r) begin
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

endmodule
