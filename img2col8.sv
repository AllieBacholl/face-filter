module img2col8
(
    input clk,
    input rst_n,
    input clr,
    input stride2_en, // 1: stride 2, 0: stride 1
    input [63:0] data_in, // 8 byte bandwidth
    input data_vld_in, 
    input data_consumed, // request to read new data
    output logic [7:0] data_out [7:0], // 8 bit data, 8x8 array
    output logic data_rdy_out,
    output logic [1:0] row_number // This is column first order sliding window, so row number is needed to read non-sequential data
);
    logic [23:0] data_reg [1:0];
    logic [1:0] cnt_shift; // cycle counter for shifting data_reg[0]
    logic [1:0] cnt_shift_ff;
    logic [1:0] cnt_rd;
    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            cnt_rd <= 0;
        end
        else if (clr) begin
            cnt_rd <= 0;
        end
        else if (data_rdy_out && data_consumed) begin
            if (cnt_rd != 2'b10) cnt_rd <= cnt_rd + 1;
            else cnt_rd <= 0;
        end
    end
    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            data_rdy_out <= 0;
            row_number <= 0;
        end
        else if (clr) begin
            data_rdy_out <= 0;
            row_number <= 0;
            
        end
        else if (cnt_rd == 2'b10 && data_consumed) begin
            data_rdy_out <= 0;
        end
        else if (cnt_shift == 2'b00 && cnt_shift_ff == 2'b10) begin
            data_rdy_out <= 1;
            row_number <= row_number + 1;
        end 
    end

    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) cnt_shift_ff <= 0;
        else cnt_shift_ff <= cnt_shift;
    end

    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            cnt_shift <= 0;
        end
        else if (clr) begin
            cnt_shift <= 0;
        end
        else if (data_vld_in) begin
            if (cnt_shift != 2'b10) cnt_shift <= cnt_shift + 1;
            else cnt_shift <= 0;
        end
    end

    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            data_reg[0] <= 16'h0;
            data_reg[1] <= 16'h0;
        end
        else if (clr) begin
            data_reg[0] <= 16'h0;
            data_reg[1] <= 16'h0;
        end
        else if (data_vld_in) begin
            data_reg[0] <= {data_in[7:0], data_reg[0][15:8]};
            if (cnt_shift == 2'b10) data_reg[1] <= {data_in[7:0], data_reg[0][15:8]};
        end
    end
    always_comb begin
        for (int i = 0; i < 8; i++) begin
            data_out[i] = data_reg[1][(i+(cnt_rd << stride2_en))*8 +: 8];
        end
    end
endmodule