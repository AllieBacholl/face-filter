`default_nettype none
module writeback (

    // control signals input
    input [1:0] result_set_WB,

    // data signals input
    input [31:0] alu_result_WB,
    input [31:0] mem_data_WB,
    input [31:0] pcPlus4_WB,

    // data signals outputs
    output [31:0] write_data_WB,
);

 assign writeData = (result_set_WB == 2'b10) ? pcPlus4_WB : (result_set_WB == 2'b01) ? mem_data_WB : alu_result_WB;

   
endmodule
`default_nettype wire
