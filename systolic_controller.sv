module systolic_controller
#(
    parameter ARRAY_SIZE=16,
    parameter MEM_BAND=16,
    parameter DATA_IN_WIDTH=8,
)
(
    input [12:0] cnt, // how many times the last PE (bottom right corner) is enabled
    input [2:0] reg_addr,
    inout [7:0] reg_data,
    input rst_n,
    input clk,
    input rd_wr_reg,
    input [ARRAY_SIZE-1:0] full_w,
    input [ARRAY_SIZE-1:0] full_i,
    input [ARRAY_SIZE-1:0] empty_w,
    input [ARRAY_SIZE-1:0] empty_i,
    input data_rdy,
    input [DATA_WIDTH-1:0] data_in [2*ARRAY_SIZE-1:0],
    output [7:0] input_rd_addr,
    output [7:0] weight_rd_addr,
    output [7:0] output_wr_addr,
    output [ARRAY_SIZE-1:0] wren_w,
    output [ARRAY_SIZE-1:0] wren_i,
    output [DATA_WIDTH-1:0] weights [ARRAY_SIZE-1:0],
    output [DATA_WIDTH-1:0] inputs [ARRAY_SIZE-1:0],
    output clr
);

// global counters for sliding windows and output channels
logic []

// tristate databus
assign reg_data = (rd_wr_reg) ? reg_out : 8'bzzzzzzzz;

// kernel memory offset register
// kernel channel number register
// input memory offset register
// input channel number register
// input feature dimension register
// kernel feature dimension register
// stride (1 bit), config_complete (1 bit)
// done (1 bit) read only
logic [7:0] regFile [2:0]
logic [7:0] reg_out;
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
    end
end

// define states, idle and transmission states
typedef enum logic [2:0] {IDLE,  FILL} state_t;
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
    case (state) 
        IDLE:
            if (regFile[6][0]) begin// if config is done
                nxt_state = FILL;
            end
        FILL:
            if (done) begin
                regFile[7] <= 7'b1; // set done register
            end
    endcase
end



endmodule