module RAM 
#(
    parameter BAND=64,
    parameter DEPTH=1024,
    parameter TYPE=1
)
(
    input wr,
    input rd,
    input [$clog2(DEPTH)-1:0] addr,
    input clk,
    input rst_n,
    input [BAND-1:0] data_in,
    output logic [BAND-1:0] data_out,
    output logic data_valid,
    output logic data_written
);
    reg [BAND-1:0] data [DEPTH-1:0];
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            for (int i = 0; i < DEPTH; i=i+1) begin
                data[i] <= 0;
            end
            if (TYPE == 1) begin
                // we have 4 input channels
                for (int i = 0; i < 4; i=i+1) begin
                    for (int j = 0; j < 3; j=j+1) begin
                        for (int k = 0; k < 18; k++) begin
                            data[(i*18+j*6+k)/8][i*18+j*6+k - (i*18+j*6+k)/8*8 +: 8] <= {i[0], j[1:0], k[4:0]};
                        end
                    end
                end
            end
        end
        else begin
            if (wr & rd) begin
                data[addr] <= data_in;
                data_out <= data_in;
                data_written <= 1;
                data_valid <= 1;
            end
            if (wr) begin
                data[addr] <= data_in;
                data_written <= 1;
            end
            else if (rd) begin
                data_out <= data[addr];
                data_valid <= 1;
            end
            else begin
                data_out <= 0;
                data_valid <= 0;
                data_written <= 0;
            end
        end
    end
endmodule