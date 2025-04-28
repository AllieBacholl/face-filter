/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: mux3.v
 * Description: 三选一多选器
 * 
 */
module mux3(
    input      [1:0]sel         ,
    input      [31:0] data_in1  ,
    input      [31:0] data_in2  ,
    input      [31:0] data_in3  ,
    output reg [31:0] data_out

);

always @(*) begin
    case(sel)
        2'b00: data_out = data_in1 ;
        2'b01: data_out = data_in2 ;
        2'b10: data_out = data_in3 ;
        default: data_out = 32'h0  ;
    endcase   
end

endmodule