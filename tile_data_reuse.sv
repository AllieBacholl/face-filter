module tile_data_reuse
#(
    parameter DATA_WIDTH = 64,
    parameter ADDRESS_WIDTH = 10
)
(
    input [ADDRESS_WIDTH-1:0] stride_row,
    input stride2_en,
    input [ADDRESS_WIDTH-1:0] ram_addr,
    input [DATA_WIDTH-1:0] ram_data,
    input [ADDRESS_WIDTH-1:0] til_mover_addr,
    input [DATA_WIDTH-1:0] til_mover_data,
    output logic [DATA_WIDTH-1:0] data_out,
    output logic [ADDRESS_WIDTH-1:0] data_addr
);
    always_comb begin
        if (tile_mover_select) begin
            data_out = til_mover_data;
            data_addr = til_mover_addr;
        end else begin
            data_out = ram_data;
            data_addr = ram_addr - (stride_row << stride2_en);
        end
    end
endmodule