module dff (q, d, clk, rst);

    output logic        q;
    input logic        d;
    input logic         clk;
    input logic         rst;

    reg            state;

    assign q = state;

    always @(posedge clk) begin
      state = rst? 0 : d;
    end
endmodule