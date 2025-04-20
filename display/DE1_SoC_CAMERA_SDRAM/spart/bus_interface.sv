module bus_interface (
   input logic          iocs,
   input logic          iorw,
   input logic          rda,
   input logic          tbr,
   input logic    [1:0] ioaddr,
   input logic    [7:0] receive_read_line,
   output logic         receive_read_en,
   output logic   [7:0] write_line,
   output logic         transmit_write_en,
   output logic         baud_write_en,
   output logic         baud_write_location,
   inout logic    [7:0] databus
   );

   // Intermediate signals
   logic [7:0] read_data;

   // Logic for handling ownership of the databus signal
   assign databus = iocs ? (iorw ? read_data : 8'bz) : 8'bz;
   assign read_data = ioaddr[0] ? {6'h00, tbr, rda} : receive_read_line;
   assign write_line = databus;

   always_comb begin
      receive_read_en = 1'b0;
      transmit_write_en = 1'b0;
      baud_write_en = 1'b0;
      // 0 is lower, 1 is upper 8 bits
      baud_write_location = 1'b0;

      if (ioaddr == 2'b00 && iocs == 1'b1) begin
         if (iorw) begin
            receive_read_en = 1'b1;
         end
         else begin
            transmit_write_en = 1'b1;
         end
      end

      else if (ioaddr == 2'b01 && iocs == 1'b1) begin
         // Nothing to enable
      end

      else if (ioaddr == 2'b10 && iocs == 1'b1) begin
         baud_write_en = 1'b1;
         baud_write_location = 1'b0;
      end

      else if (ioaddr == 2'b11 && iocs == 1'b1) begin
         baud_write_en = 1'b1;
         baud_write_location = 1'b1;
      end

      else begin
         // Default do nothing since CS is low
      end
   end


endmodule