/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: mux2.v
 * Description: 二选一多选器
 * 
 */
module mux2 #(
    parameter DW = 32
)
(
    input sel                ,
    input  [DW-1:0] data_in1 ,
    input  [DW-1:0] data_in2 ,
    output [DW-1:0] data_out
);

assign data_out = (sel == 1'b1)? data_in2 : data_in1; 

endmodule