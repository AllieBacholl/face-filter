// Fixed memory addressing for RISC-V memory structure
// Every 32-bit word occupies four unique addresses

module memory2c (data_out, data_in, addr, length, sign, enable, wr, createdump, clk, rst);

   output wire [31:0] data_out;
   input wire [31:0]  data_in;
   input wire [31:0]  addr;
   input wire [1:0]   length;
   input wire         sign;
   input wire         enable;
   input wire         wr;
   input wire         createdump;
   input wire         clk;
   input wire         rst;

   wire [31:0]        data_temp_0;
   wire [31:0]        data_temp_1;
   wire [31:0]        data_temp_2;
   
   reg [7:0]          mem [0:65535];
   reg                loaded;
   reg [16:0]         largest;

   integer            mcd;
   
   wire [15:0]        mem_addr;
   
   // Use only the lower 16 bits of the address to access the memory array
   assign mem_addr = addr[15:0];

   // Load byte (lb, lbu)
   assign data_temp_0 = enable & (~wr) ? 
                        sign ? {{24{mem[mem_addr][7]}}, mem[mem_addr]} : 
                               {24'b0, mem[mem_addr]} : 32'b0;

   // Load half-word (lh, lhu)
   assign data_temp_1 = enable & (~wr) ?
                        sign ? {{16{mem[mem_addr + 1][7]}}, mem[mem_addr + 1], mem[mem_addr]} :
                               {16'b0, mem[mem_addr + 1], mem[mem_addr]} : 32'b0;

   // Load word (lw)
   assign data_temp_2 = enable & (~wr) ?
                        {mem[mem_addr + 3], mem[mem_addr + 2], mem[mem_addr + 1], mem[mem_addr]} : 32'b0;
      
   assign data_out = (length == 2'b00) ? data_temp_0 : 
                     (length == 2'b01) ? data_temp_1 : 
                     (length == 2'b10) ? data_temp_2 : 32'b0;

   initial begin
      loaded = 0;
      largest = 0;
   end

   always @(negedge clk) begin
      if (rst) begin
         // first init to 0, then load loadfile_all.img
         if (!loaded) begin
           // $readmemh("loadfile_all.img", mem);
            loaded = 1;
         end
      end
      else begin
         if (enable & wr) begin
            if (length == 2'b00) begin
                // Store byte (sb)
                mem[mem_addr] = data_in[7:0];
                if (mem_addr > largest) largest = mem_addr;
            end else if (length == 2'b01) begin
                // Store half-word (sh)
                mem[mem_addr] = data_in[7:0];
                mem[mem_addr+1] = data_in[15:8];
                if (mem_addr+1 > largest) largest = mem_addr+1;
            end else if (length == 2'b10) begin
                // Store word (sw)
                mem[mem_addr] = data_in[7:0];
                mem[mem_addr+1] = data_in[15:8];
                mem[mem_addr+2] = data_in[23:16];
                mem[mem_addr+3] = data_in[31:24];
                if (mem_addr+3 > largest) largest = mem_addr+3;
            end
         end
         //if (createdump) begin
            //mcd = $fopen("dumpfile", "w");
            // for (i=0; i<=largest+1; i=i+1) begin
            //    $fdisplay(mcd,"%4h %2h", i, mem[i]);
            // end
            //$fclose(mcd);
         //end
      end
   end

endmodule