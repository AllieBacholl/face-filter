module RAM_delay ();
    RAM #(
        .BAND=64,
        .DEPTH=128,
        .TYPE=1
    ) 
    (
        input wr,
        input rd,
        input [$clog2(DEPTH)-1:0]addr,
        input clk,
        input rst_n,
        input [BAND-1:0] data_in,
        output logic [BAND-1:0] data_out
    );
endmodule