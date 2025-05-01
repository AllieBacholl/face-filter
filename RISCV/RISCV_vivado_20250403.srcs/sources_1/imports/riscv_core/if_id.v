/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: if_id.v
 * Description: IF/ID流水线寄存器堆模块，将指令地址、指令打一拍输出
 * 
 */

module if_id(
    input  clk                  ,
    input  rst_n                ,
    input  clear                ,
    input  stall                ,
    input  [31:0] inst_i        ,
    input  [31:0] inst_addr_i   ,
    output [31:0] inst_o        ,
    output [31:0] inst_addr_o

);

dff #(32) dff_inst1 (clk,rst_n,clear,stall,inst_addr_i,inst_addr_o)   ;
dff #(32) dff_inst2 (clk,rst_n,clear,stall,inst_i,inst_o)             ;

endmodule
