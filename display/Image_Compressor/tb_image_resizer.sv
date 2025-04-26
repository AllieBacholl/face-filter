`timescale 1ns / 1ps

module image_resizer_tb;

    // Testbench signals
    reg         clk;
    reg         rst_n;
    reg         start;
    reg  [7:0]  pix_color_in;
    reg  [10:0] pix_haddr;
    reg  [9:0]  pix_vaddr;
    wire        sram_wr;
    wire [7:0]  pix_color_out;
    wire [9:0]  compress_addr;

    // Instantiate the image_resizer module
    image_resizer uut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .pix_color_in(pix_color_in),
        .pix_haddr(pix_haddr),
        .pix_vaddr(pix_vaddr),
        .sram_wr(sram_wr),
        .pix_color_out(pix_color_out),
        .compress_addr(compress_addr)
    );

    // Clock generation: 25 MHz (40 ns period)
    initial begin
        clk = 0;
        forever #20 clk = ~clk;
    end

    // Expected value calculation
    localparam BLOCK_SIZE = 40 * 30; // 1200 pixels
    localparam SUM = (BLOCK_SIZE * (BLOCK_SIZE + 1)) / 2; // Sum of 1 to 1200 = 720,600
    localparam EXPECTED_AVG = SUM / BLOCK_SIZE; // 720,600 / 1200 = 600
    localparam EXPECTED_OUT = EXPECTED_AVG[7:0]; // Truncate to 8 bits = 88

    // Test stimulus
    integer h, v;
    integer pixel_count;
    initial begin
        // Initialize signals
        rst_n = 0;
        start = 0;
        pix_color_in = 0;
        pix_haddr = 0;
        pix_vaddr = 0;
        pixel_count = 1;

        // Reset the module
        #40;
        rst_n = 1;
        $display("Time=%0t: Reset released", $time);

        // Start signal to begin processing
        #40;
        start = 1;
        #40;
        start = 0;
        $display("Time=%0t: Start signal pulsed", $time);

        // Simulate first block (40x30 pixels: haddr 0 to 39, vaddr 0 to 29)
        $display("\nSimulating first block (40x30 pixels):");
        $display("---------------------------------------");
        for (v = 0; v < 30; v = v + 1) begin
            for (h = 0; h < 40; h = h + 1) begin
                pix_haddr = h;
                pix_vaddr = v;
                pix_color_in = 8'd100; // Incremental values (1, 2, ..., 255, 0, ...)
                $display("Time=%0t: Pixel (%0d,%0d), Color=%0d", $time, pix_haddr, pix_vaddr, pix_color_in);
                pixel_count = pixel_count + 1;
                #40; // Wait one clock cycle
            end
        end

        // Wait a few cycles to ensure output is processed
        #80;
        $display("\nTime=%0t: End of first block", $time);
        $display("Actual pix_color_out = %0d, sram_wr = %0b, compress_addr = %0d", 
                 pix_color_out, sram_wr, compress_addr);
        // // Compare expected vs. actual
        // if (pix_color_out === EXPECTED_OUT) begin
        //     $display("Result: expected === actual (pix_color_out = %0d)", pix_color_out);
        // end else begin
        //     $display("Result: expected !== actual (expected = %0d, actual = %0d)", EXPECTED_OUT, pix_color_out);
        // end

        // End simulation
        #100;
        $display("Simulation completed.");
        $finish;
    end

    // Monitor outputs
    always @(posedge clk) begin
        if (sram_wr) begin
            $display("Time=%0t: SRAM Write Triggered! pix_color_out=%0d, compress_addr=%0d", 
                     $time, pix_color_out, compress_addr);
        end
    end

endmodule