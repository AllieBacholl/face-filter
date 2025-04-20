module baud_generator(
    input       clk,
    input       rst_n,
    input       baud_write_en,
    input       baud_write_location,
    input [7:0] baud_generator_write_line,
    input       transmit_start,
    input       receive_start,
    output reg  transmit_baud,
    output reg  receive_baud
    );

// Intermediate values
logic [15:0] db;
logic [15:0] down_cnt_transmit;
logic [15:0] down_cnt_receive;

// divisor = (clock frequency/(2^n × baud rate) − 1)
// Assume clock frequency is 50 MHz and n = 4
// Supported baud rates are 4800, 9600, 19200, 38400
// Divisor values are 10416, 5207, 2603, 1301

always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        transmit_baud <= 1'b0;
        down_cnt_transmit <= 16'h0000;
        // Default to 50 MHz at 9600 bps
        db <= 16'd5207;
    end
    else begin
        // Set DB(Low)
        if (baud_write_en && !baud_write_location) begin
            db[7:0] <= baud_generator_write_line;
        end
        // Set DB(High)
        if (baud_write_en && baud_write_location) begin
            db[15:8] <= baud_generator_write_line;
        end
        // Calculate enable signals
        if (transmit_start) begin
            down_cnt_transmit <= db;
            transmit_baud <= 1'b0;
        end else if (down_cnt_transmit == 16'h0000) begin
            down_cnt_transmit <= db;
            transmit_baud <= 1'b1;
        end else begin
            down_cnt_transmit <= down_cnt_transmit - 1'b1;
            transmit_baud <= 1'b0;
        end
        if (receive_start) begin
            down_cnt_receive <= {1'b0, db[15:1]};
            receive_baud <= 1'b0;
        end else if (down_cnt_receive == 16'h0000) begin
            down_cnt_receive <= db;
            receive_baud <= 1'b1;
        end else begin
            down_cnt_receive <= down_cnt_receive - 1;
            receive_baud <= 1'b0;
        end
    end
end


endmodule
