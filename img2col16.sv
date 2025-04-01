/**
 * @file img2col16.sv
 * @brief img2col16 module for the facefilter design, 8KB should be enough for a single tile.
 * @author Han Lyu
 */
module img2col16
#(
    parameter DATA_IN_WIDTH = 8, // in bytes, depends on the final bandwidth of BRAM
    parameter DEPTH = 1024 // depends on the size of BRAM
)
(
    input clk,
    input rst_n,
    input clr,
    input [(DATA_IN_WIDTH*8)-1:0] data_in, // consumes (#FIFO-1)*stride+3 bytes per 3 clocks
    input data_vld_in, 
    input data_consumed, // request to read new data for every FIFO (16 bytes at a time)
    input stride2_en, // stride 2 enable
    input [31:0] input_offset, // offset of the input data in the BRAM
    output logic [7:0] data_out [15:0], // 8 bit data, 16x16 array
    output logic data_rdy_out, // img2col16 data ready signal
    output logic [$clog2(DEPTH)-1:0] rd_addr, // read address of the img data
    output logic rd_en // read enable signal to the BRAM
);
    localparam TILE_ROW_LEN_STRIDE1 = 18; // in bytes
    localparam TILE_ROW_LEN_STRIDE2 = 33;
    logic [3:0] SHIFT_IN_CYCLES_STRIDE1;
    assign SHIFT_IN_CYCLES_STRIDE1 = (8*TILE_ROW_LEN_STRIDE1 + (DATA_IN_WIDTH*8) - 1)/(DATA_IN_WIDTH*8) ;
    logic [3:0] SHIFT_IN_CYCLES_STRIDE2;
    assign SHIFT_IN_CYCLES_STRIDE2 = (8*TILE_ROW_LEN_STRIDE2 + (DATA_IN_WIDTH*8) - 1)/(DATA_IN_WIDTH*8);

    logic [SHIFT_IN_CYCLES_STRIDE2*(DATA_IN_WIDTH*8)-1:0] data_reg [1:0]; // 18 bytes or 33 bytes for 3 cycles, with offset tolerance
    logic [5:0] cnt_shift; // cycle counter for shifting data_reg[0]
    logic [5:0] cnt_shift_ff;
    logic [5:0] cnt_rd;


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
        if (~rst_n) cnt_shift_ff <= 0;
        else cnt_shift_ff <= cnt_shift;
    end

    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            cnt_shift <= 0;
            data_rdy_out <= 0;
        end
        else if (clr) begin
            cnt_shift <= 0;
            data_rdy_out <= 0;
        end
        else if (cnt_rd == 2'b10 && data_consumed) begin
            data_rdy_out <= 0;
        end
        else if (data_vld_in) begin
            if (~stride2_en && cnt_shift != SHIFT_IN_CYCLES_STRIDE1-1) begin
                cnt_shift <= cnt_shift + 1;
            end
            else if (stride2_en && cnt_shift != SHIFT_IN_CYCLES_STRIDE2-1) begin
                cnt_shift <= cnt_shift + 1;
            end
            else begin
                cnt_shift <= 0;
                data_rdy_out <= 1;
            end
        end
    end
    
    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            data_reg[0] <= 0;
            data_reg[1] <= 0;
        end
        else if (clr) begin
            data_reg[0] <= 0;
            data_reg[1] <= 0;
        end
        else if (data_vld_in) begin
            data_reg[0] <= {data_in, data_reg[0][SHIFT_IN_CYCLES_STRIDE2*(DATA_IN_WIDTH*8)-1:(DATA_IN_WIDTH*8)]};
            if (~stride2_en && cnt_shift == SHIFT_IN_CYCLES_STRIDE1-1) data_reg[1] <= {data_in, data_reg[0][SHIFT_IN_CYCLES_STRIDE2*(DATA_IN_WIDTH*8)-1:(DATA_IN_WIDTH*8)]};
            else if (stride2_en && cnt_shift == SHIFT_IN_CYCLES_STRIDE2-1) data_reg[1] <= {data_in, data_reg[0][SHIFT_IN_CYCLES_STRIDE2*(DATA_IN_WIDTH*8)-1:(DATA_IN_WIDTH*8)]};
        end
    end

    logic [2:0] byte_offset; // byte offset of the data in the first byte of input data
    logic data_rdy_out_ff;
    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            data_rdy_out_ff <= 0;
        end 
        else begin
            data_rdy_out_ff <= data_rdy_out;
        end
    end

    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            byte_offset <= 0;
        end
        else if (clr) begin
            byte_offset <= 0;
        end
        else if (data_rdy_out & ~data_rdy_out_ff) begin
            byte_offset <= byte_offset + ((stride2_en) ? (TILE_ROW_LEN_STRIDE2 - TILE_ROW_LEN_STRIDE2/DATA_IN_WIDTH*DATA_IN_WIDTH) : (TILE_ROW_LEN_STRIDE1 - TILE_ROW_LEN_STRIDE1/DATA_IN_WIDTH*DATA_IN_WIDTH)); // when 18 bytes per tile, 2 bytes offset, when 33 bytes per tile, 1 byte offset
        end
    end

    // always_ff @(posedge clk, negedge rst_n) begin
    //     if (~rst_n) begin
    //         rd_addr <= 0;
    //     end
    //     else if (clr) begin
    //         rd_addr <= 0;
    //     end
    //     else if (data_vld_in) begin
    //         rd_addr <= rd_addr + 1;
    //     end
    // end

    logic stop_shift;
    assign stop_shift = (cnt_rd == 2'b10);

    // always_ff @(posedge clk, negedge rst_n) begin
    //     if (~rst_n) begin
    //         rd_en <= 0;
    //     end
    //     else if (clr) begin
    //         rd_en <= 0;
    //     end
    //     else if (~stop_shift) begin
    //         rd_en <= 1;
    //     end
    //     else begin
    //         rd_en <= 0;
    //     end
    // end

    // define states, idle and transmission states
    typedef enum logic [1:0] {IDLE,  SHIFT, PAUSE} state_t;
    state_t state;
    state_t nxt_state;  

    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
        end
        else if (clr) begin
            state <= IDLE;
        end
        else begin
            state <= nxt_state;
        end
    end

    logic shift_en;
    logic inc_rd_addr;
    always_comb begin
        rd_en = 0;
        shift_en = 0;
        inc_rd_addr = 0;
        case (state)
            IDLE: begin
                rd_en = 1;
                nxt_state = SHIFT;
            end
            SHIFT: begin
                if (cnt_rd == 2 && (stride2_en ? cnt_shift == SHIFT_IN_CYCLES_STRIDE2-1 : cnt_shift == SHIFT_IN_CYCLES_STRIDE1-1)) begin
                    nxt_state = PAUSE;
                end
                else if (data_vld_in) begin
                    rd_en = 1;
                    shift_en = 1;
                    inc_rd_addr = 1;
                end   
            end
            PAUSE: begin
                if (!data_rdy_out) begin
                    nxt_state = SHIFT;
                end
            end

        endcase
    end

    always_comb begin
        for (int i = 0; i < 16; i++) begin
            data_out[i] = data_reg[1][((((i << stride2_en)+cnt_rd) << 3) + (byte_offset << 3) + (stride2_en ? 0 : ((SHIFT_IN_CYCLES_STRIDE2-SHIFT_IN_CYCLES_STRIDE1)*DATA_IN_WIDTH))) +: 8];
        end
    end
endmodule