module writer_demux
#(
    parameter DATA_WIDTH = 64,
    parameter ADDR_WIDTH = 8
) (
    input wr_en_in,
    input A_select,
    input B_select,
    input [DATA_WIDTH-1:0] data_in, // connected to both A and B
    input [ADDR_WIDTH-1:0] addr_in, // connected to both A and B
    output wr_en_A,
    output wr_en_B,
    output [ADDR_WIDTH-1:0] addr_out, // connected to both A and B
    output [DATA_WIDTH-1:0] data_out // connected to both A and B
);
    assign addr_out = addr_in;
    assign data_out = data_in;
    assign wr_en_A = (A_select) ? wr_en_in : 1'b0;
    assign wr_en_B = (B_select) ? wr_en_in : 1'b0;
endmodule