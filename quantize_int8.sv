module quantize_int8 (
    input  signed [31:0] x_32,          // 32-bit input (accumulated MAC result)
    input  signed [31:0] scale,         // Fixed-point scale in Q0.31
    input  signed [31:0] zero_point,    // Zero-point to add after scaling
    output logic signed [7:0] x_8       // Final quantized 8-bit output
);

    logic signed [63:0] product;
    logic signed [31:0] scaled_value;
    logic signed [31:0] rounded_value;
    logic signed [31:0] requantized_value;

    // Multiply input by scale (Q0.31 * int32)
    assign product = x_32 * scale;

    // Extract Q0.31 top bits → shift right 31 (rounded to nearest)
    assign scaled_value = product[62:31];
    assign rounded_value = (product[30] == 1'b1) ? scaled_value + 1 : scaled_value;

    // Add zero point to shift into 8-bit quantized space
    assign requantized_value = rounded_value + zero_point;

    // Clamp to int8 range
    always_comb begin
        if (requantized_value > 127)
            x_8 = 127;
        else if (requantized_value < -128)
            x_8 = -128;
        else
            x_8 = requantized_value[7:0];
    end

endmodule
