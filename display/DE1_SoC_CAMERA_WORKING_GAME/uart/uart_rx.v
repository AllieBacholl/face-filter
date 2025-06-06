module  uart_rx
#(
    parameter   UART_BPS    =   'd9600,
    parameter   CLK_FREQ    =   'd50_000_000
)
(
    input   wire            sys_clk     ,   
    input   wire            sys_rst_n   ,   
    input   wire            rx          ,   

    output  reg     [7:0]   po_data     ,   
    output  reg             po_flag         
);

//********************************************************************//
//****************** Parameter and Internal Signal *******************//
//********************************************************************//
//localparam    define
localparam  BAUD_CNT_MAX    =   CLK_FREQ/UART_BPS   ;

//reg   define
reg         rx_reg1     ;
reg         rx_reg2     ;
reg         rx_reg3     ;
reg         start_nedge ;
reg         work_en     ;
reg [12:0]  baud_cnt    ;
reg         bit_flag    ;
reg [3:0]   bit_cnt     ;
reg [7:0]   rx_data     ;
reg         rx_flag     ;

//********************************************************************//
//***************************** Main Code ****************************//
//********************************************************************//
// Double flop for metastablility
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0) begin
        rx_reg1 <= 1'b1;
        rx_reg2 <= 1'b1;
        rx_reg3 <= 1'b1;
	 end else begin
        rx_reg1 <= rx;
        rx_reg2 <= rx_reg1;
        rx_reg3 <= rx_reg2;
	 end

// Start sampling once rx goes low
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        start_nedge <= 1'b0;
    else if((~rx_reg2) && (rx_reg3))
        start_nedge <= 1'b1;
    else
        start_nedge <= 1'b0;

// Sample once rx goes low
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        work_en <= 1'b0;
    else if(start_nedge == 1'b1)
        work_en <= 1'b1;
    else if((bit_cnt == 4'd8) && (bit_flag == 1'b1))
        work_en <= 1'b0;

// Count up to baud
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        baud_cnt <= 13'b0;
    else if((baud_cnt == BAUD_CNT_MAX - 1) || (work_en == 1'b0))
        baud_cnt <= 13'b0;
    else if(work_en == 1'b1)
        baud_cnt <= baud_cnt + 1'b1;

// High once a bit has been recieved, want to sample halfway through baud
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        bit_flag <= 1'b0;
    else if(baud_cnt == BAUD_CNT_MAX/2 - 1)
        bit_flag <= 1'b1;
    else
        bit_flag <= 1'b0;

// Count the number of bits transmitted
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        bit_cnt <= 4'b0;
    else if((bit_cnt == 4'd8) && (bit_flag == 1'b1))
        bit_cnt <= 4'b0;
     else if(bit_flag ==1'b1)
         bit_cnt <= bit_cnt + 1'b1;

// Shift data in
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        rx_data <= 8'b0;
    else if((bit_cnt >= 4'd1)&&(bit_cnt <= 4'd8)&&(bit_flag == 1'b1))
        rx_data <= {rx_reg3, rx_data[7:1]};

// High once a byte has been recieved
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        rx_flag <= 1'b0;
    else if((bit_cnt == 4'd8) && (bit_flag == 1'b1))
        rx_flag <= 1'b1;
    else
        rx_flag <= 1'b0;

// Flop data out
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        po_data <= 8'b0;
    else if(rx_flag == 1'b1)
        po_data <= rx_data;

// Flop data valid out
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        po_flag <= 1'b0;
    else
        po_flag <= rx_flag;

endmodule
