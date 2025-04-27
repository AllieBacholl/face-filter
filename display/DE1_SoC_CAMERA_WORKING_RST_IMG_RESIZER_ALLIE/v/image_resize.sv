module image_resize (
    input              clk,           // Clock
    input              rst_n,         // Active low reset
    input              iStart,         // High when picture taken
    input       [7:0]  iPix,           // 8-bit pixel grayscale input
    output reg         oSdramRd,       // SDRAM read enable strobe
    output reg  [22:0] oSdramAddr,     // SDRAM read address
    output reg         oSdramWr,       // SDRAM write enable strobe
    output reg  [7:0]  oPix,           // Averaged 8-bit pixel grayscale output
    output reg         oResizeValid
);

parameter          BASE_ADDR     = 0;
parameter          STRIDE        = 640;     // 640 pixels per horizontal line
parameter          COLUMN_WIDTH  = 20;      // Save 20 Horizontal Pixels
parameter          ROW_WIDTH     = 15;      // Save 15 Vertical Pixels

reg        [9:0] vPixCnt; // Count of the amount of vertical pixels (up to 15)
reg        [9:0] hPixCnt; // Count of the amount of horizontal pixels (up to 20)
reg        [9:0] vPixCntResize; // Count of the amount of vertical pixels (up to 32)
reg        [9:0] hPixCntResize; // Count of the amount of horizontal pixels (up to 32)
reg        [9:0] vWriteCnt; // Count of the amount of vertical pixels written out (up to 32)
reg        [9:0] hWriteCnt; // Count of the amount of horizontal pixels written out (up to 32)
reg       [22:0] currBaseAddrV;
reg       [22:0] currBaseAddrH;

reg        [15:0] sum;

// 32 x 32 resized image
reg        	[7:0] pixelsResize [0:31] [0:31];

logic                read;
logic                write;
logic                newLine;
logic                done;
logic                doneResize;
logic                hPixCntResizeInc; 
logic                vPixCntResizeInc; 
logic                setResizeValid;
logic					  	setPixel;

// Resize Pixel Count control
always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        vPixCntResize <= 10'h000;
    end else if (vPixCntResizeInc) begin
		  if (vPixCntResize >= 10'd31) begin
            vPixCntResize <= 10'h000;
        end else begin
            vPixCntResize <= vPixCntResize + 1'b1;
        end
	 end
end

always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        hPixCntResize <= 10'h000;
	 end else if (hPixCntResizeInc) begin
        if (hPixCntResize >= 10'd31) begin
            hPixCntResize <= 10'h000;
        end else begin
            hPixCntResize <= hPixCntResize + 1'b1;
        end
    end 
end

// Write to resize image
always_ff @(posedge clk) begin
    if (write) begin
        oPix <= sum/300;
	 end else begin
		  oPix <= 8'hAA;
	 end
end

// Output read control
always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        oSdramRd <= 1'b0;
    end else if (read) begin
        oSdramRd <= 1'b1;
    end else begin
        oSdramRd <= 1'b0;
    end
end
    
// Output write control
always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        oSdramWr <= 1'b0;
    end else if (write) begin
        oSdramWr <= 1'b1;
    end else begin
        oSdramWr <= 1'b0;
    end
end

// Output valid control
always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        oResizeValid <= 1'b0;
    end else if (setResizeValid) begin
        oResizeValid <= 1'b1;
    end else begin
        oResizeValid <= 1'b0;
    end
end

// Write Data Control
always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        vWriteCnt <= 1'b0;
        hWriteCnt <= 1'b0;
    end else if (oSdramWr) begin
        if (hWriteCnt >= 10'd31) begin
            hWriteCnt <= 10'h000;
            if (vWriteCnt >= 10'd31) begin
                vWriteCnt <= 10'h000;
            end else begin
                vWriteCnt <= vWriteCnt + 1'b1;
            end
        end else begin
            hWriteCnt <= hWriteCnt + 1'b1;
        end

    end else begin
        hWriteCnt <= 10'd0;
        vWriteCnt <= 10'd0;
    end
end

// Address Control
always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        oSdramAddr <= BASE_ADDR;
        currBaseAddrV <= BASE_ADDR;
        currBaseAddrH <= BASE_ADDR;
        vPixCnt <= 10'h000;
    end else if (done) begin
        if (hPixCntResize == 10'd31) begin
            currBaseAddrV <= currBaseAddrV + (15*STRIDE);
            oSdramAddr <= currBaseAddrV + (15*STRIDE);
            currBaseAddrH <= 23'h0000;
        end else begin
            currBaseAddrH <= currBaseAddrH + 20;
            oSdramAddr <= currBaseAddrH + currBaseAddrV + 20;
        end
        vPixCnt <= 1'b0;
    end else if (oSdramRd & newLine) begin
        oSdramAddr <= oSdramAddr + STRIDE;
        if (vPixCnt >= ROW_WIDTH-1) begin
            vPixCnt <= 1'b0;
        end else begin
            vPixCnt <= vPixCnt + 1'b1;
        end
    end 
end

// Store the data read from SDRAM
always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        hPixCnt <= 1'b0;
		sum <= 9'h000;
    end else if (oSdramRd) begin
		  // Take the average of the values
          if (hPixCnt == 0 & vPixCnt == 0) begin
                sum <= {1'b0, iPix};
          end else begin
            	sum <= sum + iPix;
          end
        // Reset horizontal count once it equals 19
        if (hPixCnt >= COLUMN_WIDTH-1) begin
            hPixCnt <= 1'b0;
        end else begin
            hPixCnt <= hPixCnt + 1'b1;
        end
    end 
end

// State Machine
typedef enum reg [1:0] {IDLE, READ, RESIZE, DONE} state_t;
state_t state, nxt_state;

//  State machine   //
    always_ff @(posedge clk, negedge rst_n)
        if (!rst_n)
            state <= IDLE;
        else
            state <= nxt_state;

always_comb begin
    // Set default values
    nxt_state = state;
    read = 1'b0;
    newLine = 1'b0;
    done = 1'b0;
    doneResize = 1'b0;
    hPixCntResizeInc = 1'b0;
    vPixCntResizeInc = 1'b0;
    write = 1'b0;
    setResizeValid = 1'b0;
	 setPixel = 1'b0;

    case (state)
        // Picture Taken
        IDLE: begin
            if (iStart) begin
                nxt_state = READ;
            end
        end
        
		READ: begin
            read = 1'b1;
            // Got 20 horizontal pixels
            if (hPixCnt >= COLUMN_WIDTH-1) begin
                newLine = 1'b1;
            end
            // Done once we get 15 rows
            if (vPixCnt >= ROW_WIDTH-1 & hPixCnt >= COLUMN_WIDTH-1) begin
                done = 1'b1;
                read = 1'b0;
                nxt_state = RESIZE;
            end
        end

        RESIZE: begin
            // Write pixels out
				write = 1'b1;
            hPixCntResizeInc = 1'b1;
            if (hPixCntResize == 10'd31) begin
                vPixCntResizeInc = 1'b1;
                if (vPixCntResize == 10'd31) begin
                    doneResize = 1'b1;
                    nxt_state = DONE;
                end else begin
                    nxt_state = READ;
                end
            end else begin
                nxt_state = READ;
            end
            
        end

        DONE: begin
            setResizeValid = 1'b1;
            nxt_state = IDLE;
        end
    endcase
end

endmodule