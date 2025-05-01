module Register (clk, reset, writeEnable, dataIn, dataOut);

    parameter WIDTH = 32;  // Default width is 16 bits

    input clk, reset;
    input writeEnable;
    input [WIDTH-1:0] dataIn;
    output [WIDTH-1:0] dataOut;

    wire [WIDTH-1:0] nextData;
    assign nextData = writeEnable ? dataIn : dataOut;

    dff_proc flipFlopArray [WIDTH-1:0] (.clk(clk), .rst(reset), .d(nextData), .q(dataOut));

endmodule