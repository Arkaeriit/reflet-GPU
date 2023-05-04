
module delay_tb ();

    reg clk = 0;
    always #1 clk = !clk;

    reg in;
    wire out_slow, out_fast;

    reflet_delay #(20) delay_slow (
        .clk(clk),
        .enable(1'b1),
        .in(in),
        .out(out_slow));

    reflet_delay #(1) delay_fast (
        .clk(clk),
        .enable(1'b1),
        .in(in),
        .out(out_fast));

    initial
    begin
        $dumpfile("delay_tb.vcd");
        $dumpvars(0, delay_tb);
        #10;
        in <= 1;
        #30;
        in <= 0;
        #10;
        in <= 1;
        #2;
        in <= 0;
        #2;
        in <= 1;
        #2;
        in <= 0;
        #2;
        in <= 1;
        #2;
        in <= 0;
        #2;
        in <= 1;
        #2;
        in <= 0;
        #2;
        in <= 1;
        #60;
        $finish;
    end

endmodule

