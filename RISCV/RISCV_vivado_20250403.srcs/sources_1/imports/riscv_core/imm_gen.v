/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: \riscv.srcs\sources_1\imports\riscv_core\imm_gen.v
 * Description: 立即数扩展单元，将指令中的立即数扩展�?32�?
 * 
 */

  `include "../riscv_core/defines.v"

module imm_gen(
    input      [31:0] data_in ,  //输入指令
    output reg [31:0] data_out   //输出立即数扩�?(字符扩展)
);

always@(*)begin
    case(data_in[6:0]) 
        `LUI_OP,`AUIPC_OP       : data_out = {data_in[31:12], 12'd0}                                                             ;
        `JAL_OP                 : data_out = {{11{data_in[31]}}, data_in[31], data_in[19:12],  data_in[20], data_in[30:21], 1'b0}; 
        `B_OP                   : data_out = {{19{data_in[31]}}, data_in[31], data_in[7], data_in[30:25], data_in[11:8], 1'b0}   ;      
        `S_OP                   : data_out = {{20{data_in[31]}}, data_in[31:25], data_in[11:7]}                                  ;   
        `LD_OP,`JALR_OP,`I_OP   : data_out = {{20{data_in[31]}}, data_in[31:20] }                                                ;
        default            : data_out = 32'b0;    
endcase
end
endmodule
