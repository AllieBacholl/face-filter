`timescale 1ns/1ps

module tb_tile_mover;

    // Parameters
    parameter DATA_WIDTH = 64;
    parameter ADDR_WIDTH = 8;

    // DUT Inputs
    logic clk;
    logic rst_n;
    logic clr;
    logic [5:0] row_len;
    logic [ADDR_WIDTH-1:0] base_addr_rd;
    logic [ADDR_WIDTH-1:0] base_addr_wr;
    logic [ADDR_WIDTH-1:0] stride_chan;
    logic [9:0] chan_num;
    logic start;
    logic pad_all;
    logic [1:0] pad_first_col; // unused in current logic
    logic data_valid;
    logic data_consumed;

    // DUT Outputs
    logic [ADDR_WIDTH-1:0] read_addr;
    logic [ADDR_WIDTH-1:0] wr_addr;
    logic rd_en;
    logic done;

    // Clock generation
    always #5 clk = ~clk;

    // DUT instance
    tile_mover #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .clr(clr),
        .pad_all(pad_all),
        .pad_first_col(pad_first_col),
        .row_len(row_len),
        .base_addr_rd(base_addr_rd),
        .base_addr_wr(base_addr_wr),
        .stride_chan(stride_chan),
        .chan_num(chan_num),
        .start(start),
        .data_valid(data_valid),
        .data_consumed(data_consumed),
        .read_addr(read_addr),
        .wr_addr(wr_addr),
        .rd_en(rd_en),
        .done(done)
    );

    // Reset task
    task reset();
        rst_n = 0;
        clr = 0;
        start = 0;
        data_valid = 0;
        #20;
        rst_n = 1;
        #10;
    endtask

    // Clear task
    task clear();
        clr = 1;
        #10;
        clr = 0;
    endtask

    // Drive data_valid pattern to mimic FIFO availability or memory ready
    task simulate_data_valid(input int cycles);
        for (int i = 0; i < cycles; i++) begin
            data_valid = 1;
            @(posedge clk);
            data_consumed = 1;
            @(posedge clk);
            data_valid = 0;
            data_consumed = 0;
            @(posedge clk);
        end
    endtask

    initial begin
        // Init
        clk = 0;
        rst_n = 1;
        clr = 0;
        start = 0;
        data_valid = 0;
        pad_all = 1;
        pad_first_col = 2'b00; // unused in current logic

        // Configuration
        row_len = 6'd18;         // 3 reads (18 / 8 = 2.25, ceil → 3)
        base_addr_rd = 8'd16;    // starting address
        base_addr_wr = 8'd32;    // unused in current logic
        stride_chan = 8'd4;      // increment per channel
        chan_num = 10'd2;        // number of channels

        // Start sequence
        reset();
        clear();

        // Start the operation
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;
        @(posedge clk);

        // Simulate data valid every 2 cycles
        repeat (20) begin
            simulate_data_valid(1);
            @(posedge clk);
        end

        $display("Simulation done. Final read_addr: %0d, done: %0d", read_addr, done);
        $stop;
    end

endmodule
