module register (clk, reset, writeEnable, dataIn, dataOut);

    parameter WIDTH = 32;  // Default width is 16 bits

    input clk, reset;
    input writeEnable;
    input [WIDTH-1:0] dataIn;
    output [WIDTH-1:0] dataOut;

    wire [WIDTH-1:0] nextData;
    assign nextData = writeEnable ? dataIn : dataOut;

    dff flipFlopArray [WIDTH-1:0] (.clk(clk), .rst(reset), .d(nextData), .q(dataOut));

endmodule