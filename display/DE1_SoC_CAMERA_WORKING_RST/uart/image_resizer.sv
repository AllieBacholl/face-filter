module image_resizer (
    input              clk,            // Clock
    input              rst_n,         // Active low reset
    input              start,         // High when pix_* inputs are valid
    input      [7:0]   pix_color_in,  // 8-bit pixel color input
    input     [10:0]   pix_haddr,     // Pixel column address (0 to 1279)
    input      [9:0]   pix_vaddr,     // Pixel row address (0 to 959)
    output reg         sram_wr,        // SRAM write enable strobe
    output reg  [7:0]  pix_color_out, // Averaged 8-bit pixel color output
    output reg  [9:0]  compress_addr  // Compressed pixel address (0 to 1023)
);

    // Parameters
    localparam OUT_W     = 32,           // Output width (32 pixels)
               OUT_H     = 32,           // Output height (32 pixels)
               BLOCK_W   = 40,           // Block width (1280/32 = 40 pixels)
               BLOCK_H   = 30,           // Block height (960/32 = 30 pixels)
               NUM_BLK   = 1024,// Total blocks (32*32 = 1024)
               DIV_CONST = 1200; // Pixels per block (40*30 = 1200)

    // Internal signals
    reg [18:0] block_mem [0:NUM_BLK-1];  // Memory for block sums (19 bits for 1200*255)
    reg [18:0] accum;                    // Accumulated sum for current block
    reg [4:0]  b_haddr;                  // Block column address (0 to 31)
    reg [4:0]  b_vaddr;                  // Block row address (0 to 31)
    reg [9:0]  block_idx;                // Block index (0 to 1023)
    reg        we;                       // Write enable for block memory
    reg        clr_block;                // Clear block sum at start of new block
    wire [18:0] block_out;               // Current block sum from memory

    // Block address calculation
    assign b_haddr = pix_haddr[10:6];    // Divide by 40 (1280/32 = 40, right shift by ~5.32, use 6 bits)
    assign b_vaddr = pix_vaddr[9:5];     // Divide by 30 (960/32 = 30, right shift by ~4.91, use 5 bits)
    assign block_idx = (b_vaddr << 5) + b_haddr; // Linear block index

    // Write enable: disable when addresses are at max to avoid out-of-bounds
    assign we = (pix_haddr < 1280) & (pix_vaddr < 960);

    // Clear block sum at the start of a new block (when pixel address is at block boundary)
    assign clr_block = (pix_haddr[5:0] == 6'd0) & (pix_vaddr[4:0] == 5'd0);

    // Block memory output: clear or read from memory
    assign block_out = clr_block ? 19'd0 : block_mem[block_idx];

    // Accumulator: Compute new sum and store it
    always @(posedge clk) begin
        if (!rst_n) begin
            accum <= 19'd0;
        end else if (we) begin
            if (clr_block) begin
                accum <= {11'd0, pix_color_in}; // Start new block
            end else begin
                accum <= accum + {11'd0, pix_color_in}; // Add to previous sum
            end
        end
    end

    // Block memory update
    integer i;
    always @(posedge clk) begin
        if (!rst_n) begin
            for (i = 0; i < NUM_BLK; i = i + 1) begin
                block_mem[i] <= 19'd0; // Reset all block sums
            end
        end else if (we && !clr_block) begin
            block_mem[block_idx] <= accum; // Store previous accum value
        end
    end

    // SRAM write enable: trigger at end of block (last pixel in 40x30 block)
    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            sram_wr <= 1'b0;
        end else begin
            sram_wr <= we & (pix_haddr[5:0] == 6'd39) & (pix_vaddr[4:0] == 5'd29) & 
                       (compress_addr < 1024);
        end
    end

    // Compressed address counter
    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            compress_addr <= 10'd1024; // Initialize to invalid address
        end else if (start) begin
            compress_addr <= 10'd0;    // Reset to 0 on start
        end else if (sram_wr) begin
            compress_addr <= compress_addr + 10'd1; // Increment on write
        end
    end

    // Output averaged pixel color
    always @(posedge clk) begin
        if (sram_wr) begin
            pix_color_out <= accum / DIV_CONST; // Divide by 1200
        end
    end

endmodule