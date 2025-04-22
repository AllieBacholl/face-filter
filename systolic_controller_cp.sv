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
    inout [31:0] reg_data,
    input rst_n,
    input clk,
    input rd_wr_reg,
    input [ARRAY_SIZE-1:0] full_w,
    input [ARRAY_SIZE-1:0] full_i,
    input [ARRAY_SIZE-1:0] empty_w,
    input [ARRAY_SIZE-1:0] empty_i,
    input data_rdy_in, // need to make the feeding of data synchronized
    input data_written,
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
    output logic [8*DATA_WIDTH-1:0] data_out // results were 32 bits and need a quantization
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
    end
    else begin
        reg_out <= regFile[reg_addr];
        if (clr_config) begin
            regFile[6][0] <= 0;
        end
    end
    
end

logic [$clog2(O_BRAM_DEPTH)-1:0] row_offset;
logic [$clog2(O_BRAM_DEPTH)-1:0] col_offset;
logic [$clog2(O_BRAM_DEPTH)-1:0] chan_offset;
always_ff @(posedge clk, negedge rst_n) begin
    if (regFile[6][0]) begin
        output_dim_reg <= ((regFile[4] - 3) >> (reg_data[1] ? 1 : 0)) + 1;
        chan_offset <= output_dim_reg >> 3;
        row_offset <= 
    end
    
end

assign stride2_en = regFile[6][1];
assign input_offset = regFile[2];

logic inc_weight_addr;
logic shift_weight_addr; // shift weight address by a tile
logic clr_weight_addr;

logic inc_i_tile_cnt;
logic sat_i_tile_cnt;
logic [9:0] row_addr;
logic [9:0] col_addr;
assign sat_i_tile_cnt = (row_addr == output_dim_reg-1) && (col_addr == (output_dim_reg >> $clog2(ARRAY_SIZE))-1);
always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        row_addr <= 0;
        col_addr <= 0;
    end
    else if (inc_i_tile_cnt) begin
        if (row_addr == output_dim_reg-1) begin
            row_addr <= 0;
            if (col_addr == (output_dim_reg >> $clog2(ARRAY_SIZE))-1) begin
                col_addr <= 0;
            end
            else begin
                col_addr <= col_addr + 1;
            end
        end
        else begin
            row_addr <= row_addr + 1;
        end
    end
end

logic [9:0] cnt_fed; // how many times FIFO is fed without clr/writeback
logic inc_cnt_fed;
logic clr_cnt_fed;

logic clr_output_cnt;
logic inc_output_cnt;
logic [5:0] cnt_output;
always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        cnt_output <= 0;
    end
    else if (clr_output_cnt) begin
        cnt_output <= 0;
    end
    else if (inc_output_cnt) begin
        cnt_output <= cnt_output + 1;
    end
end

always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        weight_rd_addr <= 0;
    end
    else if (clr_weight_addr) begin
        weight_rd_addr <= 0;
    end
    else if (shift_weight_addr) begin
        weight_rd_addr <= weight_rd_addr - (((regFile[3] << 3) + regFile[3]) >> 4);
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

always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        data_out <= 0;
    end
    else begin
        data_out <= {
            O[7 + (cnt_output[0] << 3)][cnt_output[4:1]],
            O[6 + (cnt_output[0] << 3)][cnt_output[4:1]],
            O[5 + (cnt_output[0] << 3)][cnt_output[4:1]],
            O[4 + (cnt_output[0] << 3)][cnt_output[4:1]],
            O[3 + (cnt_output[0] << 3)][cnt_output[4:1]],
            O[2 + (cnt_output[0] << 3)][cnt_output[4:1]],
            O[1 + (cnt_output[0] << 3)][cnt_output[4:1]],
            O[0 + (cnt_output[0] << 3)][cnt_output[4:1]]
        };
    end
end

always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        output_wr_addr <= 0;
    end
    else if (shift_weight_addr) begin
        output_wr_addr <= output_wr_addr + (output_dim_reg << $clog2(ARRAY_SIZE));
    end
    else if () begin
        output_wr_addr <= (col_addr << 1) + cnt_output[0] + output_dim_reg * cnt_output[4:1]
    end
end

always_comb begin
    {wren_w, wren_i} = 0;
    {rd, wr} = 0;
    clr = 0;
    clr_config = 0;
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
                clr_config = 1;
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
            else begin
                rd = 1;
            end
        COMPUTING:
            rd = 1;
            if (cnt == ((regFile[3] << 3) + regFile[3])) begin
                nxt_state = WRITE_BACK;
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
            if (cnt_output == (ARRAY_SIZE*ARRAY_SIZE/8)) begin
                if (weight_rd_addr == (regFile[1] >> 4)) begin
                    nxt_state = IDLE;
                    clr_weight_addr = 1;
                end
                else begin
                    nxt_state = FILL;
                    shift_weight_addr = (~sat_i_tile_cnt);
                end
                clr_cnt_fed = 1;
                clr_output_cnt = 1;
                clr = 1;
            end
            else begin
                wr = 1;
                if (data_written) begin
                    inc_output_cnt = 1;
                end
            end
    endcase
end
endmodule