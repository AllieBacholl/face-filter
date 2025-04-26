module proc_hier ();


   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 clk;                    // From c0 of clkrst.v
   wire                 err;                    // From p0 of proc.v
   wire                 rst;                    // From c0 of clkrst.v
   wire                 EXT;                    // From p0 of proc.v

   assign EXT = 1'b0; // Dummy assignment to avoid compile error
   
    clkrst c0 (
        .clk(clk), 
        .rst(rst), 
        .err(err)
    );

    proc p0(
        .clk(clk), 
        .rst(rst), 
        .EXT(EXT),
        .err(err)
    );


endmodule