`timescale 1ns / 1ps

module image_resize_avg_simple_tb;

  // ----------------------------------------------------------------
  //  DUT I/O
  // ----------------------------------------------------------------
  reg         clk;
  reg         rst_n;
  reg         KEY_2;
  reg  [7:0]  Read_DATA2;
  reg         tx_done;

  wire        start_resize;
  wire [22:0] read_addr_resize;
  wire        done;           // DUT’s “averaging done”
  wire [7:0]  uart_tx;
  wire        uart_trmt;

  // ----------------------------------------------------------------
  //  Loop indices and counters (module‐scope for Verilog-2001)
  // ----------------------------------------------------------------
  integer pixel_count;
  integer by, bx, py, px;

  // ----------------------------------------------------------------
  //  Instantiate your DUT
  // ----------------------------------------------------------------
  image_resize_avg_simple dut (
    .clk             (clk),
    .rst_n           (rst_n),
    .KEY_2           (KEY_2),
    .Read_DATA2      (Read_DATA2),
    .tx_done         (tx_done),
    .start_resize    (start_resize),
    .read_addr_resize(read_addr_resize),
    .done            (),
    .uart_tx         (uart_tx),
    .uart_trmt       (uart_trmt),
    .avg_done        (),
    .triggered       (done)
  );

  // ----------------------------------------------------------------
  //  100 MHz clock
  // ----------------------------------------------------------------
  initial clk = 0;
  always #5 clk = ~clk;

  // ----------------------------------------------------------------
  //  Watchdog timeout (10 ms)
  // ----------------------------------------------------------------
  // initial begin
  //   #10_000_000;
  //   $display("** TIMEOUT at %0t **", $time);
  //   $finish;
  // end

  // ----------------------------------------------------------------
  //  Task: verify each 20×15 block average
  // ----------------------------------------------------------------
  task check_averages;
    reg [31:0] sum;
    reg [7:0]  expected;
    begin
      $display("Checking %0d×%0d blocks…", 32, 32);
      for (by = 0; by < 32; by = by + 1) begin
        for (bx = 0; bx < 32; bx = bx + 1) begin
          sum = 0;
          for (py = 0; py < 15; py = py + 1)
            for (px = 0; px < 20; px = px + 1)
              sum = sum + dut.receive[by*15 + py][bx*20 + px];
          expected = sum / 300;
          if (dut.out[by][bx] !== expected) begin
            $display("  ERROR out[%0d][%0d]: exp=%0d got=%0d",
                     by, bx, expected, dut.out[by][bx]);
          end else begin
            $display("  PASS  out[%0d][%0d]: %0d",
                     by, bx, dut.out[by][bx]);
          end
        end
      end
    end
  endtask

  // ----------------------------------------------------------------
  //  Main stimulus
  // ----------------------------------------------------------------
  initial begin
    // -- reset
    rst_n      = 0;
    KEY_2      = 1;      // not pressed (active-low)
    Read_DATA2 = 0;
    tx_done    = 1;
    #20;
    rst_n = 1;
    #10;

    // -- trigger the DUT to start resizing
    $display(">> Pressing KEY_2 at %0t", $time);
    KEY_2 = 0; #10; KEY_2 = 1;

    // -- stream pixels only when DUT asks for them
    pixel_count = 0;
    // keep feeding until DUT asserts done
    while (!done) begin
      @(posedge clk);
      if (start_resize) begin
        // simple gradient pattern: (pixel_count mod 256)
        Read_DATA2 = pixel_count % 256;
        pixel_count = pixel_count + 1;
      end
    end

    #10
    $display(">> Averaging completed at %0t", $time);

    // -- verify results
    check_averages();

    #100;
    $display(">> TEST FINISHED at %0t", $time);
    $finish;
  end

endmodule
