module RAM 
#(
    parameter BAND=64,
    parameter DEPTH=128
)
(
    input wr,
    input rd,
    input addr,
    input clk,
    input rst_n,
    input data_in,
    output logic data_out
);
    reg [BAND-1:0] data [DEPTH-1:0];
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            for (int i = 0; i < DEPTH; i=i+1) begin
                data[i] <= 0;
            end
        end
        else begin
            if (wr & rd) begin
                data[addr] <= data_in;
                data_out <= data_in;
            end
            if (wr) begin
                data[addr] <= data_in;
            end
            else if (rd) begin
                data_out <= data[addr];
            end
            else data_out <= 0;
        end
    end
endmodule