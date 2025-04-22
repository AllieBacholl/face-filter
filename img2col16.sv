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
    input start,
    input [(DATA_IN_WIDTH*8)-1:0] data_in, // consumes (#FIFO-1)*stride+3 bytes per 3 clocks
    input [1:0] pad_first_col, // padding for the first column 0, 1 or 2 paddings
    input data_vld_in, 
    input data_consumed, // request to read new data for every FIFO (16 bytes at a time)
    input stride2_en, // stride 2 enable
    input [31:0] input_offset, // offset of the input data in the BRAM
    input [4:0] activated_FIFO_num, 
    output logic [7:0] data_out [15:0], // 8 bit data, 16x16 array
    output logic data_rdy_out, // img2col16 data ready signal
    output logic [$clog2(DEPTH)-1:0] rd_addr, // read address of the img data
    output logic rd_en // read enable signal to the BRAM
);

    logic [40*8-1:0] data_reg [1:0]; // 18 bytes or 33 bytes for 3 cycles, with offset tolerance
    logic [5:0] cnt_shift; // cycle counter for shifting data_reg[0]
    logic [5:0] cnt_shift_ff;
    logic [5:0] cnt_rd;
    logic shift_en;
    logic inc_rd_addr;
    logic dec_rd_addr;
    // logic [2:0] byte_offset; // byte offset of the data in the first byte of input data
    //logic [2:0] byte_offset_ff;
    logic data_rdy_out_ff;

    logic [5:0] TILE_ROW_LEN_STRIDE1; // in bytes
    logic [5:0] TILE_ROW_LEN_STRIDE2;
    assign TILE_ROW_LEN_STRIDE1 = (activated_FIFO_num) + 2 - pad_first_col; // 3 bytes for the first FIFO
    assign TILE_ROW_LEN_STRIDE2 = (activated_FIFO_num << 1) + 1 - pad_first_col; // 3 bytes for the first FIFO
    // assign byte_offset = stride2_en_ff ? 8 - (TILE_ROW_LEN_STRIDE2[2:0]) : 8 - (TILE_ROW_LEN_STRIDE1[2:0]);
    //logic [3:0] SHIFT_IN_CYCLES_STRIDE1_static;
    //logic [3:0] SHIFT_IN_CYCLES_STRIDE1_static_ff;
    logic [3:0] SHIFT_IN_CYCLES_STRIDE1;
    //assign SHIFT_IN_CYCLES_STRIDE1_static = ((TILE_ROW_LEN_STRIDE1 + DATA_IN_WIDTH - 1 + byte_offset[2:0]) >> $clog2(DATA_IN_WIDTH));
    //assign SHIFT_IN_CYCLES_STRIDE1 = SHIFT_IN_CYCLES_STRIDE1_static  - (|byte_offset[2:0]);
    assign SHIFT_IN_CYCLES_STRIDE1= ((TILE_ROW_LEN_STRIDE1 + DATA_IN_WIDTH - 1) >> $clog2(DATA_IN_WIDTH));
    //logic [3:0] SHIFT_IN_CYCLES_STRIDE2_static;
    //logic [3:0] SHIFT_IN_CYCLES_STRIDE2_static_ff;
    logic [3:0] SHIFT_IN_CYCLES_STRIDE2;
    //assign SHIFT_IN_CYCLES_STRIDE2_static = ((TILE_ROW_LEN_STRIDE2 + DATA_IN_WIDTH - 1 + byte_offset) >> $clog2(DATA_IN_WIDTH));
    //assign SHIFT_IN_CYCLES_STRIDE2 = SHIFT_IN_CYCLES_STRIDE2_static  - (|byte_offset);
    assign SHIFT_IN_CYCLES_STRIDE2 = ((TILE_ROW_LEN_STRIDE2 + DATA_IN_WIDTH - 1) >> $clog2(DATA_IN_WIDTH));

    logic stride2_en_ff;
    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            stride2_en_ff <= 0;
        end
        else if (clr) begin
            stride2_en_ff <= 0;
        end
        else if (start) begin
            stride2_en_ff <= stride2_en;
        end
    end

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
            data_rdy_out <= 0;
            //byte_offset_ff  <= 0;
        end
        else if (clr) begin
            data_rdy_out <= 0;
            //byte_offset_ff  <= 0;
        end
        else if (cnt_rd == 2'b10 && data_consumed) begin
            data_rdy_out <= 0;
        end
        else if (shift_en) begin
            if (stride2_en_ff ? (cnt_shift == SHIFT_IN_CYCLES_STRIDE2-1) : (cnt_shift == SHIFT_IN_CYCLES_STRIDE1-1)) begin
                data_rdy_out <= 1;
                //byte_offset_ff <= byte_offset;
                // SHIFT_IN_CYCLES_STRIDE1_static_ff <= SHIFT_IN_CYCLES_STRIDE1_static;
                // SHIFT_IN_CYCLES_STRIDE2_static_ff <= SHIFT_IN_CYCLES_STRIDE2_static;
            end
        end
    end

    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            cnt_shift <= 0;
        end
        else if (clr) begin
            cnt_shift <= 0;
        end
        else if (shift_en) begin
            if (stride2_en_ff ? (cnt_shift == SHIFT_IN_CYCLES_STRIDE2-1) : (cnt_shift == SHIFT_IN_CYCLES_STRIDE1-1)) begin
                cnt_shift <= 0;
            end
            else begin
                cnt_shift <= cnt_shift + 1;
            end
        end
    end

    logic [40*8-1:0] data_shift_pad;
    logic [40*8-1:0] data_shift;
    assign data_shift_pad = pad_first_col[1] ? {data_in, 16'h0000, data_reg[0][40*8-1:(DATA_IN_WIDTH*8)+16]} : 
                            (pad_first_col[0] ? {data_in, 8'h00, data_reg[0][40*8-1:(DATA_IN_WIDTH*8)+8]} : {data_in, data_reg[0][40*8-1:(DATA_IN_WIDTH*8)]});
    assign data_shift = {data_in, data_reg[0][40*8-1:(DATA_IN_WIDTH*8)]}; 

    
    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            data_reg[0] <= 0;
            data_reg[1] <= 0;
        end
        else if (clr) begin
            data_reg[0] <= 0;
            data_reg[1] <= 0;
        end
        else if (start) begin
            data_reg[0] <= pad_first_col[1] ? {16'h0000, data_reg[0][40*8-1:16]} : pad_first_col[0] ? {8'h00, data_reg[0][40*8-1:8]} : data_reg[0];
        end
        else if (shift_en) begin
            if (data_rdy_out && ~data_rdy_out_ff) begin
                data_reg[0] <= data_shift_pad;
                if (stride2_en_ff ? cnt_shift == SHIFT_IN_CYCLES_STRIDE2-1 : cnt_shift == SHIFT_IN_CYCLES_STRIDE1-1) data_reg[1] <= data_shift_pad;
            end
            else begin
                data_reg[0] <= data_shift;
                if (stride2_en_ff ? cnt_shift == SHIFT_IN_CYCLES_STRIDE2-1 : cnt_shift == SHIFT_IN_CYCLES_STRIDE1-1) data_reg[1] <= data_shift;
            end
        end
    end

    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            data_rdy_out_ff <= 0;
        end 
        else begin
            data_rdy_out_ff <= data_rdy_out;
        end
    end

    // always_ff @(posedge clk, negedge rst_n) begin
    //     if (~rst_n) begin
    //         byte_offset <= 0;
    //     end
    //     else if (clr) begin
    //         byte_offset <= 0;
    //     end 
    //     else if (data_rdy_out & ~data_rdy_out_ff) begin
    //         byte_offset <= (stride2_en_ff) ? (byte_offset[2:0] + TILE_ROW_LEN_STRIDE2[2:0]) : (byte_offset[2:0] + TILE_ROW_LEN_STRIDE1[2:0]); // when 18 bytes per tile, 2 bytes offset, when 33 bytes per tile, 1 byte offset, 8 bit data in width is hard coded
    //     end
    // end

    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            rd_addr <= 0;
        end
        else if (clr) begin
            rd_addr <= 0;
        end
        else if (start) begin
            rd_addr <= input_offset[$clog2(DEPTH)-1:0];
        end
        else if (inc_rd_addr) begin
            rd_addr <= rd_addr + 1;
        end
        else if (dec_rd_addr) begin
            rd_addr <= rd_addr - 1;
        end
    end

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
    always_comb begin
        rd_en = 0;
        shift_en = 0;
        inc_rd_addr = 0;
        dec_rd_addr = 0;
        nxt_state = state;
        case (state)
            IDLE: begin
                if (start) begin
                    rd_en = 1;
                    nxt_state = SHIFT;
                    inc_rd_addr = 1;
                end
            end
            SHIFT: begin
                if (data_rdy_out && (stride2_en_ff ? cnt_shift == SHIFT_IN_CYCLES_STRIDE2-1 : cnt_shift == SHIFT_IN_CYCLES_STRIDE1-1)) begin// && (stride2_en_ff ? cnt_shift == SHIFT_IN_CYCLES_STRIDE2-1 : cnt_shift == SHIFT_IN_CYCLES_STRIDE1-1)) begin
                    nxt_state = PAUSE;
                    dec_rd_addr = 1;
                end
                else if (data_vld_in) begin
                    rd_en = 1;
                    inc_rd_addr = 1;
                    shift_en = 1;
                end   
            end
            PAUSE: begin
                if (!data_rdy_out) begin
                    nxt_state = SHIFT;
                    rd_en = 1;
                    inc_rd_addr = 1;
                end
            end
        endcase
    end
    logic [8:0] base_select;
    assign base_select = 40*8 - ((stride2_en_ff ? (SHIFT_IN_CYCLES_STRIDE2) : (SHIFT_IN_CYCLES_STRIDE1)) << $clog2(DATA_IN_WIDTH*8)) - (pad_first_col << $clog2(8));
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin
            assign data_out[i] = (i < activated_FIFO_num) ? data_reg[1][((((i << stride2_en_ff)+cnt_rd) << 3) + base_select) +: 8] : 0;
        end
    endgenerate
endmodule