/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: \riscv.srcs\sources_1\imports\riscv_core\alu_ctrl.v
 * Description: ALU Control 模块，输入3位ALUop，{func[5]+func3}，输出4位控制信号区分各指令执行什么操作
 * 
 */

`include "defines.v"

module alu_ctrl(

    input       [4:0] func  , //{func7[5]+func7[0]+func3}决定各指令具体操作，添加M指令集后需要增加func[0]来判断
    input       [2:0] ALUOp , //输入3位ALUop
    output reg  [4:0] ALU_ctl //输出5位控制信号区分各指令执行什么操作    
);

always@(*)begin
    case(ALUOp) //根据ALUOp和func3区分指令

    `R_ALUOp :begin
        case(func[2:0])//func3
            `ADD_SUB_MUL_func: begin //ADD、SUB、MUL指令fun3相同，需要进一步区分
                case(func[4:3])
                2'b00:ALU_ctl = `ALU_ADD; //执行ADD操作
                2'b10:ALU_ctl = `ALU_SUB; //执行SUB操作
                2'b01:ALU_ctl = `ALU_MUL; //执行MUL操作
                default:ALU_ctl = 5'd0;
                endcase
                end
            `SLL_MULH_func : begin
                if(func[3] == 1'b0)    //SRL和SRA指令fun3相同，需要进一步区分
                    ALU_ctl = `ALU_SLL ; //执行SLL 操作
                else 
                    ALU_ctl = `ALU_MULH; //执行MULH操作
	            end
            `SLT_MULHSU_func : begin
                if(func[3] == 1'b0)   
                    ALU_ctl = `ALU_SLT ; //执行SLT 操作
                else 
                    ALU_ctl = `ALU_MULHSU; //执行MULHSU操作
	            end
            `SLTU_MULHU_func: begin
                if(func[3] == 1'b0)   
                    ALU_ctl = `ALU_SLTU; //执行SLTU操作
                else 
                    ALU_ctl = `ALU_MULHU; //执行MULHU操作
	            end
            `XOR_DIV_func : begin
                if(func[3] == 1'b0)   
                    ALU_ctl = `ALU_XOR ; //执行XOR 操作
                else 
                    ALU_ctl = `ALU_DIV; //执行DIV操作
	            end
	        `SRL_SRA_DIVU_func:begin 
                case(func[4:3])
                2'b00:ALU_ctl = `ALU_SRL; //执行SRL操作
                2'b10:ALU_ctl = `ALU_SRA; //执行SRA操作
                2'b01:ALU_ctl = `ALU_DIVU; //执行DIVU操作
                default:ALU_ctl = 5'd0;
                endcase
            end
            `OR_REM_func  : begin
                if(func[3] == 1'b0)   
                    ALU_ctl = `ALU_OR  ; //执行OR  操作
                else 
                    ALU_ctl = `ALU_REM; //执行REM操作
	            end
            `AND_REMU_func :begin
                if(func[3] == 1'b0)   
                    ALU_ctl = `ALU_AND ; //执行AND 操作
                else 
                    ALU_ctl = `ALU_REMU; //执行REMU操作
	            end   
            default  : ALU_ctl = 5'd0;
        endcase
        end
    `I_ALUOp :begin
            case(func[2:0]) 
            `ADDI_func     : ALU_ctl = `ALU_ADD ;  //执行ADD 操作
            `SLTI_func     : ALU_ctl = `ALU_SLT ;  //执行SLT 操作
            `SLTIU_func    : ALU_ctl = `ALU_SLTU;  //执行SLTU操作
            `XORI_func     : ALU_ctl = `ALU_XOR ;  //执行XOR 操作
            `ORI_func      : ALU_ctl = `ALU_OR  ;  //执行OR  操作
            `ANDI_func     : ALU_ctl = `ALU_AND ;  //执行AND 操作
            `SLLI_func     : ALU_ctl = `ALU_SLL ;  //执行SLL 操作
            `SRLI_SRAI_func: begin
		if(func[4] == 1'b0)    //SRLI和SRAI指令fun3相同，需要func7[5]进一步区分
                    ALU_ctl = `ALU_SRL; //执行SRLI操作
                else 
                    ALU_ctl = `ALU_SRA; //执行SRAI操作
	     end
            default  : ALU_ctl = 4'd0;
    endcase
        end

    `LS_ALUOp:begin
            ALU_ctl = `ALU_ADD; //执行ADD操作
        end

    `B_ALUOp :begin  //进一步区分B型指令
            case(func[2:0])
            `BEQ_func : ALU_ctl = `ALU_BEQ  ;
            `BNE_func : ALU_ctl = `ALU_BNE  ;
            `BLT_func : ALU_ctl = `ALU_BLT  ;
            `BGE_func : ALU_ctl = `ALU_BGE  ;
            `BLTU_func: ALU_ctl = `ALU_BLTU ;
            `BGEU_func: ALU_ctl = `ALU_BGEU ;
            default  : ALU_ctl = 4'd0   ;        
    endcase
        end

    `J_ALUOp   : ALU_ctl = `ALU_Jtype   ; //J型指令rd = PC+4;  

    `LUI_ALUOp  : ALU_ctl = `ALU_LUI    ; //LUI指令rd = imm<<12;

    `AUIPC_ALUOp: ALU_ctl = `ALU_AUIPC  ; //AUIPC指令rd = PC+(imm<<12);

    default  : ALU_ctl = 4'd0;

endcase
end
endmodule
