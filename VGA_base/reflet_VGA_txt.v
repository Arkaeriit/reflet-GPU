
`define FONT_WIDTH  8 // The font size needs to be a power of two
`define FONT_HEIGHT 8

module reflet_VGA_txt #(
    parameter h_size = 640,
    v_size = 480,
    color_depth = 8,
    ram_resetable = 0,
    bit_reduction = 0
    )(
    input clk,
    input reset,
    // Text in
    input write_en,
    input [$clog2(h_size/`FONT_WIDTH)-bit_reduction-1:0] h_txt_in,
    input [$clog2(v_size/`FONT_HEIGHT)-bit_reduction-1:0] v_txt_in,
    input [7:0] char_in,
    input [color_depth-1:0] R_fg_in,
    input [color_depth-1:0] G_fg_in,
    input [color_depth-1:0] B_fg_in,
    input [color_depth-1:0] R_bg_in,
    input [color_depth-1:0] G_bg_in,
    input [color_depth-1:0] B_bg_in,
    // Pixels out
    input [$clog2(h_size)-bit_reduction-1:0] h_pixel_out,
    input [$clog2(v_size)-bit_reduction-1:0] v_pixel_out,
    output [color_depth-1:0] R_out,
    output [color_depth-1:0] G_out,
    output [color_depth-1:0] B_out
    );

    localparam reduction_factor = 2 ** bit_reduction;

    wire [color_depth*6+7:0] memory_in = {char_in, B_bg_in, G_bg_in, R_bg_in, B_fg_in, G_fg_in, R_fg_in};
    wire [color_depth*6+7:0] memory_out;
    wire [color_depth-1:0] R_fg_out = memory_out[color_depth*1-1:color_depth*0];
    wire [color_depth-1:0] G_fg_out = memory_out[color_depth*2-1:color_depth*1];
    wire [color_depth-1:0] B_fg_out = memory_out[color_depth*3-1:color_depth*2];
    wire [color_depth-1:0] R_bg_out = memory_out[color_depth*4-1:color_depth*3];
    wire [color_depth-1:0] G_bg_out = memory_out[color_depth*5-1:color_depth*4];
    wire [color_depth-1:0] B_bg_out = memory_out[color_depth*6-1:color_depth*5];
    wire [color_depth-1:0] txt_out  = memory_out[color_depth*6+7:color_depth*6];

    wire [$clog2(h_size/`FONT_WIDTH)-bit_reduction-1:0] h_txt_out = h_pixel_out >> $clog2(`FONT_WIDTH);
    wire [$clog2(v_size/`FONT_HEIGHT)-bit_reduction-1:0] v_txt_out = v_pixel_out >> $clog2(`FONT_HEIGHT);

    pixel_memory #(
        .h_size(h_size/reduction_factor/8),
        .v_line(v_size/reduction_factor/8),
        .color_depth(color_depth*6+8),
        .ram_resetable(ram_resetable))
    memory_txt (
        .clk(clk),
        .reset(reset),
        .write_en(write_en),
        .h_pixel_read(h_txt_out),
        .v_pixel_read(v_txt_out),
        .h_pixel_write(h_txt_in),
        .v_pixel_write(v_txt_in),
        .color_write(memory_in),
        .color_read(memory_out));

    // Each char in the font ROM is index from left to right and then from top
    // to bottom
    wire [$clog2(`FONT_HEIGHT)-1:0] pixel_vertical_in_char = {(v_pixel_out & (`FONT_HEIGHT'd`FONT_HEIGHT-`FONT_HEIGHT'd1))};
    wire [$clog2(`FONT_WIDTH)-1:0] pixel_horizontal_in_char = {(h_pixel_out & (`FONT_WIDTH'd`FONT_WIDTH-`FONT_WIDTH'd1))};
    wire [$clog2(`FONT_WIDTH*`FONT_HEIGHT)-1:0] pixel_in_char = {pixel_vertical_in_char, pixel_horizontal_in_char};
    wire is_foreground;

    tmp_font font (
        .char(txt_out),
        .index(pixel_in_char),
        .is_foreground(is_foreground));

    assign R_out = is_foreground ? R_fg_out : R_bg_out;
    assign G_out = is_foreground ? G_fg_out : G_bg_out;
    assign B_out = is_foreground ? B_fg_out : B_bg_out;

endmodule

