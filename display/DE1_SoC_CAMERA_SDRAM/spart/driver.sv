//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:    driver 
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
module driver(
    input logic             clk,
    input logic             rst_n,
    input logic     [1:0]   br_cfg,
    output logic            iocs,
    output logic            iorw,
    input logic             rda,
    input logic             tbr,
    output logic    [1:0]   ioaddr,
    inout logic     [7:0]   databus,
    output logic    [7:0]   read_data_next,
    output logic            read_valid
    );

    // Intermediate signals
            logic   [1:0]   br_cfg_ff;
            logic   [7:0]   write_data;
            logic   [7:0]   read_data;
            logic   [15:0]  baud_rate;
    enum    logic   [2:0]   {START1, START2, WAIT, RECEIVE, TRANSMIT_WAIT, TRANSMIT} state, next_state;

    // Logic for handling ownership of the databus signal
    assign databus = iocs ? (iorw ? 8'bz : write_data) : 8'bz;

    // Logic for determining the right baud rate
    always_comb begin
        if (br_cfg == 2'b00)
            baud_rate = 16'd10416;
        else if (br_cfg == 2'b01)
            baud_rate = 16'd5207;
        else if (br_cfg == 2'b10)
            baud_rate = 16'd2603;
        else 
            baud_rate = 16'd1301;
    end

    // State machine flip flop
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            state = START1;
            br_cfg_ff = br_cfg;
        end
        else if (br_cfg != br_cfg_ff) begin
            state = START1;
            br_cfg_ff = br_cfg;
        end
        else begin
            state = next_state;
            read_data = read_data_next;
            br_cfg_ff = br_cfg;
        end
    end

    // State machine combinational logic
    always_comb begin
        next_state = state;
        read_data_next = read_data;
        write_data = '0;
        iorw = 0;
        ioaddr = 2'b00;
        iocs = 0;
        read_valid = 1'b0;
        case(state)
            START1: begin
                iocs = 1;
                iorw = 0;
                ioaddr = 2'b10;
                write_data = baud_rate[7:0];
                next_state = START2;
            end
            START2: begin
                iocs = 1;
                iorw = 0;
                ioaddr = 2'b11;
                write_data = baud_rate[15:8];
                next_state = WAIT;
            end
            WAIT: begin
                iocs = 0;
                if(rda)
                    next_state = RECEIVE;
            end
            RECEIVE: begin
                iocs = 1;
                iorw = 1;
                ioaddr = 2'b00;
                read_data_next = databus;
                read_valid = 1'b1;
                // next_state = TRANSMIT_WAIT;
                next_state = WAIT;
            end
            TRANSMIT_WAIT: begin
                iocs = 0;
                if (tbr)
                    next_state = TRANSMIT;
            end
            TRANSMIT: begin
                iocs = 1;
                iorw = 0;
                ioaddr = 2'b00;
                write_data = read_data;
                next_state = WAIT;
            end
        endcase
    end

endmodule
