
// image_resizer_12bit_shift.v
// Description:
//   This module accepts a 1280x960 12-bit pixel stream (with valid signal),
//   decimates the image to a 32x32 sample (picking every 40th pixel horizontally and
//   every 30th pixel vertically) using simple counters rather than divisions,
//   and then pads the 32x32 block with a one-pixel border (zeros) to produce a 34x34 image.

module image_resizer_12bit(
    input  wire         clk,
    input  wire         rst,
    input  wire [11:0]  pixel_in,
    input  wire         valid_in,
    output reg  [11:0]  pixel_out,
    output reg          valid_out
);

    parameter IN_WIDTH  = 1280;
    parameter IN_HEIGHT = 960;
    parameter IMG_DIM   = 32;
    parameter PAD_DIM   = 34;

    // Hard-coded decimation factors
    // Use shift by log2(IMG_DIM) instead of division
    localparam IMG_SHIFT = 5;  // log2(IMG_DIM=32)
    localparam X_SCALE  = IN_WIDTH  >> IMG_SHIFT;  // 1280 >> 5 = 40
    localparam Y_SCALE  = IN_HEIGHT >> IMG_SHIFT;  // 960  >> 5 = 30

    // Counters for full image position
    reg [10:0] full_x, full_y;

    // Decimation counters (no divide/mod)
    reg [5:0] dec_x;  // 0..39
    reg [4:0] dec_y;  // 0..29

    // Capture block indices
    reg [5:0] cap_row, cap_col;
    reg [1:0] state;
    localparam STATE_CAPTURE        = 2'd0;
    localparam STATE_OUTPUT_PAD_TOP = 2'd1;
    localparam STATE_OUTPUT_DATA    = 2'd2;
    localparam STATE_OUTPUT_PAD_BOT = 2'd3;

    // RAM for 32x32 block
    reg [11:0] mem [0:IMG_DIM-1][0:IMG_DIM-1];

    // Output counters
    reg [5:0] out_row, out_col;

    // Line buffer IP
    wire [11:0] lb_pixel;
    wire        lb_valid;
    

    //-------------------------------------------------------------------------
    // Line-buffer for pixel and valid pipeline alignment (one-line delay)
    //-------------------------------------------------------------------------
    wire [11:0] lb_pixel;
    wire        lb_valid;
    // Pixel line buffer (depth = IN_WIDTH)
    Line_Buffer1 lb_pix_inst (
        .clock   (clk),
        .clken   (valid_in),
        .shiftin (pixel_in),
        .shiftout(),       // unused
        .taps0x (lb_pixel),
        .taps1x ()         // unused
    );
    // Valid-line buffer (1-bit depth)
    // shifts a '1' on each valid_in to produce delayed valid signal
    Line_Buffer1 #(.WIDTH(1), .DEPTH(IN_WIDTH)) lb_valid_inst (
        .clock   (clk),
        .clken   (valid_in),
        .shiftin (1'b1),
        .shiftout(),       // unused
        .taps0x (lb_valid),
        .taps1x ()         // unused
    );

Line_Buffer1 lb_inst (
    .clock   (clk),       // system clock
    .clken   (valid_in),  // enable when input pixel is valid
    .shiftin (pixel_in),  // input pixel
    .shiftout(),          // unused
    .taps0x(),            // first tap (unused)
    .taps1x (lb_pixel)    // delayed-by-one-line pixel
);


    // Full-frame counters
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            full_x <= 0; full_y <= 0;
        end else if (lb_valid && state == STATE_CAPTURE) begin
            if (full_x == IN_WIDTH-1) begin
                full_x <= 0;
                full_y <= (full_y == IN_HEIGHT-1) ? 0 : full_y + 1;
            end else
                full_x <= full_x + 1;
        end
    end

    // Decimation counters
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            dec_x <= 0; dec_y <= 0;
        end else if (lb_valid && state == STATE_CAPTURE) begin
            if (dec_x == X_SCALE-1) begin
                dec_x <= 0;
                dec_y <= (dec_y == Y_SCALE-1) ? 0 : dec_y + 1;
            end else begin
                dec_x <= dec_x + 1;
            end
        end
    end

    // Sample condition
    wire sample_pixel = (dec_x == 0) && (dec_y == 0);

    // Capture FSM
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cap_row <= 0; cap_col <= 0;
            state   <= STATE_CAPTURE;
        end else if (state == STATE_CAPTURE && lb_valid && sample_pixel) begin
            mem[cap_row][cap_col] <= lb_pixel;
            if (cap_col == IMG_DIM-1) begin
                cap_col <= 0;
                if (cap_row == IMG_DIM-1) begin
                    state   <= STATE_OUTPUT_PAD_TOP;
                    out_row <= 0; out_col <= 0;
                end else begin
                    cap_row <= cap_row + 1;
                end
            end else begin
                cap_col <= cap_col + 1;
            end
        end
    end

    // Output FSM (padding + data)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state     <= STATE_CAPTURE;
            valid_out <= 0;
            pixel_out <= 0;
            out_row   <= 0; out_col <= 0;
            // reset full-frame & capture indices
            full_x <= 0; full_y <= 0;
            cap_row <= 0; cap_col <= 0;
        end else begin
            case (state)
                // Top pad
                STATE_OUTPUT_PAD_TOP: begin
                    valid_out <= 1; pixel_out <= 0;
                    out_col <= out_col + 1;
                    if (out_col == PAD_DIM-1) begin
                        state   <= STATE_OUTPUT_DATA;
                        out_row <= 0; out_col <= 0;
                    end
                end
                // Data rows
                STATE_OUTPUT_DATA: begin
                    valid_out <= 1;
                    if (out_col == 0) begin
                        pixel_out <= 0; out_col <= 1;
                    end else if (out_col == PAD_DIM-1) begin
                        pixel_out <= 0;
                        out_col   <= 0;
                        out_row   <= out_row + 1;
                        if (out_row == IMG_DIM) state <= STATE_OUTPUT_PAD_BOT;
                    end else begin
                        pixel_out <= mem[out_row][out_col-1];
                        out_col   <= out_col + 1;
                    end
                end
                // Bottom pad
                STATE_OUTPUT_PAD_BOT: begin
                    valid_out <= 1; pixel_out <= 0;
                    out_col <= out_col + 1;
                    if (out_col == PAD_DIM-1) begin
                        state   <= STATE_CAPTURE;
                        // re-init for next frame
                        full_x <= 0; full_y <= 0;
                        cap_row <= 0; cap_col <= 0;
                        out_col <= 0;
                    end
                end
            endcase
        end
    end

endmodule
