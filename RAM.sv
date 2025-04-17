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
                // Loop over channels
                // for (int c = 0; c < 4; c = c + 1) begin
                //     // Loop over rows
                //     for (int r = 0; r < 3; r = r + 1) begin
                //         // Loop over columns (18 bytes per row)
                //         for (int col = 0; col < 14; col = col + 1) begin
                            
                //             // Assign unique pattern {channel, row, column}
                //             data[(c*14*3 + r*14 + col)/8][((c*14*3 + r*14 + col)-(c*14*3 + r*14 + col)/8*8)*8 +: 8] <= {col};
                //         end
                //     end
                // end
                for (int c = 0; c < 4; c = c + 1) begin
                    // Loop over rows
                    for (int r = 0; r < 3; r = r + 1) begin
                        data[c*3*3 + r*3] <= 64'h0706050403020100;
                        data[c*3*3 + r*3 + 1] <= 64'h0f0e0d0c0b0a0908;
                        data[c*3*3 + r*3 + 2] <= 64'h0000000000001110;
                    end
                end
            end
            else if (TYPE == 2) begin
                // Loop over channels
                // for (int c = 0; c < 4; c = c + 1) begin
                //     // Loop over rows
                //     for (int r = 0; r < 3; r = r + 1) begin
                //         // Loop over columns (18 bytes per row)
                //         for (int col = 0; col < 33; col = col + 1) begin
                            
                //             // Assign unique pattern {channel, row, column}
                //             data[(c*33*3 + r*33 + col)/8][((c*33*3 + r*33 + col)-(c*33*3 + r*33 + col)/8*8)*8 +: 8] <= {col};
                //         end
                //     end
                // end
                for (int c = 0; c < 4; c = c + 1) begin
                    // Loop over rows
                    for (int r = 0; r < 5; r = r + 1) begin
                        data[c*3*5 + r*5] <= 64'h0706050403020100;
                        data[c*3*5 + r*5 + 1] <= 64'h0f0e0d0c0b0a0908;
                        data[c*3*5 + r*5 + 2] <= 64'h1716151413121110;
                        data[c*3*5 + r*5 + 3] <= 64'h1f1e1d1c1b1a1918;
                        data[c*3*5 + r*5 + 4] <= 64'h0000000000002120;
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