module tmp_font (
    input [7:0] char,
    input [$clog2(64)-1:0] index,
    output is_foreground
    );

    wire [63:0] font_char = char == 8'h0 ? ~(64'h0) : (char == 8'h2 ? 64'h1 : 0);
    wire [63:0] shift = font_char >> index;
    assign is_foreground = shift[0];

endmodule

