module transmit (
   input logic          clk,
   input logic          rst_n,
   input logic          transmit_baud,
   input logic          transmit_write_en,
   input logic    [7:0] transmit_write_line,
   output logic         transmit_start,
   output logic         txd,
   output logic         tbr
   );

    logic set_done;
    logic init;
    logic transmitting;
    logic shift;

    logic [3:0]bit_cnt;
    reg [8:0]tx_shft_reg;

    logic [1:0] sel;
    assign sel = {init, shift};

    typedef enum reg {IDLE, TRANSMITTING} state_t;
    state_t state,nxt_state;

    // logic for asserting shift
    assign shift = transmit_baud;

    // Shift Counter //
    always_ff @(posedge clk)
        case(sel)
            2'b11: bit_cnt <= 4'h0;
            2'b10: bit_cnt <= 4'h0;
            2'b01: bit_cnt <= bit_cnt + 1'b1; 
        endcase

    //  9 bit shift register    //
    always_ff @(posedge clk, negedge rst_n)
        if (!rst_n) 
            tx_shft_reg <= 9'h1FF;
        else begin
            case(sel)
                2'b11: tx_shft_reg <= {transmit_write_line, 1'b0};
                2'b10: tx_shft_reg <= {transmit_write_line, 1'b0};
                2'b01: tx_shft_reg <= {1'b1, tx_shft_reg[8:1]}; 
            endcase
        end

    //  State machine   //
    always_ff @(posedge clk, negedge rst_n)
        if (!rst_n)
            state <= IDLE;
        else
            state <= nxt_state;

    always_comb begin
        // Set default values
        init = 1'b0;
        set_done = 1'b0;
        nxt_state = state;
        transmit_start = 1'b0;

        case (state)
            // Transmission initiated
            IDLE: if (transmit_write_en) begin
                init = 1'b1;
                transmit_start = 1'b1;
                nxt_state = TRANSMITTING;
            end
            
			   // While transmitting
            TRANSMITTING: begin
				      // Shifted 10 bits
                if (bit_cnt == 4'hA) begin
                    nxt_state = IDLE;
                    set_done = 1'b1;
                end
            end
        endcase
    end

    //  Done logic  //
	always_ff @(posedge clk, negedge rst_n)
      if (!rst_n)
         tbr <= 1'b1;
		else if (init) 
			tbr <= 1'b0;
      else if (set_done)
         tbr <= set_done;

    assign txd = tx_shft_reg[0];

endmodule