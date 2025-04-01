module tb_control();

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
    logic [31:0] O [15:0][15:0]
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
        .cnt(cnt),
        .O(O)
    );

    logic [2:0] reg_addr;
    logic [7:0] reg_data;
    logic rd_wr_reg;
    logic [31:0] input_rd_addr;
    logic [31:0] weight_rd_addr;
    logic [31:0] output_wr_addr;
    logic [31:0] data_out;
    logic data_rdy_out;
    logic rd, wr;
    systolic_controller #(
        .ARRAY_SIZE(16),
        .MEM_BAND(16),
        .DATA_IN_WIDTH(8)
    ) controller (
        .cnt(cnt), // how many times the last PE (bottom right corner) is enabled
        .reg_addr(reg_addr),
        .reg_data(reg_data),
        .rst_n(rst_n),
        .clk(clk),
        .rd_wr_reg(rd_wr_reg),
        .full_w(full_w),
        .full_i(full_i),
        .empty_w(empty_w),
        .empty_i(empty_i),
        .data_rdy_in(valid_i & valid_w), // Assume the weight and inputs are fed in together from BRAM
        .data_written(out_wriiten),
        .O(O),
        .data_rdy_out(data_rdy_out),
        .input_rd_addr(input_rd_addr),
        .weight_rd_addr(weight_rd_addr),
        .output_wr_addr(output_wr_addr),
        .wren_w(wren_w),
        .wren_i(wren_i),
        .start(start),
        .rd(rd),
        .wr(wr),
        .clr(clr),
        .data_out(data_out)
    );

    logic [127:0] weights_out
    logic valid_w;
    RAM #(
        .BAND(128),
        .DEPTH(128),
        .TYPE(1)
    ) ram_w
    (
        .wr(0),
        .rd(rd),
        .addr(weight_rd_addr),
        .clk(clk),
        .rst_n(rst_n),
        .data_in(0),
        .data_out(weights_out),
        .data_valid(valid_w),
        .data_written()
    );

    logic [127:0] inputs_out
    logic valid_i;
    RAM #(
        .BAND(128),
        .DEPTH(128),
        .TYPE(2)
    ) ram_i
    (
        .wr(0),
        .rd(rd),
        .addr(input_rd_addr),
        .clk(clk),
        .rst_n(rst_n),
        .data_in(0),
        .data_out(inputs_out),
        .data_valid(valid_i),
        .data_written()
    );

    logic [127:0] inputs_out;
    logic out_wriiten;
    RAM #(
        .BAND(32),
        .DEPTH(1024),
        .TYPE(3)
    ) ram_out (
        .wr(wr),
        .rd(0),
        .addr(output_wr_addr),
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_out),
        .data_out(),
        .data_valid(),
        .data_written(out_written)
    );

    initial begin
        rst_n = 1;
        reg_addr = 0;
        reg_data = 0;
        rd_wr_reg = 1;
        @(posedge clk) rst_n = 0;
        @(posedge clk) rst_n = 1;
        // kernel memory offset register 0
        // kernel channel number register 1
        // input memory offset register 2
        // input channel number register 3
        // input feature dimension register 4
        // output memory offset register 5
        // stride (1 bit), config_complete (1 bit) 6
        // done (1 bit) read only 7
        for (int i = 0; i < 7; i=i+1) begin
            @(posedge clk) begin
                reg_addr = i
                rd_wr_reg = 0;
                case (i)
                    0: reg_data = 0;
                    1: reg_data = 8;
                    2: reg_data = 0;
                    3: reg_data = 4;
                    4: reg_data = 16;
                    5: reg_data = 0;
                    6: reg_data 
                endcase
            end
        end
    end

    

    // Clock Generation
    always #1 clk_signal = ~clk_signal; // 10ns clock period
endmodule