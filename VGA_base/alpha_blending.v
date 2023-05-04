
module alpha_blending #(
    parameter color_depth = 8
    )(
    input clk,
    input enable,
    input [color_depth-1:0] color_1,
    input [color_depth-1:0] color_1_alpha,
    input [color_depth-1:0] color_2,
    output [color_depth-1:0] color_out
    );

    wire [color_depth-1:0] color_2_alpha = ~0 - color_1_alpha;
    wire [color_depth:0] alpha_plus = 1;

    wire [color_depth*2+1:0] color_1_blend;
    wire [color_depth*2+1:0] color_2_blend;
    wire [color_depth*2+1:0] color_out_blend = color_1_blend + color_2_blend;
    assign color_out = color_out_blend[color_depth*2-1:color_depth];

    reflet_slow_multiplication #(color_depth+1) mult_1 (
        .clk(clk),
        .enable(enable),
        .in_1({1'b0, color_1}),
        .in_2({1'b0, color_1_alpha} + alpha_plus),
        .out(color_1_blend));

    reflet_slow_multiplication #(color_depth+1) mult_2 (
        .clk(clk),
        .enable(enable),
        .in_1({1'b0, color_2}),
        .in_2({1'b0, color_2_alpha} + alpha_plus),
        .out(color_2_blend));

endmodule

