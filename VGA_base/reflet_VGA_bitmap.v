/*----------------------------------\
|This module contains memory to store
|a bitmap picture and show it.      |
|The main logic comes in merging all|
|the 4 channels into a single memory|
|to make FPGA implementation easier.|
\----------------------------------*/

module reflet_VGA_bitmap #(
    parameter h_size = 640,
    v_line = 480,
    color_depth = 8,
    ram_resetable = 0,
    bit_reduction = 0
    )(
    input clk,
    input reset,
    // Pixel input
    input write_en,
    input [$clog2(h_size)-bit_reduction-1:0] h_pixel_in,
    input [$clog2(v_line)-bit_reduction-1:0] v_pixel_in,
    input [color_depth-1:0] R_in,
    input [color_depth-1:0] G_in,
    input [color_depth-1:0] B_in,
    input [color_depth-1:0] a_in,
    // Pixel output
    input [$clog2(h_size)-bit_reduction-1:0] h_pixel_out,
    input [$clog2(v_line)-bit_reduction-1:0] v_pixel_out,
    output [color_depth-1:0] R_out,
    output [color_depth-1:0] G_out,
    output [color_depth-1:0] B_out,
    output [color_depth-1:0] a_out
    );

    localparam reduction_factor = 2 ** bit_reduction;
    wire [color_depth*4-1:0] memory_in = {a_in, B_in, G_in, R_in};
    wire [color_depth*4-1:0] memory_out;
    assign R_out = memory_out[color_depth*1-1:color_depth*0];
    assign G_out = memory_out[color_depth*2-1:color_depth*1];
    assign B_out = memory_out[color_depth*4-1:color_depth*2];
    assign a_out = memory_out[color_depth*4-1:color_depth*3];

    pixel_memory #(
        .h_size(h_size/reduction_factor),
        .v_line(v_line/reduction_factor),
        .color_depth(color_depth*4),
        .ram_resetable(ram_resetable))
    memory_bitmap (
        .clk(clk),
        .reset(reset),
        .write_en(write_en),
        .h_pixel_read(h_pixel_out),
        .v_pixel_read(v_pixel_out),
        .h_pixel_write(h_pixel_in),
        .v_pixel_write(v_pixel_in),
        .color_write(memory_in),
        .color_read(memory_out));

endmodule

