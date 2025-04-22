module pad_input
#(
    parameter DATA_WIDTH=64
)
(
    input pad_en,
    input [DATA_WIDTH-1:0] data_in,
    output logic [DATA_WIDTH-1:0] data_out,
);
    
    always_comb begin
        if (pad_en) begin
            data_out = '0;
        end else begin
            data_out = data_in;
        end
    end
endmodule