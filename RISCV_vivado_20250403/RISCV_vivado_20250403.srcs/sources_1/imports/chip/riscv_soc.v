/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: riscv_soc.v
 * Description: soc顶层模块
 * 
 */
module riscv_soc #(
    parameter IRAM_DW    = 32   , 
    parameter IRAM_DEPTH = 2048 ,  
    parameter DRAM_DW    = 32   , 
    parameter DRAM_DEPTH = 2048
)(
    input clk   ,
    input rst_n
);

//===============================================================================
//Signal declaration
//===============================================================================

//from riscv_core
wire [2:0]  mem_op_out  ;
wire [31:0] iram_addr   ; 
wire        dram_wen    ; 
wire        dram_ren    ; 
wire [31:0] dram_addr   ; 
wire [31:0] data_to_dram;   

//from iram
wire [31:0] iram_out    ;

//from dram
wire [31:0] dram_out    ;

//==============================================================================
//Main code
//===============================================================================

riscv_core u_riscv_core(
    //input
    .clk             (clk           ),
    .rst_n           (rst_n         ),
    .inst_i          (iram_out      ), 
    .data_from_dram  (dram_out      ), 
    //output    
    .mem_op_out      (mem_op_out    ), 
    .iram_addr       (iram_addr     ), 
    .dram_wen        (dram_wen      ), 
    .dram_ren        (dram_ren      ), 
    .dram_addr       (dram_addr     ), 
    .data_to_dram    (data_to_dram  )  
);

iram #(
    .DW        (IRAM_DW    ), 
    .MEM_DEPTH (IRAM_DEPTH )  
)u_iram(
    //input
    .r_addr_i (iram_addr),
    //ouptut
    .r_data_o (iram_out )
);

dram #(
    .DW        (DRAM_DW     ), 
    .MEM_DEPTH (DRAM_DEPTH  )  
)u_dram (
    //input
    .clk      (clk          ),
    .mem_op   (mem_op_out   ),
    .wen      (dram_wen     ),
    .ren      (dram_ren     ),
    .addr     (dram_addr    ),
    .w_data_i (data_to_dram ),
    //output
    .r_data_o (dram_out     )
);

endmodule
