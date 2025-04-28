/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: iram.v
 * Description: 
 * 
 */

module iram #(
    parameter DW        = 32,
    parameter MEM_DEPTH = 1024 //2^10
)
(
    input  [31:0] r_addr_i  ,
    output [31:0] r_data_o
);
    
reg[DW-1:0] mem[0:MEM_DEPTH-1]; 

assign r_data_o = mem[r_addr_i[$clog2(MEM_DEPTH)+1:2]];

endmodule