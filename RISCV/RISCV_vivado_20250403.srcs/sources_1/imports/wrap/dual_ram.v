/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: dual_ram.v
 * Description: 双端口ram，可以同时读写
 * 
 */
module dual_ram #(
    parameter DW        = 32                    , 
    parameter MEM_DEPTH = 1024               
)(
    input                              clk      ,
    input                              wen      , 
    input      [$clog2(MEM_DEPTH)-1:0] w_addr_i , 
    input      [DW-1:0]                w_data_i , 
    input                              ren      , 
    input      [$clog2(MEM_DEPTH)-1:0] r_addr_i , 
    output reg [DW-1:0]                r_data_o   
);

reg[DW-1:0] mem[0:MEM_DEPTH-1]; 

always @(*) begin 
    if(ren)
        r_data_o = mem[r_addr_i]; 
end

always @(posedge clk) begin
    if(wen)
        mem[w_addr_i] <= w_data_i; 	
end

endmodule
