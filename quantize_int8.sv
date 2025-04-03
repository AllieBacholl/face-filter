module quantize_int8 (
    input  logic signed [31:0] x_32,  // 32-bit input number
    input  logic signed [31:0] scale, // Scaling factor (precomputed as fixed-point)
    output logic signed [7:0]  x_8    // Quantized 8-bit output
);
    
    logic signed [31:0] scaled_value;
    logic signed [31:0] rounded_value;

    // Scale the input
    assign scaled_value = x_32 * scale; // Integer division for fixed-point scaling

    // Rounding: Add 0.5 before truncating (assuming scale is a power of 2)
    assign rounded_value = (scaled_value >= 0) ? (scaled_value + 1) >> 1 : (scaled_value - 1) >> 1;

    // Clamping to INT8 range (-128 to 127)
    always_comb begin
        if (rounded_value > 127) 
            x_8 = 127;
        else if (rounded_value < -128)
            x_8 = -128;
        else 
            x_8 = rounded_value[7:0]; // Take the lowest 8 bits
    end

endmodule
