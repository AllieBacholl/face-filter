module pc_reg (q, d, clk, rst, stall);

    output logic        q;
    input logic        d;
    input logic         clk;
    input logic         rst;
    input logic         stall;

    reg            state;

    assign q = state;

// change to triggered on posedge edge
    always @(posedge clk) begin
      if (stall) begin
        state <= state;
      end
      else
      state <= rst? 0 : d;
    end
endmodule