/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: regs.v
 * Description: 寄存器堆模块，存放32个寄存器
 * 
 */
module regs(
    input clk,
    input rst_n,
    
    //from id
    input [4:0] rs1_addr_i  ,
    input [4:0] rs2_addr_i  ,

    //to id
    output reg[31:0] rs1_data_o ,
    output reg[31:0] rs2_data_o ,

    //from ex
    input [4:0] rd_addr_i   ,
    input [31:0] rd_data_i  ,
    input regwrite
);

reg [31:0] regs[0:31];
integer i;

//写入rd
always @(*) begin
    if(rst_n != 1'b0 && regwrite && rd_addr_i != 5'b0)
            regs[rd_addr_i] <= rd_data_i;
end

//读出rs1
always @(*) begin
    if(rst_n == 1'b0 || rs1_addr_i == 5'b0)
        rs1_data_o = 32'b0;
    else if(rs1_addr_i != 5'b0) //写入寄存器不是x0 
        rs1_data_o = regs[rs1_addr_i];
end

//读出rs2
always @(*) begin
    if(rst_n == 1'b0 || rs2_addr_i == 5'b0)
        rs2_data_o = 32'b0;
    else if(rs2_addr_i != 5'b0)  //写入寄存器不是x0 
        rs2_data_o = regs[rs2_addr_i];
end

endmodule
