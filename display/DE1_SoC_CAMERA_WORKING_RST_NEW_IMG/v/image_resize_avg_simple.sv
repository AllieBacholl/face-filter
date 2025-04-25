module image_resize_avg_simple (
    input  wire        clk,        // Clock
    input  wire        rst_n,       // Active-low reset
    input  wire        KEY_2,           // Active-low key to start
    input  wire [7:0]  Read_DATA2,      // 8-bit pixel from SDRAM
    input  reg         tx_done,
    output reg         start_resize,    // Trigger SDRAM read
    output reg  [22:0] read_addr_resize, // SDRAM read address
    output reg         done,
    output reg  [7:0]  uart_tx,
    output  reg        uart_trmt
);

    // Output array: 32x32, 8-bit pixels
     // send counter: 0…1023
    reg [9:0] send_cnt;

    always_ff @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
        send_cnt   <= 10'd0;
        uart_tx    <= 8'd0;
        uart_trmt  <= 1'b0;
        done       <= 1'b0;
      end else if (triggered) begin
        if (!tx_done && send_cnt < 10'd1024) begin
          // drive uart_tx/trmt while UART is busy
          uart_tx   <= out[ send_cnt[9:5] ][ send_cnt[4:0] ];
          uart_trmt <= 1'b1;
        end else begin
          // deassert trmt
          uart_trmt <= 1'b0;
          if (tx_done) begin
            if (send_cnt == 10'd1023) begin
              done <= 1'b1;      // all 1024 bytes have been sent
            end else begin
              send_cnt <= send_cnt + 10'd1;
            end
          end
        end
      end
    end
    

    // Internal registers
    reg [31:0] pixel_sum;         // Accumulator for 20x15 block
    reg [4:0]  pixel_x;           // Pixel x in block (0 to 19)
    reg [3:0]  pixel_y;           // Pixel y in block (0 to 14)
    reg [5:0]  block_x, block_y;  // Block indices (0 to 31)
    reg        running;           // Process active flag
    reg        triggered;         // Tracks if KEY_2 has triggered

    // Main logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            start_resize <= 1'b0;
            read_addr_resize <= 23'd0;
            pixel_sum <= 32'd0;
            pixel_x <= 5'd0;
            pixel_y <= 4'd0;
            block_x <= 6'd0;
            block_y <= 6'd0;
            running <= 1'b0;
            triggered <= 1'b0; // Reset allows new trigger
            // Clear output array
            for (int i = 0; i < 32; i++) begin
                for (int j = 0; j < 32; j++) begin
                    out[i][j] <= 8'd0;
                end
            end
        end else begin
            if (!KEY_2 && !triggered && !running) begin
                // Start process only if not triggered before
                start_resize <= 1'b1;
                read_addr_resize <= 23'd0;
                pixel_sum <= 32'd0;
                pixel_x <= 5'd0;
                pixel_y <= 4'd0;
                block_x <= 6'd0;
                block_y <= 6'd0;
                running <= 1'b1;
                triggered <= 1'b1; // Prevent further triggers
            end else if (running) begin
                start_resize <= 1'b0; // Deassert after read
                pixel_sum <= pixel_sum + Read_DATA2; // Accumulate pixel
                if (pixel_x == 19 && pixel_y == 14) begin
                    // End of 20x15 block: compute and store average
                    out[block_y][block_x] <= pixel_sum / 300;
                    pixel_sum <= 32'd0;
                    pixel_x <= 5'd0;
                    pixel_y <= 4'd0;
                    if (block_x == 31 && block_y == 31) begin
                        // Done with all blocks
                        running <= 1'b0;
                    end else if (block_x == 31) begin
                        // Next row of blocks
                        block_x <= 6'd0;
                        block_y <= block_y + 1;
                        read_addr_resize <= (block_y + 1) * 15 * 640;
                    end else begin
                        // Next block in row
                        block_x <= block_x + 1;
                        read_addr_resize <= block_y * 15 * 640 + (block_x + 1) * 20;
                    end
                end else begin
                    // Next pixel in block
                    if (pixel_x == 19) begin
                        pixel_x <= 5'd0;
                        pixel_y <= pixel_y + 1;
                    end else begin
                        pixel_x <= pixel_x + 1;
                    end
                    read_addr_resize <= read_addr_resize + 1;
                    start_resize <= 1'b1; // Trigger next read
                end
            end
        end
    end

endmodule