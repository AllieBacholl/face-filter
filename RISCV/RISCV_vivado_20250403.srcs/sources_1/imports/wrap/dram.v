/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: dram.v
 * Description: 
 * 
 */

`include "../riscv_core/defines.v"

module dram #(
    parameter DW        = 32   , 
    parameter MEM_DEPTH = 1024               
)(
    input             clk      ,
    input      [2:0]  mem_op   , 
    input             wen      ,
    input             ren      ,
    input      [31:0] addr     , 
    input      [31:0] w_data_i , 
    output reg [31:0] r_data_o   
);

reg [31:0] w_data; 
wire [31:0] r_data; 

//SB、SH、SW写入数据
always @(*) begin
    if(wen == 1'b1)
        case(mem_op)
            `SB_TYPE: begin             
                if(addr[1:0] == 2'b00)  
                    w_data = {24'd0, w_data_i[7:0]};
                else if (addr[1:0] == 2'b01)
                    w_data = {16'd0, w_data_i[7:0],8'd0};
                else if (addr[1:0] == 2'b10)
                    w_data = {8'd0, w_data_i[7:0],16'd0};
                else if (addr[1:0] == 2'b11)
                    w_data = {w_data_i[7:0],24'd0};
                    else 
                    w_data = 32'd0;
            end

            `SH_TYPE: begin
                if(addr[1:0] == 2'b00)
                    w_data = {16'd0,w_data_i[15:0]};
                else if(addr[1:0] == 2'b10)
                    w_data = {w_data_i[15:0],16'd0};
                else 
                    w_data = 32'd0;
            end

            `SW_TYPE: w_data = w_data_i; 
            default: w_data = 32'd0;
        endcase
    else 
        w_data = 32'd0;
end

//LB、LH、LW、LBU、LHU加载数据
always @(*) begin
    if(ren == 1'b1)
        case(mem_op)
            `LB_TYPE:begin
                if(addr[1:0]== 2'b00) //根据addr[1:0]加载不同字节
                    r_data_o = {{24{r_data[7]}},r_data[7:0]};
                else if(addr[1:0]== 2'b01)
                    r_data_o = {{24{r_data[15]}},r_data[15:8]};
                else if(addr[1:0]== 2'b10)
                    r_data_o = {{24{r_data[23]}},r_data[23:16]};
                else if(addr[1:0]== 2'b11)
                    r_data_o = {{24{r_data[31]}},r_data[31:24]};
                else
                    r_data_o = 32'd0;
            end
            `LH_TYPE:begin
                if(addr[1:0] == 2'b00)
                    r_data_o = {{16{r_data[15]}},r_data[15:0]}; 
                else if(addr[1:0] == 2'b10)
                    r_data_o = {{16{r_data[31]}},r_data[31:16]}; 
                else 
                    r_data_o = 32'd0;  
            end
            `LW_TYPE:begin
                    r_data_o = r_data; 
            end
            `LBU_TYPE:begin
                if(addr[1:0]== 2'b00)
                    r_data_o = {24'd0,r_data[7:0]};
                else if(addr[1:0]== 2'b01)
                    r_data_o = {24'd0,r_data[15:8]};
                else if(addr[1:0]== 2'b10)
                    r_data_o = {24'd0,r_data[23:16]};
                else if(addr[1:0]== 2'b11)
                    r_data_o = {24'd0,r_data[31:24]};
                else
                    r_data_o = 32'd0;
            end
            `LHU_TYPE:begin
                if(addr[1:0] == 2'b00)
                    r_data_o = {16'd0,r_data[15:0]}; 
                else if(addr[1:0] == 2'b10)
                    r_data_o = {16'd0,r_data[31:16]}; 
                else 
                    r_data_o = 32'd0;  
            end
            default:r_data_o = 32'd0;
        endcase
    else
        r_data_o = 32'd0;
end

dual_ram 
#(
    .DW        (DW          ),
    .MEM_DEPTH (MEM_DEPTH   )
)
u_dual_ram(
    .clk      (clk          ),
    .wen      (wen          ),
    .w_addr_i (addr[$clog2(MEM_DEPTH)+1:2]   ),
    .w_data_i (w_data       ),
    .ren      (ren          ),
    .r_addr_i (addr[$clog2(MEM_DEPTH)+1:2]   ),
    .r_data_o (r_data       )
);

endmodule
