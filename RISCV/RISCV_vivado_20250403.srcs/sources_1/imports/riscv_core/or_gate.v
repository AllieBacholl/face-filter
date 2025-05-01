/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: or_gate.v
 * Description: 二输入或门
 * 
 */
module or_gate(
    input data1,
    input data2,
    output data_out
);
assign data_out = data1 | data2;
endmodule
