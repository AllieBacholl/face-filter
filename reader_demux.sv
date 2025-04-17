module reader_demux
#(
    parameter DATA_WIDTH = 64,
    parameter ADDR_WIDTH = 8
) (
    input rd_en_in,
    input A_select,
    input B_select,
    input [DATA_WIDTH-1:0] rd_data_A,
    input [DATA_WIDTH-1:0] rd_data_B,
    input [ADDR_WIDTH-1:0] addr_in,
    output [DATA_WIDTH-1:0] data_out,
    output rd_en_A,
    output rd_en_B,
    output [ADDR_WIDTH-1:0] addr_out // connected to both A and B
);
    assign data_out = (A_select) ? rd_data_A : (B_select) ? rd_data_B : {DATA_WIDTH{1'b0}};
    assign addr_out = addr_in;
    assign rd_en_A = (A_select) ? rd_en_in : 1'b0;
    assign rd_en_B = (B_select) ? rd_en_in : 1'b0;
endmodule