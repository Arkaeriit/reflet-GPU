// Test the interaction between the text layer and the bitmap layer by
// writting a char and putting a random pixel in the middle of it.

module txt_bitmap_interactions_tb ();

    reg clk = 0;
    always #1 clk = !clk;
    reg rst = 0;
    
    reg [6:0] h_pixel = 10;
    reg [5:0] v_pixel = 10;

    reg [1:0] R_in = 2'b11;
    reg [1:0] G_in = 2'b00;
    reg [1:0] B_in = 2'b00;
    reg [1:0] a_in = 2'b10;

    reg [1:0] R_bg_in = 2'b00;
    reg [1:0] G_bg_in = 2'b11;
    reg [1:0] B_bg_in = 2'b00;
    reg [7:0] char = 8'h02;
    
    reg write_txt = 0;
    reg write_bitmap = 0;

    wire h_sync, v_sync;
    wire [1:0] R, G, B;

    reflet_VGA #(
        .color_depth(2), 
        .clk_freq(100000000), 
        .bit_reduction(3),
        .ram_resetable(1)
    ) vga (
        .clk(clk),
        .reset(rst),
        // Out
        .h_sync(h_sync),
        .v_sync(v_sync),
        .R_out(R),
        .G_out(G),
        .B_out(B),
        // In
        .write_bitmap(write_bitmap),
        .write_txt(write_txt),
        .h_pixel(h_pixel),
        .v_pixel(v_pixel),
        .R_in(R_in),
        .G_in(G_in),
        .B_in(B_in),
        .a_in(a_in),
        .R_bg_in(R_bg_in),
        .G_bg_in(G_bg_in),
        .B_bg_in(B_bg_in),
        .char_in(char));

    initial
    begin
        $dumpfile("txt_bitmap_interactions_tb.vcd");
        $dumpvars(0, txt_bitmap_interactions_tb);
        #10;
        rst <= 1;
        #10;
        write_bitmap <= 1; 
        #10;
        write_bitmap <= 0; 
        write_txt <= 1; 
        R_in <= 2'b00;
        B_in <= 2'b11;
        h_pixel <= 1;
        v_pixel <= 1;
        #10;
        write_txt <= 0; 
        #4000000;
        $finish;
    end

endmodule
        
