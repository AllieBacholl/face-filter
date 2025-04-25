`timescale 1ns/1ps

module tb_image_resize_avg_simple;

  // Inputs to DUT
  reg         clk;
  reg         rst_n;
  reg         KEY_2;
  reg  [7:0]  Read_DATA2;

  // Outputs from DUT
  wire        start_resize;
  wire [22:0] read_addr_resize;

  // Instantiate the DUT
  image_resize_avg_simple dut (
    .clk               (clk),
    .rst_n             (rst_n),
    .KEY_2             (KEY_2),
    .Read_DATA2        (Read_DATA2),

    .start_resize      (start_resize),
    .read_addr_resize  (read_addr_resize),
    .done(),
    .uart_tx(),
    .uart_trmt         ()
  );

  // 1) Clock gen: 50 MHz → 20 ns period
  initial clk = 0;
  always #10 clk = ~clk;

  // 2) Data source: hold 600 after reset
  always @(posedge clk) begin
    if (!rst_n)
      Read_DATA2 <= 8'd0;
    else
      Read_DATA2 <= 8'd600;
  end

  // 3) Stimulus: reset, pulse KEY_2, run…
  initial begin
    $dumpfile("tb_image_resize_avg_simple.vcd");
    $dumpvars(0, tb_image_resize_avg_simple);

    rst_n = 1'b0;
    KEY_2 = 1'b1;
    #100;

    rst_n = 1'b1;
    #50;

    KEY_2 = 1'b0;  // start
    #20;
    KEY_2 = 1'b1;

    #50000;       // enough time for 3 blocks
    $finish;
  end

  // optional monitor
  initial begin
   // $monitor("%0t | bx=%0d by=%0d px=%0d py=%0d out00=%0d",
          //   $time, dut.block_x, dut.block_y, dut.pixel_x, dut.pixel_y, dut.out[0][0]);
  end

  // 4) Compute expected averages (all 600)
  reg [7:0] expected0, expected1, expected2;
  initial begin
    expected0 = 8'd600;
    expected1 = 8'd600;
    expected2 = 8'd600;
    $display("Expecting out[0][0]=%0d, out[0][1]=%0d, out[0][2]=%0d",
             expected0, expected1, expected2);
  end

  // 5a) Check block [0][0] when block_x rolls to 1
  always @(posedge clk) begin
    if (dut.block_x == 1 && dut.block_y == 0 &&
        dut.pixel_x == 0 && dut.pixel_y == 0) begin
      if (dut.out[0][0] !== expected0)
        $display("FAIL block[0][0]=%0d, expected=%0d",
               dut.out[0][0], expected0);
      else
        $display("PASS block[0][0]=%0d", expected0);
    end
  end

  // 5b) Check block [0][1] when block_x rolls to 2
  always @(posedge clk) begin
    if (dut.block_x == 2 && dut.block_y == 0 &&
        dut.pixel_x == 0 && dut.pixel_y == 0) begin
      if (dut.out[0][1] !== expected1)
        $display("FAIL block[0][1]=%0d, expected=%0d",
               dut.out[0][1], expected1);
      else
        $display("PASS block[0][1]=%0d", expected1);
    end
  end

  // 5c) Check block [0][2] when block_x rolls to 3, then finish
  always @(posedge clk) begin
    if (dut.block_x == 3 && dut.block_y == 0 &&
        dut.pixel_x == 0 && dut.pixel_y == 0) begin
      if (dut.out[0][2] !== expected2)
        $display("FAIL block[0][2]=%0d, expected=%0d",
               dut.out[0][2], expected2);
      else
        $display("PASS block[0][2]=%0d", expected2);

      #10 $finish;
    end
  end

endmodule
