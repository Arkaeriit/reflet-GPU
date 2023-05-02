/*----------------------------------\
|This module combines the VGA timing|
|generator and some memory to have a|
|block ready to be pluged to an ADC.|
|It is interfaced by giving it a    |
|pixel coordinate, a color and a    |
|write_enable signal.               |
\----------------------------------*/

`define FONT_WIDTH  8 // TODO: cleanup this definition
`define FONT_HEIGHT 8


module reflet_VGA #(
    parameter clk_freq = 1000000,
    refresh_rate = 60,
    h_size = 640,
    h_front_porch = 16,
    h_sync_pulse = 96,
    h_back_porsh = 48,
    v_line = 480,
    v_front_porch  = 10,
    v_sync_pulse = 2,
    v_back_porsh = 33,
    color_depth = 8,
    ram_resetable = 0,
    bit_reduction = 0
    )(
    input clk,
    input reset,
    //Pixel input
    input write_bitmap,
    input write_txt,
    input [$clog2(h_size)-bit_reduction-1:0] h_pixel,
    input [$clog2(v_line)-bit_reduction-1:0] v_pixel,
    input [color_depth-1:0] R_in,
    input [color_depth-1:0] G_in,
    input [color_depth-1:0] B_in,
    input [color_depth-1:0] a_in,
    input [color_depth-1:0] R_bg_in,
    input [color_depth-1:0] G_bg_in,
    input [color_depth-1:0] B_bg_in,
    input [7:0] char_in,
    //VGA output
    output h_sync,
    output v_sync,
    output [color_depth-1:0] R_out,
    output [color_depth-1:0] G_out,
    output [color_depth-1:0] B_out
    );

    wire [color_depth-1:0] R_bitmap_out;
    wire [color_depth-1:0] G_bitmap_out;
    wire [color_depth-1:0] B_bitmap_out;
    wire [color_depth-1:0] a_bitmap_out;
    wire [color_depth-1:0] R_txt_out;
    wire [color_depth-1:0] G_txt_out;
    wire [color_depth-1:0] B_txt_out;

    //Timing generator
    wire [$clog2(h_size)-bit_reduction-1:0] h_pixel_out;
    wire [$clog2(v_line)-bit_reduction-1:0] v_pixel_out;
    VGA_timing_generation #(
        .clk_freq(clk_freq),
        .refresh_rate(refresh_rate),
        .h_size(h_size),
        .h_front_porch(h_front_porch),
        .h_sync_pulse(h_sync_pulse),
        .h_back_porsh(h_back_porsh),
        .v_line(v_line),
        .v_front_porch(v_front_porch),
        .v_sync_pulse(v_sync_pulse),
        .v_back_porsh(v_back_porsh),
        .bit_reduction(bit_reduction))
    timing (
        .clk(clk),
        .reset(reset),
        .h_sync(h_sync),
        .v_sync(v_sync),
        .h_pixel(h_pixel_out),
        .v_pixel(v_pixel_out));

    // Bitmap layer
    reflet_VGA_bitmap #(
        .h_size(h_size),
        .v_line(v_line),
        .color_depth(color_depth),
        .ram_resetable(ram_resetable),
        .bit_reduction(bit_reduction))
    bitmap (
        .clk(clk),
        .reset(reset),
        .write_en(write_bitmap),
        .h_pixel_in(h_pixel),
        .v_pixel_in(v_pixel),
        .R_in(R_in),
        .G_in(G_in),
        .B_in(B_in),
        .a_in(a_in),
        .h_pixel_out(h_pixel_out),
        .v_pixel_out(v_pixel_out),
        .R_out(R_bitmap_out),
        .G_out(G_bitmap_out),
        .B_out(B_bitmap_out),
        .a_out(a_bitmap_out));

    // Text layer
    reflet_VGA_txt #(
        .h_size(h_size),
        .v_size(v_line),
        .color_depth(color_depth),
        .ram_resetable(ram_resetable),
        .bit_reduction(bit_reduction)) // TODO: no need to be the same as the bitmap
    txt (
        .clk(clk),
        .reset(reset),
        .write_en(write_txt),
        .h_txt_in(h_pixel[$clog2(h_size/`FONT_WIDTH)-bit_reduction-1:0]),
        .v_txt_in(v_pixel[$clog2(v_line/`FONT_HEIGHT)-bit_reduction-1:0]),
        .R_fg_in(R_in),
        .G_fg_in(G_in),
        .B_fg_in(B_in),
        .R_bg_in(R_bg_in),
        .G_bg_in(G_bg_in),
        .B_bg_in(B_bg_in),
        .char_in(char_in),
        .h_pixel_out(h_pixel_out),
        .v_pixel_out(v_pixel_out),
        .R_out(R_txt_out),
        .G_out(G_txt_out),
        .B_out(B_txt_out));

    // TODO: correct α blending
    assign R_out = a_bitmap_out ? R_bitmap_out : R_txt_out;
    assign G_out = a_bitmap_out ? G_bitmap_out : G_txt_out;
    assign B_out = a_bitmap_out ? B_bitmap_out : B_txt_out;

endmodule

