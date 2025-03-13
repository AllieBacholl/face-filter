module systolic_array 
#(
    parameter ARRAY_SIZE = 16,
    parameter DATA_WIDTH = 8
) 
(
    input clk,
    input rst_n,
    input start,
    input clr,
    input [DATA_WIDTH-1:0] weights [ARRAY_SIZE-1:0],
    input [DATA_WIDTH-1:0] inputs [ARRAY_SIZE-1:0],
    input [ARRAY_SIZE-1:0] wren_w,
    input [ARRAY_SIZE-1:0] wren_i,
    output [ARRAY_SIZE-1:0] full_w,
    output [ARRAY_SIZE-1:0] full_i,
    output [ARRAY_SIZE-1:0] empty_w,
    output [ARRAY_SIZE-1:0] empty_i,
    output done

);
    logic [DATA_WIDTH-1:0] weights_out [ARRAY_SIZE-1:0];
    logic [DATA_WIDTH-1:0] inputs_out [ARRAY_SIZE-1:0];
    logic [ARRAY_SIZE-1:0] rden;
    logic en_first;
    logic [$clog2(ARRAY_SIZE):0] cnt;

    FIFO fifo_w [ARRAY_SIZE-1:0] (
        .clk(clk),
        .rst_n(rst_n),
        .rden(rden),
        .wren(wren_w),
        .i_data(weights),
        .o_data(weights_out),
        .full(full_w),
        .empty(empty_w)
    );

    FIFO fifo_i [ARRAY_SIZE-1:0] (
        .clk(clk),
        .rst_n(rst_n),
        .rden(rden),
        .wren(wren_i),
        .i_data(inputs),
        .o_data(inputs_out),
        .full(full_i),
        .empty(empty_i)
    );

    always_ff @(posedge clk) begin
        if (!rst_n) cnt <= 0;
        else if (clr) cnt <= 0;
        else if (rden[0]) cnt <= cnt + 1;
    end

    always_ff @(posedge clk, rst_n) begin
        if (!rst_n) begin
            rden <= 0;
            en_first <= 0;
        end
        else if (cnt == ARRAY_SIZE) begin
            rden <= {rden[ARRAY_SIZE-2:0], 1'b0};
            en_first <= 0;
        end 
        else if (start) begin
            rden <= {rden[ARRAY_SIZE-2:0], 1'b1};
            en_first <= rden[0];
        end
        else begin
            rden <= {rden[ARRAY_SIZE-2:0], rden[0]};
            en_first <= rden[0];
        end
    end
    genvar i, j;
    logic [DATA_WIDTH-1:0] A [ARRAY_SIZE-1:0][ARRAY_SIZE-1:0];
    logic [DATA_WIDTH-1:0] B [ARRAY_SIZE-1:0][ARRAY_SIZE-1:0];
    logic [4*DATA_WIDTH-1:0] O [ARRAY_SIZE-1:0][ARRAY_SIZE-1:0];
    logic en [ARRAY_SIZE-1:0][ARRAY_SIZE-1:0];
    generate
        for (i = 0; i < ARRAY_SIZE; i=i+1) begin
            for (j = 0; j < ARRAY_SIZE; j=j+1) begin
                if (i > 0 && j > 0) begin
                    PE #(
                        .DATA_WIDTH(DATA_WIDTH)
                    ) pe (
                        .A(A[i-1][j]),
                        .B(B[i][j-1]),
                        .en(en[i][j-1] & en[i-1][j]),
                        .clk(clk),
                        .rst_n(rst_n),
                        .clr(clr),
                        .Out(O[i][j]),
                        .en_out(en[i][j]),
                        .A_out(A[i][j]),
                        .B_out(B[i][j])
                    );
                end
                else if (j > 0) begin
                    PE #(
                        .DATA_WIDTH(DATA_WIDTH)
                    ) pe (
                        .A(weights_out[j]),
                        .B(B[i][j-1]),
                        .en(en[i][j-1]),
                        .clk(clk),
                        .rst_n(rst_n),
                        .clr(clr),
                        .Out(O[i][j]),
                        .en_out(en[i][j]),
                        .A_out(A[i][j]),
                        .B_out(B[i][j])
                    );
                end
                else if (i > 0) begin
                    PE #(
                        .DATA_WIDTH(DATA_WIDTH)
                    ) pe (
                        .A(A[i-1][j]),
                        .B(inputs_out[i]),
                        .en(en[i-1][j]),
                        .clk(clk),
                        .rst_n(rst_n),
                        .clr(clr),
                        .Out(O[i][j]),
                        .en_out(en[i][j]),
                        .A_out(A[i][j]),
                        .B_out(B[i][j])
                    );
                end
                else begin
                    PE #(
                        .DATA_WIDTH(DATA_WIDTH)
                    ) pe (
                        .A(weights_out[j]),
                        .B(inputs_out[i]),
                        .en(en_first),
                        .clk(clk),
                        .rst_n(rst_n),
                        .clr(clr),
                        .Out(O[i][j]),
                        .en_out(en[i][j]),
                        .A_out(A[i][j]),
                        .B_out(B[i][j])
                    );
                end
            end
        end
    endgenerate
    assign done = en[ARRAY_SIZE-1][ARRAY_SIZE-1] & (~en[ARRAY_SIZE-2][ARRAY_SIZE-1]);
endmodule