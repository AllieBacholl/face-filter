/**
    * @file tile_mover.sv
    * @brief Tile Mover Module
    * @details This module is responsible for moving tiles in a 2D array.
    *          It takes the number of columns needed per row and the global row number as inputs.
    * @version 1.0
    * @date 2025-4-16
    */
module tile_mover 
#(
    parameter DATA_WIDTH = 64,
    parameter ADDR_WIDTH = 8
) (
    input clk,
    input rst_n,
    input clr,
    input [5:0] row_len, // how many columns needed per row, 18 or 33 or (FIFO-1)*stride + 3
    input [ADDR_WIDTH-1:0] base_addr_rd, // global row number
    input [ADDR_WIDTH-1:0] base_addr_wr, // global row number
    input [ADDR_WIDTH-1:0] stride_chan, // stride of a channel
    input [9:0] chan_num, // how many channels
    input start,
    input data_valid,
    input data_consumed, // data is read by the tile BRAM
    output logic [ADDR_WIDTH-1:0] read_addr,
    output logic [ADDR_WIDTH-1:0] wr_addr,
    output logic rd_en,
    output logic done
);

    // TODO: loop counter
    logic [ADDR_WIDTH-1:0] stride_chan_reg;
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            stride_chan_reg <= 0;
        end else if (clr) begin
            stride_chan_reg <= 0;
        end else if (start) begin
            stride_chan_reg <= stride_chan;
        end
    end 

    logic [ADDR_WIDTH-1:0] base_addr_rd_reg; 
    logic inc_stride;
    logic [9:0] chan_cnt;
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            base_addr_rd_reg <= 0;
            chan_cnt <= 0;
        end else if (clr) begin
            base_addr_rd_reg <= 0;
            chan_cnt <= 0;
        end else if (start) begin
            base_addr_rd_reg <= base_addr_rd;
            chan_cnt <= chan_num;
        end else if (inc_stride) begin
            base_addr_rd_reg <= base_addr_rd_reg + stride_chan_reg;
            chan_cnt <= chan_cnt - 1;
        end
    end

    logic [5:0] row_len_reg;
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            row_len_reg <= '1;
        end else if (clr) begin
            row_len_reg <= '1;
        end else if (start) begin
            row_len_reg <= row_len;
        end
    end

    //rd_en control
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            rd_en <= 0;
        end else if (clr) begin
            rd_en <= 0;
        end else if (start) begin
            rd_en <= 1;
        end else if (chan_cnt == 0) begin
            rd_en <= 0;
        end else if (data_valid & data_consumed) begin
            rd_en <= 1;
        end else begin
            rd_en <= 0;
        end
    end

    // 8 bytes per read so 6-3=3 bit counter to count if a unit row
    logic [2:0] rd_cnt;
    logic [2:0] rd_cnt_ff;
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            rd_cnt <= 0;
            rd_cnt_ff <= 0;
        end else if (clr) begin
            rd_cnt <= 0;
            rd_cnt_ff <= 0;
        end else if (start) begin
            rd_cnt <= 0;
            rd_cnt_ff <= 0;
        end else if (rd_cnt == row_len_reg[5:3] + (|row_len_reg[2:0]) - 1 && data_valid && data_consumed) begin
            rd_cnt <= 0;
            rd_cnt_ff <= 0;
        end else if (data_valid & data_consumed) begin
            rd_cnt <= rd_cnt + 1;
            rd_cnt_ff <= rd_cnt;
        end
        else rd_cnt_ff <= rd_cnt;
    end

    assign inc_stride = (rd_cnt == row_len_reg[5:3] + (|row_len_reg[2:0]) - 1) & (rd_cnt_ff != row_len_reg[5:3] + (|row_len_reg[2:0]) - 1) & ~done;
    assign read_addr = base_addr_rd_reg + rd_cnt;
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) done <= 0;
        else if (chan_cnt == 0 && data_valid && data_consumed) begin
            done <= 1;
        end else if (start) done = 0;
    end
endmodule