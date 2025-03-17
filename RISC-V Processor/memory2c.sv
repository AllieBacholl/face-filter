/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
//////////////////////////////////////
//
// Memory -- single cycle version
//
// written for CS/ECE 552, Spring '07
// Pratap Ramamurthy, 19 Mar 2006
//
// This is a byte-addressable,
// 16-bit wide, 64K-byte memory.
//
// All reads happen combinationally with zero delay.
// All writes occur on rising clock edge.
// Concurrent read and write not allowed.
//
// On reset, memory loads from file "loadfile_all.img".
// (You may change the name of the file in
// the $readmemh statement below.)
// File format:
//     @0
//     <hex data 0>
//     <hex data 1>
//     ...etc
//
// If input "createdump" is true on rising clock,
// contents of memory will be dumped to
// file "dumpfile", from location 0 up through
// the highest location modified by a write.
//
//
//////////////////////////////////////
`default_nettype none
module memory2c (data_out, data_in, addr, length, sign, enable, wr, createdump, clk, rst);

   output  [31:0] data_out;
   input wire [31:0]   data_in;
   input wire [31:0]   addr;
   input wire [1:0]   length;
   input wire         sign;
   input wire         enable;
   input wire         wr;
   input wire         createdump;
   input wire         clk;
   input wire         rst;

   wire [31:0]    data_out;
   wire [31:0]    data_temp_0;
   wire [31:0]    data_temp_1;
   wire [31:0]    data_temp_2;
   
   reg [7:0]      mem [0:65535];
   reg            loaded;
   reg [16:0]     largest;

   integer        mcd;
   integer        i;


   assign data_temp_0 = (enable & (~wr)) ? ((sign) ? {24{mem[addr[7:0]][8]}, mem[addr[7:0]]} : {24'b0, mem[addr[7:0]]}) : 32'b0;
   assign data_temp_1 = (enable & (~wr)) ? ((sign) ? {16{mem[addr[15:0]][8]}, mem[addr[15:0]], mem[addr[15:0]+8'h1]} : {16'b0, mem[addr[15:0]], mem[addr[15:0]+8'h1]}) : 32'b0;
   assign data_temp_2 = (enable & (~wr)) ? ({mem[addr],mem[addr+8'h1],mem[addr+8'h2],mem[addr+8'h3]}) : 32'b0;
      
   assign data_out = (length == 2'b01) ? data_temp_0 : (length == 2'b10) ? data_temp_1 : (length == 2'b11) ? data_temp_2 : 32'b0;

   initial begin
      loaded = 0;
      largest = 0;
      for (i = 0; i< 65536; i=i+1) begin
         mem[i] = 8'd0;
      end
   end

   always @(posedge clk) begin
      if (rst) begin
         // first init to 0, then load loadfile_all.img
         if (!loaded) begin
            $readmemh("loadfile_all.img", mem);
            loaded = 1;
         end
      end
      else begin
         if (enable & wr) begin
            if (length == 2'b01) begin
                mem[addr[7:0]] = data_in[7:0];    // The actual write
                if ({1'b0, addr} > largest) largest = addr;  // avoid negative numbers
            end else if (length == 2'b10) begin
                mem[addr[15:0]] = data_in[15:8];       // The actual write
                mem[addr[15:0]+1] = data_in[7:0];      // The actual write
                if ({1'b0, addr} > largest) largest = addr;  // avoid negative numbers
            end else if (length == 2'b11) begin
                mem[addr] = data_in[31:24];        // The actual write
                mem[addr+1] = data_in[23:16];      // The actual write
                mem[addr+2] = data_in[15:8];       // The actual write
                mem[addr+3] = data_in[7:0];        // The actual write
                if ({1'b0, addr} > largest) largest = addr;  // avoid negative numbers
            end else begin

            end
         end
         if (createdump) begin
            mcd = $fopen("dumpfile", "w");
            for (i=0; i<=largest+1; i=i+1) begin
               $fdisplay(mcd,"%4h %2h", i, mem[i]);
            end
            $fclose(mcd);
         end
      end
   end

endmodule  // memory2c
`default_nettype wire
// DUMMY LINE FOR REV CONTROL :0: