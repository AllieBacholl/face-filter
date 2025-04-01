module systolic_controller
#(
    parameter ARRAY_SIZE=16,
    parameter MEM_BAND=16,
    parameter DATA_WIDTH=8
)
(
    input [9:0] cnt, // how many times the last PE (bottom right corner) is enabled
    input [2:0] reg_addr,
    inout [7:0] reg_data,
    input rst_n,
    input clk,
    input rd_wr_reg,
    input [ARRAY_SIZE-1:0] full_w,
    input [ARRAY_SIZE-1:0] full_i,
    input [ARRAY_SIZE-1:0] empty_w,
    input [ARRAY_SIZE-1:0] empty_i,
    input data_rdy_in, // Assume the weight and input are fed in together from BRAM
    input data_written,
    input [4*DATA_WIDTH-1:0] O [ARRAY_SIZE-1:0][ARRAY_SIZE-1:0],
    output logic data_rdy_out,
    output logic [32:0] input_rd_addr,
    output logic [32:0] weight_rd_addr,
    output logic [32:0] output_wr_addr,
    output logic [ARRAY_SIZE-1:0] wren_w,
    output logic [ARRAY_SIZE-1:0] wren_i,
    output logic start,
    output logic rd,
    output logic wr,
    output logic clr,
    output logic [4*DATA_WIDTH-1:0] data_out
);

// global counters for sliding windows and output channels
logic [15:0] cnt_slide; // column
logic [15:0] cnt_slide_row; // row
logic [14:0] cnt_kern;
logic [9:0] cnt_fed; // how many times FIFO is fed without clr/writeback
logic [7:0] cnt_output;

// kernel memory offset register 0
// kernel channel number register 1
// input memory offset register 2
// input channel number register 3
// input feature dimension register 4
// output memory offset register 5
// stride (1 bit), config_complete (1 bit) 6
// done (1 bit) read only 7
logic [31:0] regFile [7:0];
logic [31:0] output_dim_reg;
logic [7:0] reg_out;
logic clr_config;
always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        for (int i = 0; i < 8; i=i+1) begin
            regFile[i] <= 0;
        end
    end
    else if (!rd_wr_reg) begin
        if (reg_addr != 3'b111) regFile[reg_addr] <= reg_data;
        if (reg_addr == 3'b110 && reg_data[0]) begin
            output_dim_reg <= ((regFile[4] - 3) >> (reg_data[1] ? 1 : 0)) + 1;
        end
        else if (clr_config) regFile[6][0] <= 0;
    end
    else begin
        reg_out <= regFile[reg_addr];
    end
    
end

// do required computation after config complete
logic [9:0] channel_offset;
logic [9:0] row_offset;
logic [9:0] col_offset;
logic [2:0] byte_offset;
always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        channel_offset; <= 0;
        row_offset <= 0;
        col_offset <= 0;
        byte_offset <= 0;
    end
    else if (regFile[6][0]) begin
        channel_offset <= regFile[4][7:0] * regFile[4][7:0];
    end
end

// tristate databus
assign reg_data = (rd_wr_reg) ? reg_out : 8'bzzzzzzzz;

// define states, idle and transmission states
typedef enum logic [1:0] {IDLE,  FILL, COMPUTING, WRITE_BACK} state_t;
state_t state;
state_t nxt_state;

always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        state <= IDLE;
    end
    else begin
        nxt_state <= state;
    end
end





endmodule