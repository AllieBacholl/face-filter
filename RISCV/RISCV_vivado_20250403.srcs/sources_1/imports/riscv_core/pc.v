/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: pc.v
 * Description: PC程序计数器模块，打一拍将指令地址输出
 * 
 */
module pc(
    input             clk           ,
    input             rst_n         ,
    input             pc_hold       ,
    input      [31:0] inst_addr_i   ,
    output reg [31:0] inst_addr_o
);

always @(posedge clk) begin
    if(!rst_n)
        inst_addr_o <= -32'd4; //复位也可以是32'd0，为了波形上好区分，这是用-32'd4
	//inst_addr_o <= 32'd0;
    else if(pc_hold == 1'b1)
            inst_addr_o <= inst_addr_o; //PC暂停
         else 
            inst_addr_o <= inst_addr_i;
end

endmodule
