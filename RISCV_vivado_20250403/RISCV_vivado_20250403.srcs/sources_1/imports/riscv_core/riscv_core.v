/*** 
 * Author: Stephen Dai
 * 教程链接：https://blog.csdn.net/weixin_45774715/category_12433521.html
 * FilePath: \riscv.srcs\sources_1\imports\riscv_core\riscv_core.v
 * Description: RISCV_core
 * 
 */
module riscv_core(
    //input
    input         clk           ,
    input         rst_n         ,
    input  [31:0] inst_i        , //instructions from iram
    input  [31:0] data_from_dram, //data from dram
    //output
    output [2:0]  mem_op_out    , //mem_op，to distinguish between S and L type instructions
    output [31:0]  iram_addr    , //PC
    output        dram_wen      , 
    output        dram_ren      , 
    output [31:0]  dram_addr    , 
    output [31:0] data_to_dram    
        
);
//===============================================================================
//Signal declaration
//===============================================================================

//*************************The first level of the pipeline IF *******************
//mux1
wire [31:0] mux1_out        ;

//add1
wire [31:0] add1_out        ;

//pc
wire [31:0] pc_o            ;

//if_id
wire [31:0] inst_line1      ;
wire [31:0] inst_addr_line1 ;

//*************************The second level of the pipeline ID *******************
//main ctrl before mux
wire [11:0] ctrl_bus_out;

//mux2
wire [11:0] mux2_out    ;

//ctrl after mux2
wire       memtoreg     ;
wire       regwrite     ;
wire       memread      ;
wire       memwrite     ;
wire [2:0] mem_op       ;
wire [2:0] aluop        ;
wire       alusrc       ;
wire       pc_rs1_sel   ;


//regesters
wire [31:0] rs1_data_o  ;
wire [31:0] rs2_data_o  ;

//imm_gen
wire [31:0] imm_gen_out ;

//or gate 
wire or_out;

//id_ex
wire        memtoreg_line2   ;
wire        regwrite_line2   ;
wire        memread_line2    ;
wire        memwrite_line2   ;
wire [2:0]  mem_op_line2     ;
wire [2:0]  aluop_line2      ;
wire        alusrc_line2     ;
wire        pc_rs1_sel_line2 ;
wire [31:0] pc_line2         ;
wire [31:0] rs1_data_line2   ;
wire [31:0] rs2_data_line2   ;
wire [31:0] imm_gen_line2    ;
wire [4:0]  func_line2       ;
wire [4:0]  rs1_line2        ;
wire [4:0]  rs2_line2        ;
wire [4:0]  rd_line2         ;

//*************************The third level of the pipeline EX *******************
//mux3
wire [31:0] mux3_out    ;

//mux4
wire [31:0] mux4_out    ;

//mux5
wire [31:0] mux5_out    ;

//mux6
wire [31:0] mux6_out    ;

//add2
wire [31:0] add2_out    ;

//ALU_ex
wire [31:0] alu_result  ;
wire jump               ;

//ALU control
wire [4:0] ALU_ctl; 

//ex_mem
wire        memtoreg_line3    ;
wire        regwrite_line3    ;
wire        memread_line3     ;
wire        memwrite_line3    ;
wire [2:0]  mem_op_line3      ;
wire [31:0] add2_result_line3 ;
wire        jump_line3        ;
wire [31:0] alu_result_line3  ;
wire [31:0] mux5_result_line3 ;
wire [4:0]  rd_line3          ;

//*************************The fourth level of the pipeline MEM *****************

//mem_wb
wire        memtoreg_line4   ;
wire        regwrite_line4   ;
wire [31:0] dram_out_line4   ;
wire [31:0] alu_result_line4 ;
wire [4:0]  rd_line4         ;

//*************************The fifth level of the pipeline WB *******************
//mux7
wire [31:0] mux7_out;

//jump_ctrl_unit
wire if_id_clear   ; 
wire id_ex_clear_1 ;
wire ctrl_clear    ;
wire pc_sel        ;

//Hazard_Detection_Forwarding_unit
wire [1:0] forwardA ;
wire [1:0] forwardB ;
wire pc_hold        ;
wire if_id_hold     ;
wire id_ex_clear_2  ;

//==============================================================================
//Main code
//==============================================================================

//********************************* The output signal ***************************
assign iram_addr  = pc_o                ;
assign dram_ren   = memread_line3       ;
assign dram_wen   = memwrite_line3      ;
assign mem_op_out = mem_op_line3        ;
assign dram_addr  = alu_result_line3    ;
assign data_to_dram  = mux5_result_line3;
//*************************The first level of the pipeline IF *******************
mux2 #(
    .DW(32)
)
mux2_inst1(
    .sel      (pc_sel           ),
    .data_in1 (add1_out         ),
    .data_in2 (add2_out         ),
    .data_out (mux1_out         )
);

