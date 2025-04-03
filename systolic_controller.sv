module systolic_controller
#(
    parameter ARRAY_SIZE=16,
    parameter MEM_BAND=16,
    parameter DATA_WIDTH=8,
    parameter W_BRAM_DEPTH=8192,
    parameter O_BRAM_DEPTH=8192
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
    input data_rdy_in, // need to make the feeding of data synchronized
    input [4*DATA_WIDTH-1:0] O [ARRAY_SIZE-1:0][ARRAY_SIZE-1:0],
    output stride2_en, // stride 2 enable
    output [31:0] input_offset, // offset of the input data in the BRAM
    output logic [$clog2(W_BRAM_DEPTH)-1:0] weight_rd_addr,
    output logic [$clog2(O_BRAM_DEPTH)-1:0] output_wr_addr,
    output logic [ARRAY_SIZE-1:0] wren_w,
    output logic [ARRAY_SIZE-1:0] wren_i,
    output logic start, // start the systolic array
    output logic rd, // for W_BRAM
    output logic wr, // for output BRAM
    output logic clr, 
    output logic [DATA_WIDTH-1:0] data_out // results were 32 bits and need a quantization
);

// global counters for sliding windows and output channels


// kernel memory offset register 0
// kernel number register 1 (kernel number so that we don't need a multiplier)
// input memory offset register 2
// input channel number register 3
// input feature dimension register 4
// output memory offset register 5
// stride (1 bit), config_complete (1 bit) register 6
// done (1 bit) read only register 7
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
assign stride2_en = regFile[6][1];
assign input_offset = regFile[2];

// do required computation after config complete
// logic [9:0] channel_offset;
// logic [9:0] row_offset;
// logic [9:0] col_offset;
// logic [2:0] byte_offset;
// always_ff @(posedge clk, negedge rst_n) begin
//     if (!rst_n) begin
//         channel_offset; <= 0;
//         row_offset <= 0;
//         col_offset <= 0;
//         byte_offset <= 0;
//     end
//     else if (regFile[6][0]) begin
//         channel_offset <= regFile[4][7:0] * regFile[4][7:0];
//     end
// end
logic inc_weight_addr;
logic shift_weight_addr; // shift weight address by a tile
logic clr_weight_addr;

logic [9:0] i_tile_cnt;
logic inc_i_tile_cnt;
logic sat_i_tile_cnt;
assign sat_i_tile_cnt = (i_tile_cnt == (output_dim_reg << ($clog2(regFile[4]) >> ($clog2(ARRAY_SIZE) + stride2_en))) - 1);
always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        i_tile_cnt <= 0;
    end
    else if (inc_i_tile_cnt) begin
        if (sat_i_tile_cnt) i_tile_cnt <= 0
        else i_tile_cnt <= i_tile_cnt + 1;
    end
end

logic [2:0] w_tile_cnt;
logic clr_w_tile_cnt;
always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        w_tile_cnt <= 0;
    end
    else if (clr_w_tile_cnt) begin
        w_tile_cnt <= 0;
    end
    else if (inc_i_tile_cnt && sat_i_tile_cnt) begin
        w_tile_cnt <= w_tile_cnt + 1;
    end
end 

logic [9:0] cnt_fed; // how many times FIFO is fed without clr/writeback
logic inc_cnt_fed;
logic clr_cnt_fed;

logic clr_output_cnt;
logic inc_output_cnt;
logic [7:0] cnt_output;

always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        weight_rd_addr <= 0;
    end
    else if (clr_weight_addr) begin
        weight_rd_addr <= 0;
    end
    else if (inc_weight_addr) begin
        weight_rd_addr <= weight_rd_addr + 1;
    end
end

always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        cnt_fed <= 0;
    end
    else if (clr_cnt_fed) begin
        cnt_fed <= 0;
    end
    else if (inc_cnt_fed) begin
        cnt_fed <= cnt_fed + 1;
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

always_comb begin
    {wren_w, wren_i} = 0;
    {rd, wr} = 0;
    clr = 0;
    start = 0;
    inc_weight_addr = 0;
    clr_weight_addr = 0;
    shift_weight_addr = 0;
    inc_cnt_fed = 0;
    clr_cnt_fed = 0;
    nxt_state = state;
    case (state)
        IDLE:
        // wait for the config complete signal
            if (regFile[6][0]) begin
                nxt_state = FILL;
                clr = 1;
                inc_weight_addr = 1;
                rd = 1;
            end
        FILL:
            if (&{full_w, full_i}) begin
                nxt_state = COMPUTING;
                start = 1;
            end
            else if (data_rdy_in) begin
                {wren_w, wren_i} = '1;
                inc_weight_addr = 1;
                inc_cnt_fed = 1;
                rd = 1;
            end
        COMPUTING:
            rd = 1;
            if (cnt == output_dim_reg) begin
                nxt_state = WRITE_BACK;
                clr_weight_addr = 1; // we swap input tiles first and reuse weight tile
                inc_i_tile_cnt = 1;
            end
            else if (~(|{full_w, full_i}) && cnt_fed != ((regFile[3] << 3) + regFile[3])) begin // when none of them is full and we haven't fed all the data
                if (data_rdy_in) begin
                    {wren_w, wren_i} = '1;
                    inc_weight_addr = 1;
                    inc_cnt_fed = 1;
                end
            end
        WRITE_BACK:
            if (cnt_output == ARRAY_SIZE*ARRAY_SIZE) begin
                if (sat_i_tile_cnt && ) begin

                end
                else begin
                end
                nxt_state = IDLE;
                clr_cnt_fed = 1;
                clr_output_cnt = 1;
                wr = 1;
            end
            else begin
                inc_output_cnt = 1;
                wr = 1;
            end
    endcase
end
endmodule