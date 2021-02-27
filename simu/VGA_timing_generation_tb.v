
module VGA_timing_generation_tb();

    reg clk = 0;
    always #1 clk = !clk;
    reg reset = 0;

    wire h_sync, v_sync;
    wire [9:0] h_pixel;
    wire [8:0] v_pixel;

    VGA_timing_generation #(.clk_freq(50000000), .bit_reduction(1)) vga_reduced (
        .clk(clk),
        .reset(reset));

    VGA_timing_generation #(.clk_freq(50000000), .bit_reduction(3)) vga_reduced_more (
        .clk(clk),
        .reset(reset));

    VGA_timing_generation #(.clk_freq(50000000), .bit_reduction(0)) vga_raw (
        .clk(clk),
        .reset(reset),
        .h_sync(h_sync),
        .v_sync(v_sync),
        .v_pixel(v_pixel),
        .h_pixel(h_pixel));

    initial
    begin
        $dumpfile("VGA_timing_generation_tb.vcd");
        $dumpvars(0, VGA_timing_generation_tb);
        #10;
        reset = 1;
        #5000000;
        $finish;
    end

endmodule

