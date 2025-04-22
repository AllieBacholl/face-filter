module write_back
#(
    parameter MEM_DATA_WIDTH = 64,
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 8,
    parameter ARRAY_SIZE = 16
)
(
    input clk,
    input rst_n,
    input clr,
    input start,
    input [DATA_WIDTH-1:0] systolic_out_final [ARRAY_SIZE-1:0][ARRAY_SIZE-1:0],
    input [ADDR_WIDTH-1:0] base_output_addr,
    input [ADDR_WIDTH-1:0] stride_chan, // stride of a channel
    input [4:0] activated_FIFO_num, // how many FIFOs are activated
    input data_written,
    output logic wr_en,
    output logic [ADDR_WIDTH-1:0] wr_addr,
    output logic [MEM_DATA_WIDTH-1:0] data_out,
    output logic done
);
    logic [ADDR_WIDTH-1:0] stride_chan_reg;
    logic [4:0] activated_FIFO_num_reg; // how many FIFOs are activated
    logic [ADDR_WIDTH-1:0] base_output_addr_reg;
    logic [4-$clog2(MEM_DATA_WIDTH/8):0] shift_per_col; // shift per column of the systolic array
    logic [4-$clog2(MEM_DATA_WIDTH/8):0] shift_cnt;
    logic [4:0] col_count;
    assign shift_per_col = activated_FIFO_num_reg[4:$clog2(MEM_DATA_WIDTH/8)] + (|activated_FIFO_num_reg[$clog2(MEM_DATA_WIDTH/8)-1:0]);
    // capture values at the start
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            stride_chan_reg <= 0;
            activated_FIFO_num_reg <= 0;
            wr_addr <= 0;
            shift_cnt <= 0;
            base_output_addr_reg <= 0;
            col_count <= 0;
        end else if (clr) begin
            stride_chan_reg <= 0;
            activated_FIFO_num_reg <= 0;
            wr_addr <= 0;
            shift_cnt <= 0;
            base_output_addr_reg <= 0;
            col_count <= 0;
        end else if (start) begin
            stride_chan_reg <= stride_chan;
            activated_FIFO_num_reg <= activated_FIFO_num;
            wr_addr <= base_output_addr;
            shift_cnt <= 0;
            base_output_addr_reg <= base_output_addr;
            col_count <= 0;
        end else if (data_written) begin
            if (shift_cnt == shift_per_col -1) begin
                shift_cnt <= 0;
                base_output_addr_reg <= base_output_addr_reg + stride_chan_reg;
                wr_addr <= base_output_addr_reg + stride_chan_reg;
                col_count <= col_count + 1;
            end else begin
                shift_cnt <= shift_cnt + 1;
                wr_addr <= wr_addr + 1;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (start) begin
            wr_en <= 1;
        end else if (data_written) begin
            wr_en <= 1;
        end else begin
            wr_en <= 0;
        end
    end

    always_comb begin
        for (int i = 0; i < MEM_DATA_WIDTH/DATA_WIDTH; i = i + 1) begin
            data_out[(i << 3) +: 8] = systolic_out_final[i + (shift_cnt << 3)][col_count];
        end
    end

    logic set_done;
    assign set_done = (col_count == activated_FIFO_num_reg - 1) && (shift_cnt == shift_per_col - 1);
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            done <= 0;
        end else if (clr) begin
            done <= 0;
        end else if (start) begin
            done <= 0;
        end else if (set_done) begin
            done <= 1;
        end 
    end
endmodule