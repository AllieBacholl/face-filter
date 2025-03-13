module PE 
#(
    parameter DATA_WIDTH=8
) 
(
    input [DATA_WIDTH-1:0] A,
    input [DATA_WIDTH-1:0] B,
    input en,
    input clk,
    input rst_n,
    input clr,
    output reg [4*DATA_WIDTH-1:0] Out,
    output reg en_out,
    output reg [DATA_WIDTH-1:0] A_out,
    output reg [DATA_WIDTH-1:0] B_out
);
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            A_out <= 0;
            B_out <= 0;
            en_out <= 0;
            Out <= 0;
        end
        else if (clr) begin
            A_out <= 0;
            B_out <= 0;
            en_out <= 0;
            Out <= 0;
        end
        else if (en) begin
            Out <= Out + A*B;
            en_out <= 1;
            A_out <= A;
            B_out <= B;
        end
        else begin
            en_out <= 0;
        end
        
    end
endmodule