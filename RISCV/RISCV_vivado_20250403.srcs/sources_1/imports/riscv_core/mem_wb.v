/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: mem_wb.v
 * Description: mem/wb寄存器
 * 
 */
module mem_wb(
    //input
    input         clk               ,
    input         rst_n             ,
    input         clear             ,
    input         stall             ,
    input         memtoreg          ,
    input         regwrite          ,
    input  [31:0] dram_out_i        ,
    input  [31:0] alu_result_i      ,
    input  [4:0]  rd_i              ,
    //output
    output        memtoreg_line4    ,
    output        regwrite_line4    ,
    output [31:0] dram_out_line4    ,
    output [31:0] alu_result_line4  ,
    output [4:0]  rd_line4
);

dff #(1 ) dff_inst1 (clk, rst_n, clear, stall, memtoreg    , memtoreg_line4  );
dff #(1 ) dff_inst2 (clk, rst_n, clear, stall, regwrite    , regwrite_line4  );
dff #(32) dff_inst3 (clk, rst_n, clear, stall, dram_out_i  , dram_out_line4  );
dff #(32) dff_inst4 (clk, rst_n, clear, stall, alu_result_i, alu_result_line4);
dff #(5 ) dff_inst5 (clk, rst_n, clear, stall, rd_i        , rd_line4        );

endmodule