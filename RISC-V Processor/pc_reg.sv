module pc_reg (q, d, clk, rst);

    output logic        q;
    input logic        d;
    input logic         clk;
    input logic         rst;

    reg            state;

    assign q = state;

// change to triggered on posedge edge
    always @(posedge clk) begin
      state = rst? 0 : d;
    end
endmodule