pc u_pc(
    .clk         (clk         ),
    .rst_n       (rst_n       ),
    .pc_hold     (pc_hold     ),
    .inst_addr_i (mux1_out    ),
    .inst_addr_o (pc_o )
);


alu_add add1(
    .data1    (32'd4   ),
    .data2    (pc_o    ),
    .data_out (add1_out)
);

if_id u_if_id(   
    .clk         (clk             ),
    .rst_n       (rst_n           ),
    .clear       (if_id_clear     ), 
    .stall       (if_id_hold      ), //来自hazard_detction_fowarding_unit
    .inst_i      (inst_i          ), //来自外设iram
    .inst_addr_i (pc_o            ),
    .inst_o      (inst_line1      ),
    .inst_addr_o (inst_addr_line1 )
);

//*************************The second level of the pipeline ID *******************
main_ctrl u_main_ctrl(
    .inst_opcode  (inst_line1[6:0]  ),
    .func3        (inst_line1[14:12]),
    .ctrl_bus_out (ctrl_bus_out     ) //控制信号总线
);

mux2 #(
    .DW(12)
)
mux2_inst2(
    .sel      (ctrl_clear   ),
    .data_in1 (ctrl_bus_out ),
    .data_in2 (12'd0        ),
    .data_out (mux2_out     )
);

assign memtoreg   = mux2_out[11]    ;
assign regwrite   = mux2_out[10]    ;
assign memread    = mux2_out[9]     ;
assign memwrite   = mux2_out[8]     ;
assign mem_op     = mux2_out[7:5]   ;
assign aluop      = mux2_out[4:2]   ;
assign alusrc     = mux2_out[1]     ;
assign pc_rs1_sel = mux2_out[0]     ;

regs u_regs(
    .clk        (clk                ),
    .rst_n      (rst_n              ),
    .rs1_addr_i (inst_line1[19:15]  ),
    .rs2_addr_i (inst_line1[24:20]  ),
    .rs1_data_o (rs1_data_o         ),
    .rs2_data_o (rs2_data_o         ),
    .rd_addr_i  (rd_line4           ),
    .rd_data_i  (mux7_out           ),
    .regwrite   (regwrite_line4            )
);

imm_gen u_imm_gen(
    .data_in  (inst_line1  ),
    .data_out (imm_gen_out )
);

or_gate u_or_gate(
    .data1    (id_ex_clear_1    ), //from jump_ctrl_unit
    .data2    (id_ex_clear_2    ), //from hazard_detction_fowarding_unit 
    .data_out (or_out           )
);

id_ex u_id_ex(
    //input
    .clk              (clk                  ),
    .rst_n            (rst_n                ),
    .clear            (or_out               ), 
    .stall            (1'b0                 ),
    .memtoreg         (memtoreg             ),
    .regwrite         (regwrite             ),
    .memread          (memread              ),
    .memwrite         (memwrite             ),
    .mem_op           (mem_op               ),
    .aluop            (aluop                ),
    .alusrc           (alusrc               ),
    .pc_rs1_sel       (pc_rs1_sel           ),
    .pc_i             (inst_addr_line1      ),
    .rs1_data_i       (rs1_data_o           ),
    .rs2_data_i       (rs2_data_o           ),
    .imm_gen_i        (imm_gen_out          ),
    .func_i           ({inst_line1[30],inst_line1[25],inst_line1[14:12]} ),
    .rs1_line1        (inst_line1[19:15]    ),
    .rs2_line1        (inst_line1[24:20]    ),
    .rd_line1         (inst_line1[11:7]     ),
    //output
    .memtoreg_line2   (memtoreg_line2       ),
    .regwrite_line2   (regwrite_line2       ),
    .memread_line2    (memread_line2        ),
    .memwrite_line2   (memwrite_line2       ),
    .mem_op_line2     (mem_op_line2         ),
    .aluop_line2      (aluop_line2          ),
    .alusrc_line2     (alusrc_line2         ),
    .pc_rs1_sel_line2 (pc_rs1_sel_line2     ),
    .pc_line2         (pc_line2             ),
    .rs1_data_line2   (rs1_data_line2       ),
    .rs2_data_line2   (rs2_data_line2       ),
    .imm_gen_line2    (imm_gen_line2        ),
    .func_line2       (func_line2           ),
    .rs1_line2        (rs1_line2            ),
    .rs2_line2        (rs2_line2            ),
    .rd_line2         (rd_line2             )
);

//*************************The third level of the pipeline EX *******************
mux2 
#(
    .DW (32 )
)
mux2_inst3(
    .sel      (pc_rs1_sel_line2 ),
    .data_in1 (pc_line2         ),
    .data_in2 (mux4_out         ),
    .data_out (mux3_out         )
);

mux3 mux3_inst4(
    .sel      (forwardA         ),  
    .data_in1 (rs1_data_line2   ),
    .data_in2 (mux7_out         ),
    .data_in3 (alu_result_line3 ), 
    .data_out (mux4_out         )
);

mux3 mux3_inst5(
    .sel      (forwardB         ),
    .data_in1 (rs2_data_line2   ),
    .data_in2 (mux7_out         ),
    .data_in3 (alu_result_line3 ),
    .data_out (mux5_out         )
);

mux2 #(
    .DW(32)
)
mux2_inst6(
    .sel      (alusrc_line2 ),
    .data_in1 (mux5_out     ),
    .data_in2 (imm_gen_line2),
    .data_out (mux6_out     )
);

