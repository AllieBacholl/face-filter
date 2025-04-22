module output_proc
#(
    parameter DATA_WIDTH = 8,
    parameter ARRAY_SIZE = 16
) (
    input clk, 
    input rst_n,
    input clr,
    input start, 
    input max_pooling_en, // only captured at the start, unless clear is set again this will be flushed
    input relu_en, // same as above
    input signed [31:0] scale, // Scaling factor (precomputed as fixed-point)
    input signed [31:0] zero_point, // zero_point
    input [4:0] activated_FIFO_num, // how many FIFOs are activated
    input signed [4*DATA_WIDTH-1:0] systolic_out [ARRAY_SIZE-1:0][ARRAY_SIZE-1:0],
    output logic [DATA_WIDTH-1:0] quant_systolic_out_pooled_final [ARRAY_SIZE-1:0][ARRAY_SIZE-1:0],
    output logic processing_done, // processing done signal
    output logic systolic_out_consumed
);
    logic [$clog2(ARRAY_SIZE)-1:0] cnt_quant;
    logic [$clog2(ARRAY_SIZE)-1:0] cnt_quant_ff;
    logic [2:0] batch_label; // 3-bit batch label, if the last bit is 1 and second bit is 0, third bit is 1, it means pooling is ready
    logic quantizing;
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            quantizing <= 0;
            systolic_out_consumed <= 0;
            batch_label <= 0;
        end
        else if (clr) begin
            quantizing <= 0;
            systolic_out_consumed <= 0;
            batch_label <= 0;
        end
        else if (start) begin
            quantizing <= 1;
            systolic_out_consumed <= 0;
        end
        else if (cnt_quant == activated_FIFO_num - 1) begin
            quantizing <= 0;
            systolic_out_consumed <= 1;
            batch_label <= {batch_label[1], batch_label[0], ~batch_label[0]};
        end
    end

    logic max_pooling_en_ff;
    logic relu_en_ff;
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            max_pooling_en_ff <= 0;
            relu_en_ff <= 0;
        end
        else if (clr) begin
            max_pooling_en_ff <= 0;
            relu_en_ff <= 0;
        end
        else if (start) begin
            max_pooling_en_ff <= max_pooling_en;
            relu_en_ff <= relu_en;
        end
    end

    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            cnt_quant <= 0;
            cnt_quant_ff <= 0;
        end
        else if (clr) begin
            cnt_quant <= 0;
            cnt_quant_ff <= 0;
        end
        else if (cnt_quant != activated_FIFO_num - 1 && quantizing) begin
            cnt_quant <= cnt_quant + 1;
            cnt_quant_ff <= cnt_quant;
        end
        else begin
            cnt_quant <= 0;
            cnt_quant_ff <= cnt_quant;
        end
    end

    // relu and select row
    logic [4*DATA_WIDTH-1:0] systolic_row_selected [ARRAY_SIZE-1:0];
    logic [DATA_WIDTH-1:0] quant_systolic_out [ARRAY_SIZE-1:0];
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            for (int i = 0; i < ARRAY_SIZE; i = i + 1) begin
                systolic_row_selected[i] <= 0;
            end
        end
        else if (clr) begin
            for (int i = 0; i < ARRAY_SIZE; i = i + 1) begin
                systolic_row_selected[i] <= 0;
            end
        end
        else if (quantizing) begin
            for (int i = 0; i < ARRAY_SIZE; i = i + 1) begin
                systolic_row_selected[i] <= (relu_en_ff & systolic_out[i][cnt_quant][4*DATA_WIDTH-1]) ? '0 : systolic_out[i][cnt_quant];
            end
        end
    end

    // Potential timing issue, 32*32 is slow
    quantize_int8 quant_array [ARRAY_SIZE-1:0] (
        .x_32(systolic_row_selected),   // 32-bit input (accumulated MAC result)
        .scale(scale),  // Fixed-point scale in Q0.31
        .zero_point(zero_point), // zero_point
        .x_8(quant_systolic_out)     // Quantized output
    );

    // first half of max pooling
    logic [DATA_WIDTH-1:0] quant_systolic_out_pooled [ARRAY_SIZE-1:0][ARRAY_SIZE-1:0];
    logic [DATA_WIDTH-1:0] quant_systolic_out_pooled_ff [ARRAY_SIZE-1:0][ARRAY_SIZE-1:0];
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            for (int j = 0; j < ARRAY_SIZE; j = j + 1) begin
                for (int i = 0; i < ARRAY_SIZE; i = i + 1) begin
                    quant_systolic_out_pooled[j][i] <= 0;
                    quant_systolic_out_pooled_ff[j][i] <= 0;
                end
            end
        end
        else if (clr) begin
            for (int j = 0; j < ARRAY_SIZE; j = j + 1) begin
                for (int i = 0; i < ARRAY_SIZE; i = i + 1) begin
                    quant_systolic_out_pooled[j][i] <= 0;
                    quant_systolic_out_pooled_ff[j][i] <= 0;
                end
            end
        end
        else if (max_pooling_en_ff) begin
            for (int i = 0; i < ARRAY_SIZE/2; i = i + 1) begin
                quant_systolic_out_pooled[i][cnt_quant_ff] <= (quant_systolic_out[2*i] > quant_systolic_out[2*i+1]) ? quant_systolic_out[2*i] : quant_systolic_out[2*i+1];
                quant_systolic_out_pooled_ff[i][cnt_quant_ff] <= quant_systolic_out_pooled[i][cnt_quant_ff];
            end
        end
        else begin
            for (int i = 0; i < ARRAY_SIZE; i = i + 1) begin
                quant_systolic_out_pooled[i][cnt_quant_ff] <= quant_systolic_out[i];
                quant_systolic_out_pooled_ff[i][cnt_quant_ff] <= quant_systolic_out_pooled[i][cnt_quant_ff];
            end
        end
    end

    // second half of max pooling
    logic set_done;
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            for (int j = 0; j < ARRAY_SIZE; j = j + 1) begin
                for (int i = 0; i < ARRAY_SIZE; i = i + 1) begin
                    quant_systolic_out_pooled_final[j][i] <= 0;
                end
            end
            set_done <= 0;
        end
        else if (clr) begin
            for (int j = 0; j < ARRAY_SIZE; j = j + 1) begin
                for (int i = 0; i < ARRAY_SIZE; i = i + 1) begin
                    quant_systolic_out_pooled_final[j][i] <= 0;
                end
            end
            set_done <= 0;
        end
        else if (max_pooling_en_ff && batch_label == 3'b010 && ~processing_done) begin
            for (int j = 0; j < ARRAY_SIZE; j = j + 1) begin
                for (int i = 0; i < ARRAY_SIZE/2; i = i + 1) begin
                    quant_systolic_out_pooled_final[i][j] <= (quant_systolic_out_pooled[i][j] > quant_systolic_out_pooled_ff[i][j]) ? quant_systolic_out_pooled[i][j] : quant_systolic_out_pooled_ff[i][j];
                end
            end
            set_done <= 1;
        end
        else if (~max_pooling_en_ff && ~processing_done) begin
            for (int j = 0; j < ARRAY_SIZE; j = j + 1) begin
                for (int i = 0; i < ARRAY_SIZE; i = i + 1) begin
                    quant_systolic_out_pooled_final[i][j] <= quant_systolic_out_pooled[i][j];
                end
            end
            set_done <= (cnt_quant == 0) && (cnt_quant_ff != 0);
        end
    end 

    // processing done signal
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            processing_done <= 0;
        end
        else if (clr) begin
            processing_done <= 0;
        end
        else if (start) begin
            processing_done <= 0;
        end
        else if (set_done) begin
            processing_done <= 1;
        end
    end
endmodule