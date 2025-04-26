/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: ex_mem.v
 * Description: ex/mem模块
 * 
 */
module ex_mem(
    //input
    input         clk               ,
    input         rst_n             ,
    input         clear             ,
    input         stall             ,
    input         memtoreg          ,
    input         regwrite          ,
    input         memread           ,
    input         memwrite          ,
    input  [2:0]  mem_op            ,
    input         jump              ,
    input  [31:0] alu_result        ,
    input  [31:0] mux5_result       ,
    input  [4:0]  rd                ,
    //output
    output        memtoreg_line3    ,
    output        regwrite_line3    ,
    output        memread_line3     ,
    output        memwrite_line3    ,
    output [2:0]  mem_op_line3      ,
    output        jump_line3        ,
    output [31:0] alu_result_line3  ,
    output [31:0] mux5_result_line3 ,
    output [4:0]  rd_line3          
);

dff #(1 ) dff_inst1  (clk, rst_n, clear, stall, memtoreg   , memtoreg_line3   );
dff #(1 ) dff_inst2  (clk, rst_n, clear, stall, regwrite   , regwrite_line3   );
dff #(1 ) dff_inst4  (clk, rst_n, clear, stall, memread    , memread_line3    );
dff #(1 ) dff_inst5  (clk, rst_n, clear, stall, memwrite   , memwrite_line3   );
dff #(3 ) dff_inst6  (clk, rst_n, clear, stall, mem_op     , mem_op_line3     );
dff #(1 ) dff_inst8  (clk, rst_n, clear, stall, jump       , jump_line3       );
dff #(32) dff_inst9  (clk, rst_n, clear, stall, alu_result , alu_result_line3 );
dff #(32) dff_inst10 (clk, rst_n, clear, stall, mux5_result, mux5_result_line3);
dff #(5 ) dff_inst11 (clk, rst_n, clear, stall, rd         , rd_line3         );

endmodule
