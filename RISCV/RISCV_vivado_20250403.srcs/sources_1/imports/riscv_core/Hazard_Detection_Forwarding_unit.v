/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: Hazard_Detection_Forwarding_unit.v
 * Description: 冒险检测与前递单元
 * 
 */
module Hazard_Detection_Forwarding_unit(
    //for EX/MEM 冒险
    input      [4:0] id_ex_rs1          ,
    input      [4:0] id_ex_rs2          ,
    input      [4:0] ex_mem_rd          ,
    input            ex_mem_regwrite    ,
    input      [4:0] mem_wb_rd          ,
    input            mem_wb_regwrite    ,
    output reg [1:0] forwardA           ,
    output reg [1:0] forwardB           ,
    //for Load-use 冒险
    input            memread            ,
    input      [4:0] if_id_rs1          ,
    input      [4:0] if_id_rs2          ,
    input      [4:0] id_ex_rd           , 
    output reg       pc_hold            ,
    output reg       if_id_hold         ,
    output reg       id_ex_clear         
);

always@(*)begin
    if(ex_mem_regwrite == 1'b1 && ex_mem_rd != 5'b0 && ex_mem_rd == id_ex_rs1)  //EX冒险
        forwardA = 2'b10;
    else if(mem_wb_regwrite == 1'b1 && mem_wb_rd != 5'b0 && 
            !(ex_mem_regwrite == 1'b1 && ex_mem_rd != 5'b0 && ex_mem_rd == id_ex_rs1) &&
            mem_wb_rd == id_ex_rs1) //MEM冒险
            forwardA = 2'b01;
        else 
            forwardA = 2'b00;
end
always@(*)begin
    if(ex_mem_regwrite == 1'b1 && ex_mem_rd != 5'b0 && ex_mem_rd == id_ex_rs2)  //EX冒险
        forwardB = 2'b10;
    else if(mem_wb_regwrite == 1'b1 && mem_wb_rd != 5'b0 && 
            !(ex_mem_regwrite == 1'b1 && ex_mem_rd != 5'b0 && ex_mem_rd == id_ex_rs2) &&
            mem_wb_rd == id_ex_rs2) //MEM冒险
            forwardB = 2'b01;
        else 
            forwardB = 2'b00;
end
always @(*) begin
    if(memread == 1'b1)begin //load-use型冒险
        if(if_id_rs1 == id_ex_rd || if_id_rs2 == id_ex_rd)begin
            pc_hold     = 1'b1;
            if_id_hold  = 1'b1;
            id_ex_clear = 1'b1;
        end
    end
    else begin
        pc_hold     = 1'b0;
        if_id_hold  = 1'b0;
        id_ex_clear = 1'b0;
    end
end
endmodule
