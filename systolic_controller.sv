module systolic_controller
#(
    parameter ARRAY_SIZE=16,
    parameter CONFIG_MEM_WIDTH=32,
    parameter O_ADDR_WIDTH=13, // output BRAM 8192 addresses
    parameter W_ADDR_WIDTH=13, // weight BRAM 8192 addresses
    parameter T_ADDR_WIDTH=10 // input BRAM 960 addresses
) (
    input clk,
    input rst_n,
    input img2col_data_rdy_out,
    input output_processing_done,
    input output_proc_systolic_out_consumed,
    input tile_mover_done,
    input write_back_done,
    inout [CONFIG_MEM_WIDTH-1:0] reg_data,
    input [ARRAY_SIZE-1:0] full_w,
    input [ARRAY_SIZE-1:0] full_i,
    input [ARRAY_SIZE-1:0] empty_w,
    input [ARRAY_SIZE-1:0] empty_i,
    input [9:0] cnt, // records how many times the last PE is enabled
    input [T_ADDR_WIDTH-1:0] img2col_rd_addr, // the address of the input data in the BRAM
    output logic rd_config_info,
    output logic wr_config_info,
    output logic wr_done,
    output logic clr_systolic,
    output logic start_systolic,
    output logic start_img2col,
    output logic clr_img2col,
    output logic img2col_rd,
    output logic stride2_en,
    output logic [CONFIG_MEM_WIDTH-1:0] input_offset,
    output logic [4:0] activated_FIFO_num,
    output logic start_output_proc,
    output logic clr_output_proc,
    output logic max_pooling_en,
    output logic relu_en,
    output logic [31:0] scale,
    output logic [31:0] zero_point,
    output logic start_tile_mover,
    output logic clr_tile_mover,
    output logic [1:0] pad_first_col,
    output logic pad_all,
    output logic [5:0] row_len,
    output logic [T_ADDR_WIDTH-1:0] base_addr_rd_tile_mover,
    output logic [9:0] chan_num,
    output logic tile_mover_rd,
    output logic [T_ADDR_WIDTH-1:0] stride_chan_tile,
    output logic start_write_back,
    output logic clr_write_back,
    output logic [O_ADDR_WIDTH-1:0] base_addr_write_back,
    output logic [O_ADDR_WIDTH-1:0] stride_chan_write_back,
    output logic tile_mover_select,
    output logic Tile_A_select_wr,
    output logic Tile_B_select_wr,
    output logic Tile_A_select_rd,
    output logic Tile_B_select_rd,
    output logic Output_A_select_wr,
    output logic Output_B_select_wr,
    output logic Output_A_select_rd,
    output logic Output_B_select_rd,
    output logic [W_ADDR_WIDTH-1:0] weight_rd_addr,
    output logic weight_rd,
    output logic weight_ready, // just in case if it's not ready the next cycle
    output logic [3:0] config_reg_addr
);
    // define states, idle and transmission states
    typedef enum logic [2:0] {IDLE,  READ_STATS, INIT, FILL_TILE, FILL_FIFO, COMPUTE, OUTPUT_PROC, WRITE_BACK} state_t;
    state_t state;
    state_t nxt_state; 
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
        end
        else begin
            state <= nxt_state;
        end
    end

    logic[CONFIG_MEM_WIDTH-1:0] reg_data_ff;
    logic[CONFIG_MEM_WIDTH-1:0] reg_out; // only used for conv done
    // tristate databus
    assign reg_data = (wr_config_info) ? reg_out : 8'bzzzzzzzz;
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            reg_data_ff <= 0;
        end
        else begin
            reg_data_ff <= reg_data;
        end
    end

    // internal egister file
    logic [CONFIG_MEM_WIDTH-1:0] kernel_offset; 
    logic [CONFIG_MEM_WIDTH-1:0] output_chan_num;
    logic [CONFIG_MEM_WIDTH-1:0] input_memory_offset;
    logic [CONFIG_MEM_WIDTH-1:0] input_chan_num;
    logic [CONFIG_MEM_WIDTH-1:0] input_dim_padding_stride; // [0] stride, [1:2] padding
    logic [CONFIG_MEM_WIDTH-1:0] output_offset;
    logic [CONFIG_MEM_WIDTH-1:0] conv_lin_config_done_relu_pool; // [0] config done, [1] conv/lin, [2] relu, [3] pooling
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            kernel_offset <= 0;
            output_chan_num <= 0;
            input_memory_offset <= 0;
            input_chan_num <= 0;
            input_dim_padding_stride <= 0;
            output_offset <= 0;
            conv_lin_config_done_relu_pool <= 0;
            scale <= 0;
            zero_point <= 0;
            reg_out <= 0;
        end
        else if (state==READ_STATS) begin
            case (config_reg_addr)
                2: input_dim_padding_stride_ <= reg_data;
                3: input_chan_num <= reg_data;
                4: output_chan_num <= reg_data;
                5: kernel_offset <= reg_data;
                6: input_memory_offset <= reg_data;
                7: output_offset <= reg_data;
                8: scale <= reg_data;
                9: zero_point <= reg_data;
                0: conv_lin_config_done_relu_pool <= reg_data;
            endcase
        end
    end
    assign chan_num = input_chan_num[9:0];

    // The following happens during read stats, pipeline the calculation and share a multiplier
    // global multiplier to save resources, omg timing freaks me out so...
    logic [CONFIG_MEM_WIDTH-1:0] A;
    logic [CONFIG_MEM_WIDTH-1:0] B;
    logic [CONFIG_MEM_WIDTH-1:0] C;
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            C <= 0;
        end
        else begin
            C <= A * B;
        end
    end

    logic [CONFIG_MEM_WIDTH-1:0] input_row_stride_reg;
    logic [CONFIG_MEM_WIDTH-1:0] output_dim_reg;
    logic [CONFIG_MEM_WIDTH-1:0] output_row_stride_reg;
    logic [CONFIG_MEM_WIDTH-1:0] cnt_fed_top_reg;
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            A <= 0;
            B <= 0;
        end
        else if (config_reg_addr==3) begin
            A <= reg_data;
            B <= (input_dim_padding_stride >> 3);
            stride2_en <= input_dim_padding_stride[0];
            output_dim_reg <= ((input_dim_padding_stride >> 3) + (input_dim_padding_stride[1:2] << 1) - 3);
            stride_chan_tile <= reg_data[9:0];
        end
        else if (config_reg_addr==4) begin
            input_row_stride_reg <= (C << input_dim_padding_stride[0]); // shift left by 1 if stride is 2
            output_dim_reg <= (output_dim_reg >> (input_dim_padding_stride[0])) + 1
        end
        else if (config_reg_addr==5) begin
            A <= output_dim_reg;
            B <= output_chan_num;
            stride_chan_write_back <= output_dim_reg[9:0];
        end
        else if (config_reg_addr==6) begin
            A <= (input_dim_padding_stride >> 3);
            B <= 9;
            output_row_stride_reg <= C;
        end
        else if (config_reg_addr==7) begin
            cnt_fed_top_reg <= C;
            input_offset <= input_memory_offset;
        end
    end

    // input tile counter 
    logic [CONFIG_MEM_WIDTH-5:0] input_tile_loc_row_cnt; // the row location of the tile 
    logic [CONFIG_MEM_WIDTH-1:0] input_tile_loc_col_cnt; // the column location of the tile
    logic inc_i_tile_cnt;
    logic input_tile_row_max;
    assign input_tile_row_max = (input_tile_loc_row_cnt == (input_dim_padding_stride >> 3) - 1);
    logic input_tile_col_max;
    assign input_tile_col_max = (input_tile_loc_col_cnt == (input_dim_padding_stride >> (3 + $clog2(ARRAY_SIZE))) - 1);
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            input_tile_loc_row_cnt <= 0;
            input_tile_loc_col_cnt <= 0;
            output_tile_loc_col_cnt <= 0;
            output_tile_loc_row_cnt <= 0;
            output_tile_loc_chan_cnt <= 0;
        end
        else if (inc_i_tile_cnt) begin
            if (input_tile_row_max) begin
                input_tile_loc_row_cnt <= 0;
                if (input_tile_col_max) begin
                    input_tile_loc_col_cnt <= 0;
                end
                else begin
                    input_tile_loc_col_cnt <= input_tile_loc_col_cnt + 1;
                end
            end
            else begin
                input_tile_loc_row_cnt <= input_tile_loc_row_cnt + 1;
            end
        end
    end

    // tile row length and active PE number calculation
    always_ff @(posedge clk) begin
        if (input_tile_col_max) begin
            activated_FIFO_num <= stride2_en ? ((row_len - 1) >> 1) : (row_len - 2); // (FIFO - 1)*stride + 3 = row_len
            row_len <= stride2_en ? (input_dim_padding_stride[$clog2(ARRAY_SIZE)+3:3]) : (input_dim_padding_stride[$clog2(ARRAY_SIZE)+3-1:3]);
        end
        else begin
            activated_FIFO_num <= ARRAY_SIZE;
            row_len <= stride2_en ? 2*ARRAY_SIZE + 1 : ARRAY_SIZE + 2;
        end
    end

    logic [CONFIG_MEM_WIDTH-5:0] output_tile_loc_col_cnt; // the column location of the tile 
    logic [CONFIG_MEM_WIDTH-1:0] output_tile_loc_row_cnt; // the row location of the tile
    logic [CONFIG_MEM_WIDTH-1:0] output_tile_loc_chan_cnt; 

    // config_reg_addr loop counter
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            config_reg_addr <= 0;
        end
        else if (nxt_state==READ_STATS) begin
            if (config_reg_addr != 9) config_reg_addr <= config_reg_addr + 1;
            else config_reg_addr <= 0;
        end
    end

    // Tile row filling counter, either move 1 row or 2 rows
    logic [CONFIG_MEM_WIDTH-1:0] mover_row_cnt;
    logic init_row_cnt;
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            mover_row_cnt <= 0;
        end
        else if (clr_tile_mover) begin
            mover_row_cnt <= 0;
        end
        else if (init_row_cnt) begin
            if (state==INIT) begin
                mover_row_cnt <= 3;
                base_addr_rd_tile_mover <= input_offset;
            end
            else begin
                mover_row_cnt <= input_dim_padding_stride[0] ? 2 : 1;
            end
        end
        else if (tile_mover_done) begin
            if (mover_row_cnt != 0)  begin
                if (~pad_all) begin
                    base_addr_rd_tile_mover <= base_addr_rd_tile_mover + input_row_stride_reg;
                end
                mover_row_cnt <= mover_row_cnt - 1;
            end
        end
    end

    // weight reading address logic
    logic clr_weight_addr;
    logic inc_weight_addr;
    logic shift_weight_addr;
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            weight_rd_addr <= 0;
        end
        else if (clr_weight_addr) begin
            weight_rd_addr <= 0;
        end
        else if (shift_weight_addr) begin
            weight_rd_addr <= weight_rd_addr - (cnt_fed_top_reg >> 4);
        end
        else if (inc_weight_addr) begin
            weight_rd_addr <= weight_rd_addr + 1;
        end
    end

    // FIFO filling counter
    logic [9:0] cnt_fed; // how many times FIFO is fed without clr/writeback
    logic inc_cnt_fed;
    logic clr_cnt_fed;
    logic fed_done;
    assign fed_done = (cnt_fed == cnt_fed_top_reg);
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

    // systolic array status logic
    logic compute_done;
    assign compute_done = (cnt == cnt_fed_top_reg);

    // TODO: tile mover select logic
    assign reuse_en = (img2col_rd_addr > stride)
    assign tile_mover_select = (state==FILL_TILE || );

    // padding logic (pad all not included)
    assign pad_first_col = pad_all ? 0 : (input_tile_loc_col_cnt==0 || input_tile_col_max) ? input_dim_padding_stride[1:0] : 0;
    assign pad_all = (input_tile_loc_row_cnt==0) ? (mover_row_cnt > 3 - input_dim_padding_stride[1:2]) : (input_tile_row_max) ? (mover_row_cnt <= input_dim_padding_stride[1:2]) : 0;

    // FSM
    always_comb begin
        state = nxt_state;
        rd_config_info = 0;
        // clear signals
        clr_systolic = 0;
        clr_img2col = 0;
        clr_output_proc = 0;
        clr_tile_mover = 0;
        clr_write_back = 0;
        clr_weight_addr = 0;
        clr_cnt_fed = 0;
        // start signals
        start_systolic = 0;
        start_img2col = 0;
        start_output_proc = 0;
        start_tile_mover = 0;
        start_write_back = 0;
        // other siganls
        init_row_cnt = 0;
        pad_all = 0;
        pad_first_col = 0;
        inc_weight_addr = 0;
        shift_weight_addr = 0;
        inc_cnt_fed = 0;
        weight_rd = 0;
        img2col_rd = 0;
        case (state)
            IDLE: begin
                rd_config_info = 1;
                if (reg_data_ff[0]) begin
                    nxt_state = READ_STATS;
                end
            end
            READ_STATS: begin
                rd_config_info = 1;
                if (config_reg_addr==0) begin
                    rd_config_info = 0;
                    nxt_state = INIT;
                    clr_systolic = 1;
                    clr_img2col = 1;
                    clr_output_proc = 1;
                    clr_tile_mover = 1;
                    clr_write_back = 1;
                end
            end
            INIT: begin
                start_tile_mover = 1;
                init_row_cnt = 1;
                clr_weight_addr = 1;
                nxt_state = FILL_TILE;
            end
            FILL_TILE: begin
                if (mover_row_cnt==0) begin
                    nxt_state = FILL_FIFO;
                    start_img2col = 1;
                    clr_tile_mover = 1;
                    clr_cnt_fed = 1;
                    weight_rd = 1;
                end
            end
            FILL_FIFO: begin
                weight_rd = 1;
                if (&{full_w, full_i}) begin
                    nxt_state = COMPUTING;
                    start_systolic = 1;
                end
                else if (img2col_data_rdy_out) begin
                    {wren_w, wren_i} = '1;
                    inc_weight_addr = 1;
                    inc_cnt_fed = 1;
                    img2col_rd = 1;
                end
            end
            COMPUTING:
                weight_rd = 1;
                if (fed_done & compute_done) begin
                    nxt_state = OUTPUT_PROC;
                    inc_i_tile_cnt = 1;
                    start_output_proc = 1;
                end
                else if (~(|{full_w, full_i}) && (~fed_done)) begin // when none of them is full and we haven't fed all the data
                    if (data_rdy_in) begin
                        {wren_w, wren_i} = '1;
                        img2col_rd = 1;
                        inc_weight_addr = 1;
                        inc_cnt_fed = 1;
                    end
                end
            OUTPUT_PROC: begin
                if (output_processing_done) begin
                    nxt_state = WRITE_BACK;
                    clr_systolic = 1;
                    clr_img2col = 1;
                    clr_cnt_fed = 1;
                    start_write_back = 1;
                end
                else if (output_proc_systolic_out_consumed) begin
                    nxt_state = FILL_FIFO;

                end
            end
        endcase
    end

endmodule