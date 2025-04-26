module proc_hier_bench();

wire [31:0] PC;
wire [31:0] Inst;

wire RegWrite;
wire [2:0] WriteRegister;
wire [31:0] WriteData;
wire MemWrite;
wire MemRead;
wire [31:0] MemAddress;
wire [31:0] MemData;

wire rs1_data_ID, rs2_data_ID;

wire [4:0] rs1_ID, rs2_ID;

integer inst_count;
integer trace_file;
integer sim_log_file;

proc_hier DUT();

initial begin
      $display("Hello world...simulation starting");
      $display("See verilogsim.log and verilogsim.trace for output");
      inst_count = 0;
      trace_file = $fopen("verilogsim.trace");
      sim_log_file = $fopen("verilogsim.log");  
end


   always @ (posedge DUT.c0.clk) begin
      if (!DUT.c0.rst) begin
         if (RegWrite || MemWrite) begin
            inst_count = inst_count + 1;
         end
         $fdisplay(sim_log_file, "SIMLOG:: Cycle %d PC: %8x I: %8x R: %d %3d %8x M: %d %d %8x %8x",
                  DUT.c0.cycle_count,
                  PC,
                  Inst,
                  RegWrite,
                  WriteRegister,
                  WriteData,
                  MemRead,
                  MemWrite,
                  MemAddress,
                  MemData);

         $display("INUM: %8d PC: 0x%04x REG: %d VALUE: 0x%04x rs1: 0x%04x rs2: 0x%04x rs1_data_ID: 0x%04x rs2_data_ID: 0x%04x ADDR: 0x%04x MemData: 0x%04x",
                         (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData,
                        rs1_ID,
                        rs2_ID,
                        rs1_data_ID,
                        rs2_data_ID,
                        MemAddress,
                        MemData);
         
         // $display("SIMLOG:: Cycle %d PC: %8x I: %8x R: %d %3d %8x M: %d %d %8x %8x",
         // DUT.c0.cycle_count,
         // PC,
         // Inst,
         // RegWrite,
         // WriteRegister,
         // WriteData,
         // MemRead,
         // MemWrite,
         // MemAddress,
         // MemData);

         if (RegWrite) begin
            if (MemWrite) begin
               // stu
               $fdisplay(trace_file,"INUM: %8d PC: 0x%04x REG: %d VALUE: 0x%04x ADDR: 0x%04x VALUE: 0x%04x",
                         (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData,
                        MemAddress,
                        MemData);

            $display("INUM: %8d PC: 0x%04x REG: %d VALUE: 0x%04x ADDR: 0x%04x VALUE: 0x%04x",
                  (inst_count-1),
                  PC,
                  WriteRegister,
                  WriteData,
                  MemAddress,
                  MemData);

            $display("      ");

            end else if (MemRead) begin
               // ld
               $fdisplay(trace_file,"INUM: %8d PC: 0x%04x REG: %d VALUE: 0x%04x ADDR: 0x%04x",
                         (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData,
                        MemAddress);
                $display("INUM: %8d PC: 0x%04x REG: %d VALUE: 0x%04x rs1_data_ID: 0x%04x rs2_data_ID: 0x%04x ADDR: 0x%04x",
                         (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData,
                        rs1_data_ID,
                        rs2_data_ID,
                        MemAddress);
               
                  $display("      ");

            
            end else begin
               $fdisplay(trace_file,"INUM: %8d PC: 0x%04x REG: %d VALUE: 0x%04x",
                         (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData );

               $display("INUM: %8d PC: 0x%04x REG: %d VALUE: 0x%04x",
                         (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData );
               $display("      ");
            end
         end else begin // if (RegWrite)
            if (MemWrite) begin
               // st
               $fdisplay(trace_file,"INUM: %8d PC: 0x%04x ADDR: 0x%04x VALUE: 0x%04x",
                         (inst_count-1),
                        PC,
                        MemAddress,
                        MemData);


                $display("INUM: %8d PC: 0x%04x ADDR: 0x%04x VALUE: 0x%04x",
                         (inst_count-1),
                        PC,
                        MemAddress,
                        MemData);

               $display("      ");
            end else begin
               // conditional branch or NOP
               // Need better checking in pipelined testbench
               inst_count = inst_count + 1;
               $fdisplay(trace_file, "INUM: %8d PC: 0x%04x",
                         (inst_count-1),
                         PC );

                $display("INUM: %8d PC: 0x%04x",
                         (inst_count-1),
                         PC );

               $display("      ");
            end
         end 
      end
      
   end

   
   assign PC = DUT.p0.fetch.pc;
    assign Inst = DUT.p0.fetch.instr;
    assign RegWrite = DUT.p0.decode.reg_write_WB;
    assign WriteRegister = DUT.p0.decode.rd_WB;
    assign WriteData = DUT.p0.decode.writeData;
    assign MemRead = DUT.p0.memory.mem_read_en_MEM;
    assign MemWrite = DUT.p0.memory.mem_write_en_MEM;
    assign MemAddress = DUT.p0.memory.alu_result_MEM;
    assign MemData = DUT.p0.memory.mem_data_MEM;

    assign rs1_data_ID = DUT.p0.decode.rs1_data_ID;
     assign rs2_data_ID = DUT.p0.decode.rs2_data_ID;
     assign rs1_ID = DUT.p0.decode.rs1_ID;
     assign rs2_ID = DUT.p0.decode.rs2_ID;
    

endmodule