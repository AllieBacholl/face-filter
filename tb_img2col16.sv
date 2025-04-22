`timescale 1ns/1ps

module tb_img2col16();

    // Parameters
    parameter DATA_IN_WIDTH = 8;
    parameter DEPTH = 1024;
    
    // Testbench Signals
    logic clk;
    logic rst_n;
    logic clr; // clr and reset
    logic start;
    logic [1:0] pad_first_col; // 00: no padding, 01: 1 byte padding, 10: 2 byte padding
    logic [(DATA_IN_WIDTH*8)-1:0] data_in;
    logic data_vld_in;
    logic data_consumed;
    logic stride2_en;
    logic [31:0] input_offset;
    logic [7:0] data_out [15:0];
    logic data_rdy_out;
    logic [$clog2(DEPTH)-1:0] rd_addr;
    logic rd_en;
    logic [4:0] activated_FIFO_num;

    // Clock generation
    always #5 clk = ~clk; // 10ns clock period

    // Instantiate the DUT (Device Under Test)
    img2col16 #(
        .DATA_IN_WIDTH(DATA_IN_WIDTH),
        .DEPTH(DEPTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .clr(clr),
        .start(start),
        .data_in(data_in),
        .pad_first_col(pad_first_col),
        .data_vld_in(data_vld_in),
        .data_consumed(data_consumed),
        .stride2_en(stride2_en),
        .input_offset(input_offset),
        .data_out(data_out),
        .data_rdy_out(data_rdy_out),
        .rd_addr(rd_addr),
        .rd_en(rd_en),
        .activated_FIFO_num(activated_FIFO_num)
    );

    // Parameters
    parameter BAND = 64;
    parameter TYPE = 1;

    // Instantiate the RAM module
    RAM #(
        .BAND(BAND),
        .DEPTH(DEPTH),
        .TYPE(TYPE)
    ) ram_inst (
        .wr(0),
        .rd(rd_en),
        .addr(rd_addr),
        .clk(clk),
        .rst_n(rst_n),
        .data_in(),
        .data_out(data_in),
        .data_valid(data_vld_in),
        .data_written()
    );

    // Test Sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        clr =1;
        start = 0;
        data_consumed = 0;
        stride2_en = 0;
        input_offset = 0;
        pad_first_col = 2'b10; 
        activated_FIFO_num = 16;

        // Reset sequence
        #20 rst_n = 1;
        #10 clr = 1;
        #10 clr = 0;
        
        // Observe the outputs
        #1000;

        @(posedge clk) clr =1;
        #100;
        @(posedge clk) clr =0;

        // Start the test
        #10 start = 1;
        #10 start = 0;

        // Observe the outputs
        #1000;

        // clear and see if the data_rdy_out is 0
        @(posedge clk) clr =1;
        #10;
        @(posedge clk) clr =0;
        #100;
        
        // End simulation
        $stop;
    end

    // Monitor output changes
    integer file; // File handle

    initial begin
        repeat (4) begin
            @(posedge data_rdy_out);
            repeat (3) @(posedge clk) data_consumed = 1;
            @(posedge clk) data_consumed = 0;
        end
        file = $fopen("output_img2col16.txt", "w"); // Open the file in write mode
        if (file == 0) begin
            $display("Error: Unable to open file.");
            $finish;
        end
    end

    always @(posedge data_rdy_out) begin
        $fwrite(file, "data_rdy_out=%b | rd_addr=%h | rd_en=%b\n", 
                data_rdy_out, rd_addr, rd_en);
        // Write the entire array to the file
        for (int i = 0; i < 16; i = i + 1) begin
            $fwrite(file, "data_out[%0d] = %h\n", i, data_out[i]);
        end
    end

    final begin
        $fclose(file); // Close the file at the end of simulation
    end

endmodule
