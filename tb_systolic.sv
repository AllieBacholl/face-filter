module tb_systolic();
    logic rst_n;
    logic clk;
    logic clr;
    logic start;
    logic [7:0] weights [15:0];
    logic [7:0] inputs [15:0];
    logic [15:0] wren;
    logic [15:0] full_i;
    logic [15:0] full_w;
    logic [15:0] empty_i;
    logic [15:0] empty_w;
    logic [7:0] cnt;
    systolic_array systolic
    (
        .clk(clk),
        .rst_n(rst_n),
        .clr(clr),
        .start(start),
        .weights(weights),
        .inputs(inputs),
        .wren_w(wren),
        .wren_i(wren),
        .full_w(full_w),
        .full_i(full_i),
        .empty_w(empty_w),
        .empty_i(empty_i),
        .cnt(cnt)

    );
    initial begin
        clk = 0;
        rst_n = 1;
        clr = 0;
        start = 0;
        wren = 0;
        for (int i = 0; i < 16; i=i+1) begin
            weights[i] = 8'h02;
            inputs[i] = 8'h02;
        end
        @(posedge clk) rst_n = 0;
        @(posedge clk) rst_n = 1;
        @(posedge clk) start = 1;
        @(posedge clk) start = 0;
        for (int i = 0; i < 9; i=i+1) begin
            @(posedge clk) wren = 16'hffff;
            @(posedge clk) wren = 16'h0000;
            @(posedge clk) wren = 16'h0000;
            @(posedge clk) wren = 16'h0000;
        end
        @(posedge clk) wren = 16'h0000;
        @(posedge cnt==9) $stop;
    end
    always #1 clk = ~clk;
    initial #10000 $stop;
endmodule