# Reflet GPU

A GPA for FPGAs with a test layer and a bitmap layer.

![Example picture](demo_picture.jpg)

The top module of the GPU is `VGA_base/reflet_VGA.v`.

## Parameters

The top modules parameters are:

* `clk_freq`: the input clock frequency in Hertz.
* `refresh_rate`: the refresh rate in frames per seconds.
* `h_size`, `h_front_porch`, `h_sync_pulse`, `h_back_porsh`, `v_line`, `v_front_porsh`, `v_sync_pulse`, and `v_back_porsh`: image parameters, all in pixels.
* `color_depth`: The number of bit per color channel.
* `ram_resetable`: Is the ram zeroed with the reset signal?
* `bit_reduction`: The effective number of pixel displayed is `(v_line * h_size) / (2 ^ bit_reduction)`. Useful to reduce memory usage and high frequency need.

The default are for a 1 MHz clock and a true-color 640x480 picture.

## IOs

The top module have the following IOs:

* `clk`: input clock.
* `reset`: reset low signal.
* `h_pixel` and `v_pixel`: input for the pixel or letter to be edited.
* `R_in`, `G_in`, `B_in`, `a_in`, `R_bg_in`, `G_bg_in`, `B_bg_in`, and `char_in`: input color and letter.
* `write_bitmap` and `write_txt`: input write command.
* `h_sync`, `v_sync`, `R_out`, `G_out`, and `B_out`: VGA signal.

## Writing on the screen

### Writing a letter

To write on the text layer, choose the letter with `char_in`. Choose the color of the letter with `R_in`, `G_in`, and `B_in`; and choose the background of the letter with `R_bg_in`, `G_bg_in`, and `B_bg_in`. Choose the position of the letter with `h_pixel` and `v_pixel`. This is the position of the letter on the text grid, not on a pixel count. Finally, set `write_txt` to one for at least a clock cycle.

### Writing a pixel

To write a pixel, choose the color with `R_in`, `G_in`, and `B_in`. Choose the transparency with `a_in`. Choose the position of the pixel with `v_pixel` and `h_pixel`. Finally, set `write_bitmap` to one for at least a clock cycle.

## Font used

The text layer uses the font Public Pixel made by GGBotNet under the license Creative Commons Zero v1.0 Universal.

