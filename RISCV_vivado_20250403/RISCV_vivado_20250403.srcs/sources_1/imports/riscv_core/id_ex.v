/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: id_ex.v
 * Description: id/ex模块
 * 
 */
module id_ex(
    input        clk        ,
    input        rst_n      ,
    input        clear      ,
    input        stall      ,
    input        memtoreg   ,
    input        regwrite   ,
    input        memread    ,
    input        memwrite   ,
    input [2:0]  mem_op     ,
    input [2:0]  aluop      ,
    input        alusrc     ,
    input        pc_rs1_sel ,
    input [31:0] pc_i       ,
    input [31:0] rs1_data_i ,
    input [31:0] rs2_data_i ,
    input [31:0] imm_gen_i  ,
    input [4:0]  func_i     ,
    input [4:0] rs1_line1   ,
    input [4:0] rs2_line1   ,
    input [4:0] rd_line1    ,

    output        memtoreg_line2    ,
    output        regwrite_line2    ,
    output        memread_line2     ,
    output        memwrite_line2    ,
    output [2:0]  mem_op_line2      ,
    output [2:0]  aluop_line2       ,
    output        alusrc_line2      ,
    output        pc_rs1_sel_line2  ,

    output [31:0] pc_line2          ,
    output [31:0] rs1_data_line2    ,
    output [31:0] rs2_data_line2    ,
    output [31:0] imm_gen_line2     ,
    output [4:0]  func_line2        ,
    output [4:0]  rs1_line2         ,
    output [4:0]  rs2_line2         ,
    output [4:0]  rd_line2       

);

dff #(1 ) dff_inst1  (clk, rst_n, clear, stall, memtoreg      , memtoreg_line2          );
dff #(1 ) dff_inst2  (clk, rst_n, clear, stall, regwrite      , regwrite_line2          );
dff #(1 ) dff_inst4  (clk, rst_n, clear, stall, memread       , memread_line2           );
dff #(1 ) dff_inst5  (clk, rst_n, clear, stall, memwrite      , memwrite_line2          );
dff #(3 ) dff_inst6  (clk, rst_n, clear, stall, mem_op        , mem_op_line2            );
dff #(3 ) dff_inst7  (clk, rst_n, clear, stall, aluop         , aluop_line2             );
dff #(1 ) dff_inst8  (clk, rst_n, clear, stall, alusrc        , alusrc_line2            );
dff #(1 ) dff_inst9  (clk, rst_n, clear, stall, pc_rs1_sel    , pc_rs1_sel_line2        );
dff #(32) dff_inst14 (clk, rst_n, clear, stall, pc_i          , pc_line2                );
dff #(32) dff_inst15 (clk, rst_n, clear, stall, rs1_data_i    , rs1_data_line2          );
dff #(32) dff_inst16 (clk, rst_n, clear, stall, rs2_data_i    , rs2_data_line2          );
dff #(32) dff_inst17 (clk, rst_n, clear, stall, imm_gen_i     , imm_gen_line2           );
dff #(5 ) dff_inst18 (clk, rst_n, clear, stall, func_i        , func_line2              );
dff #(5 ) dff_inst19 (clk, rst_n, clear, stall, rs1_line1     , rs1_line2               );
dff #(5 ) dff_inst20 (clk, rst_n, clear, stall, rs2_line1     , rs2_line2               );
dff #(5 ) dff_inst21 (clk, rst_n, clear, stall, rd_line1      , rd_line2                );

endmodule
