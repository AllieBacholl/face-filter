module proc_hier ();


   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 clk;                    // From c0 of clkrst.v
   wire                 err;                    // From p0 of proc.v
   wire                 rst;                    // From c0 of clkrst.v
   wire                 EXT;                    // From p0 of proc.v
   logic [31:0]          register_accelerator_in [0 : 7]; // From p0 of proc.v
   logic [31:0]          register_accelerator_out [0 : 7]; // From p0 of proc.v

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
        .register_accelerator_in(register_accelerator_in),
        .register_accelerator_out(register_accelerator_out),
        .err(err)
    );

    initial begin
        $display("Hello world...simulation starting");
        $display("See verilogsim.log and verilogsim.trace for output");

        #20; // Wait for 100 time units before starting the simulation
        register_accelerator_in[1] = 32'h0004_B000; // Example input to register accelerator
        register_accelerator_in[1] = 32'h0004_B000; // Example input to register accelerator
        register_accelerator_in[1] = 32'h0004_B000; // Example input to register accelerator
        register_accelerator_in[1] = 32'h0004_B000; // Example input to register accelerator
        register_accelerator_in[1] = 32'h0004_B000; // Example input to register accelerator
        register_accelerator_in[1] = 32'h0004_B000; // Example input to register accelerator
    end

endmodule