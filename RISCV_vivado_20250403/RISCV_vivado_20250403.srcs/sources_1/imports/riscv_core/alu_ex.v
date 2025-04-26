/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: alu_ex.v
 * Description: 执行模块
 * 
 */

`include "defines.v"

module alu_ex(
    input  [31:0] data1     , 
    input  [31:0] data2     , 
    input  [4:0 ] ALU_ctl   ,
    input  [31:0] pc        , 

    output reg [31:0] ALU_result, 
    output reg jump 
);

//---------------------- 实现扩展指令集M添加的�?�辑 ----------------------//
wire [31:0] abs_data1 ;
wire [31:0] abs_data2 ;
assign abs_data1  = data1[31] ? (~data1 + 1) : data1; // data1 取绝对�?�，负数以补码形式参与运�?
assign abs_data2  = data2[31] ? (~data2 + 1) : data2; // data2 取绝对�??

reg  [31:0] abs_result      ; //data1 �? data2运算结果（无符号�?
reg  [63:0] abs_mul64_result; //data1 与data2 乘法结果（无符号�?
reg  [63:0] mul64_result    ; //data1 与data2 乘法结果（有符号�?
//---------------------- 实现扩展指令集M添加的�?�辑 ----------------------//

always@(*)begin
//for ALU result
    case(ALU_ctl)
    `ALU_ADD : ALU_result = data1 + data2               ;
    //`ALU_SUB : ALU_result = data1 - data2               ;
    `ALU_SUB : ALU_result = data1 + (~data2 + 1)        ; // 减法可�?�过加法和取反实�?
    `ALU_AND : ALU_result = data1 & data2               ;
    `ALU_OR  : ALU_result = data1 | data2               ;
    `ALU_XOR : ALU_result = data1 ^ data2               ;
    `ALU_SLL : ALU_result = data1 << data2[4:0]         ;  
    `ALU_SRL : ALU_result = data1 >> data2[4:0]         ;     
    //`ALU_SRA : ALU_result = $signed(data1) >>> data2[4:0];  
    `ALU_SRA : ALU_result = (data1[31] == 1) ? //负数高位�?1填充：生成符号位掩码，用按位或操�? | 补全高位
                        ((data1 >> data2[4:0]) | (32'hFFFFFFFF << (32 - data2[4:0]))) : 
                        (data1 >> data2[4:0]); 
    `ALU_SLT :begin 
        if(data1[31]==data2[31])begin //�?高位同号，其余位大则�?
            if(data1[30:0] < data2[30:0])
                ALU_result = 1'b1;
            else
                ALU_result = 1'b0;
        end
        else begin
            if(data1[31]==1) 
                ALU_result = 1'b1;
            else
                ALU_result = 1'b0;
        end
        end
    `ALU_SLTU:begin
        if(data1 < data2)     
            ALU_result = 1'b1;  
        else      
            ALU_result = 1'b0;  
        end
    `ALU_LUI   : ALU_result = data2              ; //LUI立即数已经在imm_gen中左移了
    `ALU_AUIPC : ALU_result = pc + data2         ; //AUIPC立即数已经在imm_gen中左移了
    `ALU_Jtype : ALU_result = pc + 4             ;
    `ALU_MUL   : ALU_result = data1 * data2      ; 
    `ALU_MULHU : begin
        mul64_result = data1 * data2;
        ALU_result = mul64_result[63:32];
        end
    `ALU_MULH  : begin
        abs_mul64_result = abs_data1 * abs_data2; //乘法结果（无符号�?
        mul64_result = (data1[31] ^ data2[31]) ? (~abs_mul64_result + 1) : abs_mul64_result;
        ALU_result = mul64_result[63:32];
        end
    `ALU_MULHSU: begin
        abs_mul64_result = abs_data1 * data2; //signed x unsigned 乘法结果（无符号�?
        mul64_result = (data1[31]) ? (~abs_mul64_result + 1) : abs_mul64_result;
        ALU_result = mul64_result[63:32];
        end
    `ALU_DIV: begin
        abs_result = abs_data1 / abs_data2; //除法结果（无符号�?
        if (data2 == 0) begin
            ALU_result = 32'hFFFFFFFF; // 除数�?0，结果定义为0xFFFFFFFF
        end else begin
            ALU_result = (data1[31] ^ data2[31]) ? (~abs_result + 1) : abs_result;
        end
        end
    `ALU_DIVU  : ALU_result = (data2 == 0) ? 32'hFFFFFFFF : data1 / data2; 
    `ALU_REM: begin
        abs_result = abs_data1 % abs_data2; //取余结果（无符号�?
        ALU_result = (data2 == 0) ? data1 : (data1[31] ? (~abs_result + 1) : abs_result); //结果与被取余数同�?
    end
    `ALU_REMU  : ALU_result = (data2 == 0) ? data1 : data1 % data2; 
    default: begin 
        ALU_result = 32'b0;
    end
endcase

//for jump signal
    case(ALU_ctl)   
    `ALU_Jtype: jump = 1'b1;
    `ALU_BEQ : jump = (data1 === data2) ? 1'b1 : 1'b0; //采用严格相等比较运算符，考虑 x �? z
    `ALU_BNE : jump = (data1 != data2) ? 1'b1 : 1'b0;
    `ALU_BGE : begin
        if(data1[31]==data2[31])begin
            if( (data1[30:0]>data2[30:0]) || (data1[30:0]==data2[30:0]))
                jump = 1'b1;
            else
                jump = 1'b0;
        end
        else begin 
		    if(data1[31]==0) //data1为正�?
                jump = 1'b1;
            else
                jump = 1'b0;
        end
    end

    `ALU_BGEU: jump = (data1 > data2 || data1 == data2) ? 1'b1 : 1'b0; 
    `ALU_BLT :begin
        if(data1[31]==data2[31])begin 
            if(data1[30:0] < data2[30:0])
                jump = 1'b1;
            else
                jump = 1'b0;
        end
        else begin
            if(data1[31]==1) 
                jump = 1'b1;
            else
                jump = 1'b0;
        end
    end
    `ALU_BLTU:begin
        if(data1 < data2)     
            jump = 1'b1;   
        else      
            jump = 1'b0;  
    end
    default: jump = 1'b0;
endcase

end
endmodule
