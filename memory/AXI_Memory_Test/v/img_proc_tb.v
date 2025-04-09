module img_proc_tb();


wire clk, rst_n, sw_edge;
wire [10:0] Y_Cont, X_Cont,
wire [11:0]  mCCD_DATA, sCCD_R_BW, sCCD_G_BW, sCCD_B_BW;

wire clk, rst;
initial begin
    clk = 0;
    rst_n = 1;
    sw_edge = 1;
    @(posedge clk) rst_n = 0;

    @(posedge clk) sw_edge = 1;
    if (sCCD_R_BW == sCCD_G_BW && sCCD_G_BW == sCCD_B_BW) begin
        $display("Tests passed");
    end


end

img_proc DUT (	
    .iCLK(clk),
    .iRST(rst_n),
    .iDATA(mCCD_DATA),
    .iDVAL(1'b1),
    .oRed(sCCD_R_BW),
    .oGreen(sCCD_G_BW),
    .oBlue(sCCD_B_BW),
    .oDVAL(sCCD_DVAL_BW),
    .iX_Cont(Y_Cont),
    .iY_Cont(Y_Cont),
    .iSW(1'b1),
    .iSW1(sw_edge)
);



always
    #5 clk = ~clk;

endmodule