alu_add add2(
    .data1    (mux3_out     ),
    .data2    (imm_gen_line2),
    .data_out (add2_out     )
);

alu_ex u_alu_ex(
    //input
    .data1      (mux4_out   ),
    .data2      (mux6_out   ),
    .ALU_ctl    (ALU_ctl    ),
    .pc         (pc_line2   ),
    //output
    .ALU_result (alu_result ),
    .jump       (jump       )
);

alu_ctrl u_alu_ctrl(
    .func    (func_line2    ),
    .ALUOp   (aluop_line2   ),
    .ALU_ctl (ALU_ctl       )
);

ex_mem u_ex_mem(
    //input
    .clk               (clk               ),
    .rst_n             (rst_n             ),
    .clear             (1'b0              ),
    .stall             (1'b0              ),
    .memtoreg          (memtoreg_line2    ),
    .regwrite          (regwrite_line2    ),
    .memread           (memread_line2     ),
    .memwrite          (memwrite_line2    ),
    .mem_op            (mem_op_line2      ),
    .jump              (jump              ),
    .alu_result        (alu_result        ),
    .mux5_result       (mux5_out          ),
    .rd                (rd_line2          ),
    //output
    .memtoreg_line3    (memtoreg_line3    ),
    .regwrite_line3    (regwrite_line3    ),
    .memread_line3     (memread_line3     ),
    .memwrite_line3    (memwrite_line3    ),
    .mem_op_line3      (mem_op_line3      ),
    .jump_line3        (jump_line3        ),
    .alu_result_line3  (alu_result_line3  ),
    .mux5_result_line3 (mux5_result_line3 ),
    .rd_line3          (rd_line3          )
);

//*************************The fourth level of the pipeline MEM *****************


mem_wb u_mem_wb(
    //input
    .clk              (clk              ),
    .rst_n            (rst_n            ),
    .clear            (1'b0             ),
    .stall            (1'b0             ),
    .memtoreg         (memtoreg_line3   ),
    .regwrite         (regwrite_line3   ),
    .dram_out_i       (data_from_dram   ), //来自dram
    .alu_result_i     (alu_result_line3 ),
    .rd_i             (rd_line3         ),
    //output
    .memtoreg_line4   (memtoreg_line4   ),
    .regwrite_line4   (regwrite_line4   ),
    .dram_out_line4   (dram_out_line4   ),
    .alu_result_line4 (alu_result_line4 ),
    .rd_line4         (rd_line4         )
);

//*************************The fifth level of the pipeline WB *******************
mux2 
#(
    .DW (32 )
)
mux2_inst7(
    .sel      (memtoreg_line4   ),
    .data_in1 (dram_out_line4   ),
    .data_in2 (alu_result_line4 ),
    .data_out (mux7_out         )
);


//************************************** jump_ctrl_unit ************************
jump_ctrl_unit u_jump_ctrl_unit(
    //input
    .jump        (jump          ),
    //output
    .if_id_clear (if_id_clear   ), 
    .id_ex_clear (id_ex_clear_1 ), 
    .ctrl_clear  (ctrl_clear    ),
    .pc_sel      (pc_sel        )
);



//*********************************** Hazard_Detection_Forwarding_unit ************************
Hazard_Detection_Forwarding_unit u_Hazard_Detection_Forwarding_unit(
    //input
    .id_ex_rs1       (rs1_line2         ),
    .id_ex_rs2       (rs2_line2         ),
    .ex_mem_rd       (rd_line3          ),
    .ex_mem_regwrite (regwrite_line3    ),
    .mem_wb_rd       (rd_line4          ),
    .mem_wb_regwrite (regwrite_line4    ),
    .memread         (memread_line2     ),
	.if_id_rs1       (inst_line1[19:15] ),
    .if_id_rs2       (inst_line1[24:20] ),
    .id_ex_rd        (rd_line2          ),
    //output
    .forwardA        (forwardA          ),
    .forwardB        (forwardB          ),
    .pc_hold         (pc_hold           ),
    .if_id_hold      (if_id_hold        ), 
    .id_ex_clear     (id_ex_clear_2     ) 
);

endmodule
