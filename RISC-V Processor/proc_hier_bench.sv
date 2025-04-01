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
wire rst;

integer inst_count;
integer trace_file;
integer sim_log_file;

proc_hier DUT();

initial begin
      rst = 1;
      #20
      rst = 0;
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
            end else if (MemRead) begin
               // ld
               $fdisplay(trace_file,"INUM: %8d PC: 0x%04x REG: %d VALUE: 0x%04x ADDR: 0x%04x",
                         (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData,
                        MemAddress);
            end else begin
               $fdisplay(trace_file,"INUM: %8d PC: 0x%04x REG: %d VALUE: 0x%04x",
                         (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData );
            end
         end else begin // if (RegWrite)
            if (MemWrite) begin
               // st
               $fdisplay(trace_file,"INUM: %8d PC: 0x%04x ADDR: 0x%04x VALUE: 0x%04x",
                         (inst_count-1),
                        PC,
                        MemAddress,
                        MemData);
            end else begin
               // conditional branch or NOP
               // Need better checking in pipelined testbench
               inst_count = inst_count + 1;
               $fdisplay(trace_file, "INUM: %8d PC: 0x%04x",
                         (inst_count-1),
                         PC );
            end
         end 
      end
      
   end

   assign rst = DUT.p0.rst;
   assign PC = DUT.p0.fetch.pc;
    assign Inst = DUT.p0.fetch.instr;
    assign RegWrite = DUT.p0.decode.reg_write_WB;
    assign WriteRegister = DUT.p0.decode.rd_WB;
    assign WriteData = DUT.p0.decode.writeData;
    assign MemRead = DUT.p0.memory.mem_write_en_MEM;
    assign MemWrite = DUT.p0.memory.mem_read_en_MEM;
    assign MemAddress = DUT.p0.memory.alu_result_MEM;
    assign MemData = DUT.p0.memory.write_data_MEM;
    

endmodule