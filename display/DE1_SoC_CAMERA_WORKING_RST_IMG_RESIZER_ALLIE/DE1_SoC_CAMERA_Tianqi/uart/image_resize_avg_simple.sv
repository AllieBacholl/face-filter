module image_resize_avg_simple (
    input  wire        clk,        // Clock
    input  wire        rst_n,       // Active-low reset
    input  wire        KEY_2,           // Active-low key to start
    input  wire [7:0]  Read_DATA2,      // 8-bit pixel from SDRAM
    input  reg         tx_done,
    output reg         read,    // Trigger SDRAM read
    output logic       start_resize,
    output reg  [22:0] read_addr_resize, // SDRAM read address
    output reg         done,
    output reg  [7:0]  uart_tx,
    output  reg        uart_trmt,
    output reg         avg_done,
    output reg        triggered
);

    integer i, j;
  
    logic valid;
    logic [6:0] counter_32;
    logic [4:0]  counter_20;
    logic [4:0] counter_15;

    logic [9:0] block_x, block_y;

    logic [16:0] sum_fly [0:31];

    logic [7:0] out [0:31][0:31];

    logic [15:0] valid_cnt;



  // send-FSM state
  typedef enum logic [1:0] {S_IDLE, S_START, S_WAIT, S_DONE} send_state_t;
  send_state_t send_state;

  // pointer 0…1023 into out[][]
  logic [9:0] send_ptr;  

// ────────────────────────────────────────────────────────────────────
//  3) The send-FSM: watches avg_done, then walks all 1 024 bytes.
// ────────────────────────────────────────────────────────────────────
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      send_state <= S_IDLE;
      send_ptr   <= 10'd0;
      uart_trmt  <= 1'b0;
      uart_tx    <= 8'd0;
      done       <= 1'b0;
    end
    else begin
      case (send_state)
        S_IDLE: begin
          if (avg_done) begin
            send_ptr   <= 10'd0;
            send_state <= S_START;
          end
        end

        S_START: begin
          // drive the next byte and pulse trmt for 1 cycle
          uart_tx    <= out[send_ptr[4:0]][send_ptr[9:5]];
          uart_trmt  <= 1'b1;
          send_state <= S_WAIT;
        end

        S_WAIT: begin
          uart_trmt <= 1'b0;              // only 1-cycle pulse
          if (tx_done) begin              // UART says “I’m done”
            if (send_ptr == 10'd1023) begin
              send_state <= S_DONE;
            end else begin
              send_ptr   <= send_ptr + 1;
              send_state <= S_START;
            end
          end
        end

        S_DONE: begin
          done <= 1'b1;                   // final output flag
        end

      endcase
    end
  end


 always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    // --- reset everything ---
    valid_cnt <= 0;
    start_resize      <= 1'b0;
    read              <= 1'b0;
    read_addr_resize  <= 23'd0;
    counter_20        <= 5'd0;    // 0…19
    counter_32        <= 7'd0;    // 0…31
    counter_15        <= 5'd0;    // 0…14
    valid             <= 1'b0;
    // clear sums
    sum_fly           <= '{default:'0};
  end
  else if (!KEY_2) begin
    // launch resize
    start_resize      <= 1'b1;
    
  end
  else if (start_resize & ~avg_done) begin
    read              <= 1'b1;
    // accumulate into the current horizontal‐block index
    sum_fly[counter_32]     <= sum_fly[counter_32] + Read_DATA2;
    read_addr_resize        <= read_addr_resize + 1;
    valid                    <= 1'b0;  // default

    // --- nested counters ---
    if (counter_20 == 5'd19) begin
      // end of a 20-pixel span → wrap X
      counter_20 <= 5'd0;

      if (counter_32 == 7'd31) begin
        // end of 32 blocks in a row → wrap block index
        counter_32 <= 7'd0;

        if (counter_15 == 5'd14) begin
          // end of 15 rows in a block → wrap Y
          counter_15 <= 5'd0;
        end else begin
          counter_15 <= counter_15 + 5'd1;
        end
      end else begin
        counter_32 <= counter_32 + 7'd1;
      end
    end else begin
      // keep stepping through the 20 pixels
      counter_20 <= counter_20 + 5'd1;
    end

    // assert valid for exactly one cycle, when the last pixel
    // (20th in X and 15th in Y) of a block has just been summed
    if (counter_20 == 5'd19 && counter_15 == 5'd14) begin
      valid <= 1'b1;
      valid_cnt <= valid_cnt + 1;
    end else begin
      valid <= 1'b0;
    end
  end
  else begin
    read <= 1'b0;
    start_resize <= 0;
  end
end


always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    // --- reset all indices & flag ---
    block_x    <= 5'd0;
    block_y    <= 5'd0;
    avg_done   <= 1'b0;

    // --- clear out[32][32] ---
    for (i = 0; i < 32; i = i + 1)
      for (j = 0; j < 32; j = j + 1)
        out[i][j] <= '0;

  end
  else if (valid) begin
    // --- write one averaged value per cycle ---
    out[block_x][block_y]<= sum_fly[counter_32] / 300;

    // --- advance X, wrap to next row when X hits 31 ---
    if (block_x == 5'd31) begin
      block_x <= 5'd0;
      // --- last column: advance Y (or finish) ---
      if (block_y == 5'd31) begin
        block_y  <= 5'd0;
        avg_done <= 1'b1;
      end else begin
        block_y <= block_y + 5'd1;
      end
    end else begin
      block_x <= block_x + 5'd1;
    end
  end
  // else: when valid==0, indices and avg_done just hold their values
end


endmodule