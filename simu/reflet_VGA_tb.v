
module reflet_VGA_tb ();

    reg clk = 0;
    always #1 clk = !clk;
    reg rst = 0;
    reg [5:0] cnt = 1;
    
    reg [6:0] h_pixel = 0;
    reg [5:0] v_pixel = 0;

    reg [1:0] R_in = 2'b10;
    reg [1:0] G_in = 2'b01;
    reg [1:0] B_in = 2'b00;

    always @ (posedge clk)
    begin
        cnt <= cnt + 1;
        if(&cnt)
        begin
            rst <= 1;
            h_pixel = h_pixel + 1;
            if(&h_pixel)
                v_pixel = v_pixel + 1;
        end
    end

    reflet_VGA #(
        .color_depth(2), 
        .clk_freq(100000000), 
        .bit_reduction(3),
        .ram_resetable(1)
    ) vga (
        .clk(clk),
        .reset(rst),
        //In
        .write_bitmap(&cnt),
        .write_txt(1'b0),
        .h_pixel(h_pixel),
        .v_pixel(v_pixel),
        .R_in(R_in),
        .G_in(G_in),
        .B_in(B_in),
        .a_in(2'h3),
        .R_bg_in(R_in),
        .G_bg_in(G_in),
        .B_bg_in(B_in),
        .char_in(8'h1));

    initial
    begin
        $dumpfile("reflet_VGA_tb.vcd");
        $dumpvars(0, reflet_VGA_tb);
        #1000000;
        R_in <= 2'b11;
        G_in <= 2'b11;
        B_in <= 2'b11;
        #1000000;
        $finish;
    end

endmodule
        
