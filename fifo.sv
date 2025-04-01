module FIFO
#(
  parameter DEPTH=8,
  parameter DATA_WIDTH=8
)
(
  input  clk,
  input  rst_n,
  input  rden,
  input  wren,
  input  [DATA_WIDTH-1:0] i_data,
  output [DATA_WIDTH-1:0] o_data,
  output full,
  output empty
);

parameter cnt_width = $clog2(DEPTH);
logic [cnt_width:0] cnt;
logic [cnt_width-1:0] rptr;
logic [cnt_width-1:0] wptr;
logic [DATA_WIDTH-1:0] o_data_in;

logic [DATA_WIDTH-1:0] FIFO [DEPTH-1:0];

assign full = (cnt==DEPTH) ? 1'b1 : 1'b0;
assign empty = (cnt==0) ? 1'b1 : 1'b0;
assign o_data = o_data_in;

always_ff @(posedge clk, negedge rst_n) begin
  if (rst_n==1'b0) begin
    cnt <= 0;
    rptr <= 0;
    wptr <= 0;
  end
  else if (wren==1'b1 && !full && rden==1'b1 && !empty) begin
    cnt <= cnt;
    FIFO[wptr] <= i_data;
    o_data_in <= FIFO[rptr];
    if (wptr == DEPTH-1) wptr <= 0;
    else wptr <= wptr + 1;
    if (rptr == DEPTH-1) rptr <= 0;
    else rptr <= rptr + 1;
  end
  else begin
    if (wren==1'b1 && !full) begin
      FIFO[wptr] <= i_data;
      cnt <= cnt + 1;
      if (wptr == DEPTH-1) wptr <= 0;
      else wptr <= wptr + 1;
    end
    if (rden==1'b1 && !empty) begin
      o_data_in <= FIFO[rptr];
      cnt <= cnt - 1;
      if (rptr == DEPTH-1) rptr <= 0;
      else rptr <= rptr + 1;
    end 
  end
end


endmodule