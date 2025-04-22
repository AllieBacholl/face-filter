`timescale 1ns/1ps

module tb_output_proc;

  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 8;
  parameter ARRAY_SIZE = 16;

  logic clk;
  logic rst_n;
  logic clr;
  logic start;
  logic max_pooling_en;
  logic relu_en;
  logic signed [31:0] scale;
  logic signed [31:0] zero_point;
  logic [4:0] activated_FIFO_num;

  logic [4*DATA_WIDTH-1:0] systolic_out [ARRAY_SIZE-1:0][ARRAY_SIZE-1:0];
  logic [DATA_WIDTH-1:0] quant_systolic_out_pooled_final [ARRAY_SIZE-1:0][ARRAY_SIZE-1:0];
  logic processing_done;
  logic systolic_out_consumed;

  integer fd;
  integer raw_input_val;

  // Clock generation
  always #5 clk = ~clk;

  // Instantiate DUT
  output_proc #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .ARRAY_SIZE(ARRAY_SIZE)
  ) dut (
    .clk(clk),
    .rst_n(rst_n),
    .clr(clr),
    .start(start),
    .max_pooling_en(max_pooling_en),
    .relu_en(relu_en),
    .scale(scale),
    .zero_point(zero_point),
    .activated_FIFO_num(activated_FIFO_num),
    .systolic_out(systolic_out),
    .quant_systolic_out_pooled_final(quant_systolic_out_pooled_final),
    .processing_done(processing_done),
    .systolic_out_consumed(systolic_out_consumed)
  );

  // Stimulus
  initial begin
    $display("Starting Testbench...");

    // Open file
    fd = $fopen("output_proc_log.txt", "w");
    if (fd == 0) begin
      $display("ERROR: Could not open output file.");
      $finish;
    end

    // Initialize
    clk = 0;
    rst_n = 0;
    clr = 0;
    start = 0;
    relu_en = 1;
    max_pooling_en = 0;
    scale = 32'sh40000000;      // 0.5 in Q0.31
    zero_point = 32'sh00000010; // +16
    activated_FIFO_num = ARRAY_SIZE - 2;

    // Reset
    #10 rst_n = 1;
    #10 clr = 1;
    #10 clr = 0;

    // Generate and log input
    $fdisplay(fd, "==== INPUT: SYSTOLIC_OUT ====");
    for (int i = 0; i < ARRAY_SIZE; i++) begin
      for (int j = 0; j < ARRAY_SIZE; j++) begin
        raw_input_val = (j * ARRAY_SIZE + i);
        systolic_out[i][j] = {{(4*DATA_WIDTH-8){1'b0}}, raw_input_val[7:0]};
        $fwrite(fd, "%0d ", raw_input_val);
      end
      $fwrite(fd, "\n");
    end

    // Start processing
    #10 start = 1; #10 start = 0;

    if (max_pooling_en) begin
        @(posedge systolic_out_consumed);
        #10 start = 1; #10 start = 0;

        $fdisplay(fd, "==== INPUT: SYSTOLIC_OUT ====");
        for (int i = 0; i < ARRAY_SIZE; i++) begin
        for (int j = 0; j < ARRAY_SIZE; j++) begin
            raw_input_val = (i * ARRAY_SIZE + j + 2);
            systolic_out[i][j] = -{{(4*DATA_WIDTH-8){1'b0}}, raw_input_val[7:0]};
            $fwrite(fd, "%0d ", raw_input_val);
        end
        $fwrite(fd, "\n");
        end

        @(posedge systolic_out_consumed);
        #10 start = 1; #10 start = 0;
    end

    wait (processing_done);
    #10;

    // Log final output
    $fdisplay(fd, "\n==== FINAL OUTPUT: quant_systolic_out_pooled_final ====");
    for (int i = 0; i < ARRAY_SIZE; i++) begin
      for (int j = 0; j < ARRAY_SIZE; j++) begin
        $fwrite(fd, "%0d ", quant_systolic_out_pooled_final[i][j]);
      end
      $fwrite(fd, "\n");
    end

    $fdisplay(fd, "\nTest complete.");
    $fclose(fd);
    $display("Test finished. Results written to 'output_proc_log.txt'");
    $stop;
  end

  always @(dut.systolic_row_selected) begin
    // Log intermediate: systolic_row_selected
    $fdisplay(fd, "\n==== RELU OUTPUT: systolic_row_selected ====");
    for (int i = 0; i < ARRAY_SIZE; i++) begin
      $fwrite(fd, "%0d ", dut.systolic_row_selected[i][7:0]);
    end
    $fwrite(fd, "\n");
  end

  always @(dut.quant_systolic_out) begin
    // Log intermediate: quant_systolic_out
    $fdisplay(fd, "\n==== QUANTIZED OUTPUT: quant_systolic_out ====");
    for (int i = 0; i < ARRAY_SIZE; i++) begin
      $fwrite(fd, "%0d ", dut.quant_systolic_out[i]);
    end
    $fwrite(fd, "\n");
  end

  always @(posedge (dut.cnt_quant != 0 && dut.cnt_quant_ff == 0)) begin
    // Log intermediate: quant_systolic_out_pooled
    $fdisplay(fd, "\n==== MAXPOOL STAGE 1: quant_systolic_out_pooled ====");
    for (int i = 0; i < ARRAY_SIZE; i++) begin
      for (int j = 0; j < ARRAY_SIZE; j++) begin
        $fwrite(fd, "%0d ", dut.quant_systolic_out_pooled[i][j]);
      end
      $fwrite(fd, "\n");
    end
  end

//   always @(dut.quant_systolic_out_pooled) begin
//     // Log intermediate: quant_systolic_out_pooled
//     $fdisplay(fd, "\n==== MAXPOOL STAGE 1: quant_systolic_out_pooled ====");
//     for (int i = 0; i < ARRAY_SIZE; i++) begin
//       for (int j = 0; j < ARRAY_SIZE; j++) begin
//         $fwrite(fd, "%0d ", dut.quant_systolic_out_pooled[i][j]);
//       end
//       $fwrite(fd, "\n");
//     end
//   end



endmodule


