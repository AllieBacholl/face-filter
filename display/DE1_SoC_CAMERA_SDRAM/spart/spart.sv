//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:   
// Design Name: 
// Module Name:    spart 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module spart(
    input clk,
    input rst_n,
    input iocs,
    input iorw,
    output rda,
    output tbr,
    input [1:0] ioaddr,
    inout [7:0] databus,
    output txd,
    input rxd
    );

    // Intermediate Signals
    logic       transmit_write_en;
    logic       receive_read_en;
    logic       baud_write_en;
    logic       baud_write_location;
    logic       transmit_baud;
    logic       receive_baud;
    logic       transmit_start;
    logic       receive_start;
    logic [7:0] register_write_line;
    logic [7:0] receive_read_line;

    // Module instantiations
    transmit transmit0
    (
        .clk(clk),
        .rst_n(rst_n),
        .transmit_baud(transmit_baud),
        .transmit_write_en(transmit_write_en),
        .transmit_write_line(register_write_line),
        .transmit_start(transmit_start),
        .txd(txd),
        .tbr(tbr)
    );

    receive receive0
    (
        .clk(clk),
        .rst_n(rst_n),
        .rxd(rxd),
        .receive_baud(receive_baud),
        .receive_read_en(receive_read_en),
        .receive_start(receive_start),
        .rda(rda),
        .receive_read_line(receive_read_line)
    );

    baud_generator baud_generator0
    (
        .clk(clk),
        .rst_n(rst_n),
        .baud_write_en(baud_write_en),
        .baud_write_location(baud_write_location),
        .baud_generator_write_line(register_write_line),
        .transmit_baud(transmit_baud),
        .transmit_start(transmit_start),
        .receive_start(receive_start),
        .receive_baud(receive_baud)
    );

    bus_interface bus_interface0
    (
        .iocs(iocs),
        .iorw(iorw),
        .rda(rda),
        .tbr(tbr),
        .ioaddr(ioaddr),
        .receive_read_line(receive_read_line),
        .receive_read_en(receive_read_en),
        .write_line(register_write_line),
        .transmit_write_en(transmit_write_en),
        .baud_write_en(baud_write_en),
        .baud_write_location(baud_write_location),
        .databus(databus)
    );


endmodule
