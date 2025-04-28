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
reg [3:0]  byte_en; // added byte enable
wire [31:0] r_data; 
wire [31:0] addr_offset;
assign addr_offset = addr; //地址偏移量

//SB、SH、SW写入数据
always @(*) begin
    if(wen == 1'b1)
        case(mem_op)
            `SB_TYPE: begin             
                // if(addr_offset[1:0] == 2'b00)  
                //     w_data = {24'd0, w_data_i[7:0]};
                // else if (addr_offset[1:0] == 2'b01)
                //     w_data = {16'd0, w_data_i[7:0],8'd0};
                // else if (addr_offset[1:0] == 2'b10)
                //     w_data = {8'd0, w_data_i[7:0],16'd0};
                // else if (addr_offset[1:0] == 2'b11)
                //     w_data = {w_data_i[7:0],24'd0};
                //     else 
                //     w_data = 32'd0;
                if(addr_offset[1:0] == 2'b00)  begin
                    w_data = {24'd0, w_data_i[7:0]};
                    byte_en = 4'b0001;
                end
                else if (addr_offset[1:0] == 2'b01) begin
                    w_data = {16'd0, w_data_i[7:0],8'd0};
                    byte_en = 4'b0010;
                end
                else if (addr_offset[1:0] == 2'b10) begin
                    w_data = {8'd0, w_data_i[7:0],16'd0};
                    byte_en = 4'b0100;
                end
                else if (addr_offset[1:0] == 2'b11) begin
                    w_data = {w_data_i[7:0],24'd0};
                    byte_en = 4'b1000;
                end
                else begin
                    w_data = 32'd0;  
                    byte_en = 4'b0000;
                end
            end

            `SH_TYPE: begin
                if(addr_offset[1:0] == 2'b00) begin
                    w_data = {16'd0,w_data_i[15:0]};
                    byte_en = 4'b0011;
                end
                else if(addr_offset[1:0] == 2'b10) begin
                    w_data = {w_data_i[15:0],16'd0};
                    byte_en = 4'b1100;
                end
                else begin
                    w_data = 32'd0;
                    byte_en = 4'b0000;
                end
            end

            `SW_TYPE: begin
                w_data = w_data_i; 
                byte_en = 4'b1111;
            end
            default: begin
                w_data = 32'd0;
                byte_en = 4'b1111;
            end
        endcase
    else begin
        w_data = 32'd0;
        byte_en = 4'b0000;
    end
end

//LB、LH、LW、LBU、LHU加载数据
always @(*) begin
    if(ren == 1'b1)
        case(mem_op)
            `LB_TYPE:begin
                if(addr_offset[1:0]== 2'b00) //根据addr[1:0]加载不同字节
                    r_data_o = {{24{r_data[7]}},r_data[7:0]};
                else if(addr_offset[1:0]== 2'b01)
                    r_data_o = {{24{r_data[15]}},r_data[15:8]};
                else if(addr_offset[1:0]== 2'b10)
                    r_data_o = {{24{r_data[23]}},r_data[23:16]};
                else if(addr_offset[1:0]== 2'b11)
                    r_data_o = {{24{r_data[31]}},r_data[31:24]};
                else
                    r_data_o = 32'd0;
            end
            `LH_TYPE:begin
                if(addr_offset[1:0] == 2'b00)
                    r_data_o = {{16{r_data[15]}},r_data[15:0]}; 
                else if(addr_offset[1:0] == 2'b10)
                    r_data_o = {{16{r_data[31]}},r_data[31:16]}; 
                else 
                    r_data_o = 32'd0;  
            end
            `LW_TYPE:begin
                    r_data_o = r_data; 
            end
            `LBU_TYPE:begin
                if(addr_offset[1:0]== 2'b00)
                    r_data_o = {24'd0,r_data[7:0]};
                else if(addr_offset[1:0]== 2'b01)
                    r_data_o = {24'd0,r_data[15:8]};
                else if(addr_offset[1:0]== 2'b10)
                    r_data_o = {24'd0,r_data[23:16]};
                else if(addr_offset[1:0]== 2'b11)
                    r_data_o = {24'd0,r_data[31:24]};
                else
                    r_data_o = 32'd0;
            end
            `LHU_TYPE:begin
                if(addr_offset[1:0] == 2'b00)
                    r_data_o = {16'd0,r_data[15:0]}; 
                else if(addr_offset[1:0] == 2'b10)
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
    .byte_en  (byte_en     ), // added byte enable
    .w_addr_i (addr_offset[$clog2(MEM_DEPTH)+1:2]   ),
    .w_data_i (w_data       ),
    .ren      (ren          ),
    .r_addr_i (addr_offset[$clog2(MEM_DEPTH)+1:2]   ),
    .r_data_o (r_data       )
);

endmodule
