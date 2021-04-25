/*------------------------------------------------------------------\
|This module let us control a reflet_VGA module from a Wishbone bus.|
|This supports both classic or pipelined operations. Unaligned      |
|accesses are not supported. One address is used to load the X      |
|coordinate. an other one for the Y coordinate. A third one is used |
|to load the color. The writing of a pixel is registered when the   |
|color are written. Tags are not used for input and locked at 0 for |
|output.                                                            |
\------------------------------------------------------------------*/

module reflet_VGA_wishbone #(
    //VGA configuration
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
    bit_reduction = 0,
    //Whishbone configuration
    bus_size = 32,
    x_addr = 32'h70000000,
    y_addr = 32'h70000004,
    color_addr = 32'h70000008
    )(
    input clk,
    input reset,
    //Whishbone bus
    output [3:0] wb_tag_o,
    input [bus_size-1:0] wb_dat_i,
    output [bus_size-1:0] wb_dat_o,
    input [bus_size-1:0] wb_adr_i,
    output wb_ack_o,
    output wb_err_o,
    input wb_cyc_i,
    input wb_stb_i,
    input wb_we_i,
    //VGA output
    output h_sync,
    output v_sync,
    output [color_depth-1:0] R_out,
    output [color_depth-1:0] G_out,
    output [color_depth-1:0] B_out
    );

    reg [bus_size-1:0] h_pixel;
    reg [bus_size-1:0] v_pixel;
    reg [bus_size-1:0] color;

    //Access control
    wire bus_enable = wb_cyc_i & wb_stb_i;
    wire h_enable = bus_enable && (wb_adr_i == x_addr);
    wire v_enable = bus_enable && (wb_adr_i == y_addr);
    wire c_enable = bus_enable && (wb_adr_i == color_addr);

    //Synchronous logic
    assign wb_err_o = 1'b0;
    assign wb_tag_o = 4'b0;
    assign wb_ack_o = h_enable | v_enable | c_enable;
    assign wb_dat_o = ( h_enable ? h_pixel :
                        ( v_enable ? v_pixel :
                          ( c_enable ? color :
                              0 )));

    //Register edit
    reg color_write_en;
    always @ (posedge clk)
        if (!reset)
        begin
            color_write_en <= 0;
            h_pixel <= 0;
            v_pixel <= 0;
            color <= 0;
        end
        else
        begin
            if(wb_we_i & h_enable)
                h_pixel <= wb_dat_i;
            if(wb_we_i & v_enable)
                v_pixel <= wb_dat_i;
            if(wb_we_i & c_enable)
                color <= wb_dat_i;
            color_write_en <= wb_we_i & c_enable;
        end

    reflet_VGA #(
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
        .bit_reduction(bit_reduction),
        .color_depth(color_depth),
        .ram_resetable(ram_resetable)
    ) vga (
        .clk(clk),
        .reset(reset),
        //Pixel input
        .write_en(color_write_en),
        .h_pixel(h_pixel[$clog2(h_size)-bit_reduction-1:0]),
        .v_pixel(v_pixel[$clog2(v_line)-bit_reduction-1:0]),
        .R_in(color[color_depth-1:0]),
        .G_in(color[color_depth * 2 - 1:color_depth]),
        .B_in(color[color_depth * 3 - 1:color_depth*2]),
        //VGA output
        .h_sync(h_sync),
        .v_sync(v_sync),
        .R_out(R_out),
        .G_out(G_out),
        .B_out(B_out));

endmodule

