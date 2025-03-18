module data_buffer
#(
    parameter DATA_IN_WIDTH=16,
    parameter BUF_LEVEL=3
)
(
    input [DATA_IN_WIDTH-1:0] data_in,
    input clk,
    input rst_n,
    input en,
    output [DATA_IN_WIDTH*BUF_LEVEL-1:0] data_out
);
    generate
        if (BUF_LEVEL==0) begin
            assign data_out = data_in;
            assign data_ready = en;
        end
        else begin
            logic en_nxt;
            always_ff @(posedge clk, negedge rst_n) begin
                if (!rst_n) en_nxt <= 0;
                else en_nxt <= en;
            end
            logic [DATA_IN_WIDTH-1:0] data_in_last;
            always_ff @(posedge clk, negedge rst_n) begin
                if (!rst_n) data_in_last <= 0;
                else if (en) data_in_last <= data_in;
            end
            logic [2*DATA_IN_WIDTH-1:0] data_in_next;
            always_ff @(posedge clk, negedge rst_n) begin
                if (!rst_n) data_in_next <= 0;
                else if (en) data_in_next <= {data_in, data_in_last};
            end
            logic data_ready_nxt;
            data_buffer #(.DATA_IN_WIDTH(2*DATA_IN_WIDTH), .BUF_LEVEL(BUF_LEVEL-1)) 
                buffer (.data_in(data_in_next), .data_out(data_out), .clk(clk), .rst_n(rst_n), .en(en_nxt), .data_ready(data_ready_nxt));
            always_ff @(posedge clk, negedge rst_n) begin
                if (!rst_n) data_ready <= 0;
                else data_ready <= data_ready_nxt;
            end
        end
    endgenerate
endmodule