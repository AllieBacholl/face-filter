module quantize_int8 (
    input clk,               // Clock signal
    input rst_n,            // Active low reset
    input clr,              // Clear signal
    input  signed [31:0] x_32,   // 32-bit input (accumulated MAC result)
    input  signed [31:0] scale,  // Fixed-point scale in Q0.31
    output logic signed [7:0]  x_8     // Quantized output
);

    logic signed [63:0] product;
    logic signed [31:0] scaled_value;
    logic signed [31:0] rounded_value;

    // Multiply input by scale (Q0.31 * int32 → Q0.31 result in top 32 bits of product)
    assign product = x_32 * scale;

    // Rounding: Add 2^30 before shifting right by 31 (round nearest)
    assign scaled_value = product[62:31];  // Equivalent to >> 31
    assign rounded_value = (product[30] == 1'b1) ? scaled_value + 1 : scaled_value;

    // Clamp to int8 range
    always_comb begin
        if (rounded_value > 127)
            x_8 = 127;
        else if (rounded_value < -128)
            x_8 = -128;
        else
            x_8 = rounded_value[7:0];
    end

endmodule
