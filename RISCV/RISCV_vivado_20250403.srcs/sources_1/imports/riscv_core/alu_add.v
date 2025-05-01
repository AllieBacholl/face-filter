/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: alu_add.v
 * Description: add模块实现加法
 * 
 */
module alu_add(
    input [31:0] data1,
    input [31:0] data2 ,
    output [31:0] data_out
);

assign data_out = data1 + data2;

endmodule
