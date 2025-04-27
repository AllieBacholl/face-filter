`timescale 1ns/1ps

module tb_image_resize_avg_simple;

  // ----------------------------------------------------------------
  // DUT Interface signals
  // ----------------------------------------------------------------
  reg         clk;
  reg         rst_n;
  reg         KEY_2;
  reg  [7:0]  Read_DATA2;
  reg         tx_done;
  reg        read;
  wire        start_resize;
  wire [22:0] read_addr_resize;
  wire        done;
  wire [7:0]  uart_tx;
  wire        uart_trmt;
  wire        avg_done;
  wire        triggered;

  // ----------------------------------------------------------------
  // Instantiate DUT
  // ----------------------------------------------------------------
  image_resize_avg_simple dut (
    .clk              (clk),
    .rst_n            (rst_n),
    .KEY_2            (KEY_2),
    .Read_DATA2       (Read_DATA2),
    .tx_done          (tx_done),
    .read             (read),
    .start_resize     (start_resize),
    .read_addr_resize (read_addr_resize),
    .done             (done),
    .uart_tx          (uart_tx),
    .uart_trmt        (uart_trmt),
    .avg_done         (avg_done),
    .triggered        (triggered)
  );


  uart_tx uart0 (
    .clk      (clk),
    .rst_n    (rst_n),
    .trmt     (uart_trmt),
    .tx_data  (uart_tx),
    .TX       (TX),
    .tx_done  (tx_done)       // feeds back into our FSM
  );


  // ----------------------------------------------------------------
  // Clock generator: 50 MHz → 20 ns period
  // ----------------------------------------------------------------
  initial clk = 1'b0;
  always #10 clk = ~clk;

  // ----------------------------------------------------------------
  // Test‐image memory: 480×640 = 307200 pixels
  // Fill with a simple ramp pattern: pixel = address[7:0]
  // ----------------------------------------------------------------
  reg [7:0] tb_img [0:480*640-1];
  integer i;
  initial begin
    for (i = 0; i < 480*640; i = i + 1)
      tb_img[i] = i[7:0];
  end

  // ----------------------------------------------------------------
  // Reset / start pulse
  // ----------------------------------------------------------------
  initial begin
    // initialize
    rst_n      = 1'b0;
    KEY_2      = 1'b1;
    Read_DATA2 = 8'd0;
    tx_done    = 1'b0;
    #100;

    // release reset
    rst_n = 1'b1;
    #100;

    // pulse KEY_2 low for one cycle to start resize
    KEY_2 = 1'b0;
    #20;
    KEY_2 = 1'b1;

    @(posedge done);
    $finish;
  end

  // ----------------------------------------------------------------
  // Feed pixel data whenever DUT asserts `read`
  // ----------------------------------------------------------------
  always @(posedge clk) begin
    if (start_resize) begin
      Read_DATA2 <= tb_img[ read_addr_resize ];
    end
  end

  // ----------------------------------------------------------------
  // When DUT signals done, check all averages and finish
  // ----------------------------------------------------------------
//  always @(avg_done) begin
//   if (avg_done) begin
//     check_averages();
//     $finish;
//   end
// end

initial begin
    // Print a header once
    $display("  Time    counter_32   counter_20   counter_15");
    $display("------------------------------------------------");
end

// // Monitor the three signals on any change
// always @(dut.counter_32 or dut.counter_20 or dut.counter_15 or dut.valid) begin
//     $display("%0t     %0d            %0d            %0d     %0d",
//              $time,
//              dut.counter_32,
//              dut.counter_20,
//              dut.counter_15,
//              dut.valid);
// end

// Monitor the three signals on any change
always @(dut.uart_trmt) begin
    $display("%0t     %0d  send_ptr",
             $time,
           
             dut.send_ptr);
end

  // ----------------------------------------------------------------
  // Task: recompute each 20×15 block’s average and compare
  // ----------------------------------------------------------------
  task automatic check_averages;
    integer by, bx, py, px;
    integer row, col, idx;
    reg [16:0] sum;
    reg [7:0]  expected;
  begin
    $display("\nChecking 32×32 averaged blocks…");
    for (by = 0; by < 32; by = by + 1) begin         // vertical block
      for (bx = 0; bx < 32; bx = bx + 1) begin       // horizontal block
        sum = 0;
        // accumulate 15 rows × 20 cols within this block
        for (py = 0; py < 15; py = py + 1) begin
          for (px = 0; px < 20; px = px + 1) begin
            row = by*15 + py;
            col = bx*20 + px;
            idx = row*640 + col;                     // flatten 2D → 1D
            sum = sum + tb_img[idx];
          end
        end
        expected = sum / 300;                        // 20×15 = 300 pixels
        // if (dut.out[bx][by] !== expected) begin
        //   $display("  ERROR out[%0d][%0d]: exp=%0d  got=%0d",
        //            bx, by, expected, dut.out[bx][by]);
        // end else begin
        //   $display("  PASS  out[%0d][%0d]: %0d",
        //            bx, by, dut.out[bx][by]);
        // end
      end
    end
    $display("Done checking.\n");
  end
  endtask


endmodule
