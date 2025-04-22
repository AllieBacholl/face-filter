`timescale 1ns / 1ps

module tb_write_back;

    // Parameters
    parameter MEM_DATA_WIDTH = 64;
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;
    parameter ARRAY_SIZE = 16;

    // DUT Signals
    logic clk, rst_n, clr, start, data_written;
    logic [DATA_WIDTH-1:0] systolic_out_final [ARRAY_SIZE-1:0][ARRAY_SIZE-1:0];
    logic [ADDR_WIDTH-1:0] base_output_addr, stride_chan;
    logic [4:0] activated_FIFO_num;
    logic wr_en;
    logic [ADDR_WIDTH-1:0] wr_addr;
    logic [MEM_DATA_WIDTH-1:0] data_out;
    logic done;

    // Clock Generation
    always #5 clk = ~clk;

    // DUT Instance
    write_back #(
        .MEM_DATA_WIDTH(MEM_DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .ARRAY_SIZE(ARRAY_SIZE)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .clr(clr),
        .start(start),
        .systolic_out_final(systolic_out_final),
        .base_output_addr(base_output_addr),
        .stride_chan(stride_chan),
        .activated_FIFO_num(activated_FIFO_num),
        .data_written(data_written),
        .wr_en(wr_en),
        .wr_addr(wr_addr),
        .data_out(data_out),
        .done(done)
    );

    // Test Procedure
    integer fd;
    initial begin
        // Initial values
        clk = 0;
        rst_n = 0;
        clr = 0;
        start = 0;
        data_written = 0;
        base_output_addr = 8'h10;
        stride_chan = 8'h12;
        activated_FIFO_num = 5'd16;
        // Open file
        fd = $fopen("write_back_log.txt", "w");

        // Reset
        #10;
        rst_n = 1;
        #10;

        // Fill systolic_out_final with dummy data
        for (int i = 0; i < ARRAY_SIZE; i++) begin
            for (int j = 0; j < ARRAY_SIZE; j++) begin
                systolic_out_final[i][j] = i * ARRAY_SIZE + j;
            end
        end

        // Trigger Start
        start = 1;
        #10;
        start = 0;

        // Simulate data_written events
        data_written = 1;
        @(posedge done);
        data_written = 0;

        #100;
        $stop;
    end
    always @(data_out) begin
        // Log data_out
        $fdisplay(fd, "Data Out: %h\n", data_out);
        $fdisplay(fd, "Write Address: %h\n", wr_addr);
    end

endmodule
