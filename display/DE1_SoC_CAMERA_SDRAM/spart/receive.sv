module receive (
   input logic          clk,
   input logic          rst_n,
   input logic          rxd,
   input logic          receive_baud,
   input logic          receive_read_en,
   output logic         rda,
   output logic         receive_start,
   output logic   [7:0] receive_read_line
   );

    logic set_rda;
    logic start;
    logic receiving;
    logic shift;

    logic [3:0]bit_cnt;
    reg [8:0]rx_shft_reg;

    logic RX_flop1;
    logic RX_flop2;
    logic [7:0] rx_data_buffer;

    logic [1:0] sel;
    assign sel = {start, shift};

    typedef enum reg {IDLE, RECEIVING} state_t;
    state_t state,nxt_state;

    // logic for asserting shift
    assign shift = receive_baud;

    //  Shift Counter   //
    always_ff @(posedge clk)
        case(sel)
            2'b11: bit_cnt <= 4'h0;
            2'b10: bit_cnt <= 4'h0;
            2'b01: bit_cnt <= bit_cnt + 1'b1; 
        endcase

    // Double flop RX to remove metastability
    always_ff @(posedge clk, negedge rst_n)
        // Preset
        if (!rst_n) begin
            RX_flop1 <= 1'b1;
            RX_flop2 <= 1'b1;
        end else begin
            RX_flop1 <= rxd;
            RX_flop2 <= RX_flop1;
        end

    //  9 bit shift register    //
    always_ff @(posedge clk)
        if (shift)
            rx_shft_reg <= {RX_flop2, rx_shft_reg[8:1]}; 

    // asssign output to output of the shift register
    assign rx_data_buffer = rx_shft_reg[7:0];

    //  State Machine   //
    always_ff @(posedge clk, negedge rst_n)
        if (!rst_n)
            state <= IDLE;
        else
            state <= nxt_state;

    always_comb begin
        // Set default values
        start = 1'b0;
        receiving = 1'b0;
        set_rda = 1'b0;
        nxt_state = state;
        receive_start = 1'b0;

        case (state)
            // Recieving started when RX low
            IDLE: if (!RX_flop2) begin
                start = 1'b1;
                receive_start = 1'b1;
                nxt_state = RECEIVING;
            end
            
			   // While Recieving
            RECEIVING: begin
               receiving = 1'b1;
				   // Shifted 10 bits
               if (bit_cnt == 4'hA) begin
                  nxt_state = IDLE;
                  set_rda = 1'b1;
               end
            end
        endcase
    end

    //  Done logic  //
	always_ff @(posedge clk, negedge rst_n)
      if (!rst_n) begin
         rda <= 1'b0;
         receive_read_line <= 8'h00;
      end
      else if (set_rda) begin
         rda <= set_rda;
         receive_read_line <= rx_data_buffer;
      end
	   else if (receive_read_en) 
			rda <= 1'b0;

endmodule