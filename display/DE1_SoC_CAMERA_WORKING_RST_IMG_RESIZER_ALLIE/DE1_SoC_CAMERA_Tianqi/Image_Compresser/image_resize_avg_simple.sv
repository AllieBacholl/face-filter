module image_resize_avg_simple (
    input  wire        clk,        // Clock
    input  wire        rst_n,       // Active-low reset
    input  wire        KEY_2,           // Active-low key to start
    input  wire [12:0]  Read_DATA2,      // 8-bit pixel from SDRAM
    input  reg         tx_done,
    output reg         start_resize,    // Trigger SDRAM read
    output reg  [22:0] read_addr_resize, // SDRAM read address
    output reg         done,
    output reg  [7:0]  uart_tx,
    output  reg        uart_trmt,
    output reg         avg_done,
    output reg        triggered
);

    // Output array: 32x32, 8-bit pixels
     // send counter: 0…1023
    reg [9:0] send_cnt;

    reg [7:0] out [0:31][0:31];
    reg [7:0] receive [0:480-1][0:640-1];

        // Internal registers
    reg [31:0] pixel_sum;         // Accumulator for 20x15 block
    reg [9:0]  pixel_x;           // Pixel x in block (0 to 19)
    reg [8:0]  pixel_y;           // Pixel y in block (0 to 14)
    reg [5:0]  block_x, block_y;  // Block indices (0 to 31)
    reg        running;           // Process active flag
             // Tracks if KEY_2 has triggered
    reg        receiving;
        // edge-detect helper and done flag
    reg prev_triggered;
    


reg tx_done_prev;
// always_ff @(posedge clk or negedge rst_n) begin
//     if (!rst_n) begin
//         send_cnt     <= 10'd0;
//         uart_tx      <= 8'd0;
//         uart_trmt    <= 1'b0;
//         done         <= 1'b0;
//         tx_done_prev <= 1'b0;
//     end else if (avg_done) begin
//         tx_done_prev <= tx_done;  // Track previous tx_done
//         if (tx_done && send_cnt < 10'd1024) begin
//             uart_tx   <= out[send_cnt[9:5]][send_cnt[4:0]];
//             uart_trmt <= 1'b1;
//         end else begin
//             uart_trmt <= 1'b0;
//             if (tx_done && !tx_done_prev) begin  // Rising edge of tx_done
//                 if (send_cnt == 10'd1023) begin
//                     done <= 1'b1;
//                 end else begin
//                     send_cnt <= send_cnt + 10'd1;
//                 end
//             end
//         end
//     end
// end

    //========================================================================
    // Byte-by-byte UART send FSM
    //========================================================================
        // at module scope
    typedef enum logic [1:0] {S_IDLE, S_WAIT} send_state_t;
    send_state_t   send_state;
    reg            prev_avg_done;

    always_ff @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
        send_state    <= S_IDLE;
        prev_avg_done <= 1'b0;
        tx_done_prev  <= 1'b0;
        send_cnt      <= 10'd0;
        done          <= 1'b0;
        uart_trmt     <= 1'b0;
      end else begin
        // remember last cycle’s avg_done & tx_done
        prev_avg_done <= avg_done;
        tx_done_prev  <= tx_done;

        case (send_state)
          // ————————————————————————————————————————————————
          // IDLE: trigger first byte on the rising edge of avg_done
          // ————————————————————————————————————————————————
          S_IDLE: begin
            done      <= 1'b0;
            uart_trmt <= 1'b0;
            if (avg_done && !prev_avg_done) begin
              send_cnt  <= 10'd0;
              uart_tx   <= out[0][0];
              uart_trmt <= 1'b1;       // start first byte
              send_state <= S_WAIT;
            end
          end

          S_WAIT: begin
            uart_trmt <= 1'b0;        // only pulse for 1 cycle

            // on rising edge of tx_done
            if (!tx_done_prev && tx_done) begin
              if (send_cnt == 10'd1023) begin
                done       <= 1'b1;
                send_state <= S_IDLE;
              end else begin
                send_cnt  <= send_cnt + 1;
                // load the next byte
                uart_tx   <= out[(send_cnt+1)>>5][(send_cnt+1)&5'h1F];
                uart_trmt <= 1'b1;
                // stay in WAIT and wait for next tx_done↑
              end
            end
          end

          default: send_state <= S_IDLE;
        endcase
      end
    end


    // Main logic
        always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin

        for (integer i = 0; i < 480; i++) begin
          for (integer j = 0; j < 640; j++) begin
              receive[i][j] <= 8'd0;
          end
            end
        for (integer i = 0; i < 32; i++) begin
            for (integer j = 0; j < 32; j++) begin
                out[i][j] <= 8'd0;
            end
        end
                // -- reset all state
            pixel_x    <= 10'd0;
            pixel_y    <=  9'd0;
            receiving  <=  1'b0;
            triggered  <=  1'b0;
            start_resize <= 1'b0;
            read_addr_resize <= 23'd0;
        end else begin
            // -- start capture on key press (only once per reset)
            if (!KEY_2 && !triggered) begin
                receiving  <= 1'b1;   // begin capturing
                pixel_x    <= 10'd0;  // first column
                pixel_y    <=  9'd0;  // first row
                start_resize <= 1'b1;
            end
            // -- while receiving, store each pixel row‐by‐row
            else if (receiving) begin
                // store the incoming byte at [current row][current col]
                if(!triggered) begin
                 read_addr_resize <= read_addr_resize + 1;
                end else begin
                 read_addr_resize <= 23'd0;
                end
                receive[pixel_y][pixel_x] <= Read_DATA2;

                // advance to next column
                if (pixel_x == 10'd639) begin
                    // end of row: wrap column and advance row
                    pixel_x <= 10'd0;
                    if (pixel_y == 9'd479) begin
                        // last pixel of the last row:
                        receiving <= 1'b0;   // done capturing
                        triggered <= 1'b1;   // signal full frame ready
                        pixel_y   <= 9'd0;   // reset for next time
                        read_addr_resize <= 23'd0;
                    end else begin
                        // move to the next row
                        pixel_y <= pixel_y + 1;
                       
                    end
                end else begin
                    // still within the same row: next column
                    pixel_x <= pixel_x + 1;
                    
                end
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            prev_triggered <= 1'b0;
            avg_done       <= 1'b0;
        end else begin
            // remember last cycle’s triggered
            prev_triggered <= triggered;

            // on rising edge of triggered, compute all 32×32 averages
            if (triggered && !prev_triggered) begin
                integer by, bx, py, px;
                reg [31:0] sum;

                // for each 20×15 block (32 rows × 32 cols)
                for (by = 0; by < 32; by = by + 1) begin
                    for (bx = 0; bx < 32; bx = bx + 1) begin
                        sum = 0;
                        // sum the 300 pixels in this block
                        for (py = 0; py < 15; py = py + 1) begin
                            for (px = 0; px < 20; px = px + 1) begin
                                sum = sum + receive[by*15 + py][bx*20 + px];
                            end
                        end
                        // divide by 300 and store result
                        out[by][bx] <= sum / 300;
                    end
                end

                // mark completion
                avg_done <= 1'b1;
            end
            // clear done when starting a new frame
            else if (!triggered) begin
                avg_done <= 1'b0;
            end
        end
    end

endmodule