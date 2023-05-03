
MODULES = ../misc_modules/reflet_counter.v ../misc_modules/reflet_ram_dual_port.v ../VGA_base/pixel_memory.v ../VGA_base/reflet_VGA.v ../VGA_base/VGA_timing_generation.v ../VGA_base/reflet_VGA_bitmap.v ../VGA_base/reflet_VGA_txt.v ../VGA_base/public_pixel.v

all : VGA_timing_generation_tb.vcd reflet_VGA_tb.vcd txt_bitmap_interactions_tb.v

VGA_timing_generation_tb.vvp : VGA_timing_generation_tb.v $(MODULES)
	iverilog VGA_timing_generation_tb.v $(MODULES) -o VGA_timing_generation_tb.vvp

VGA_timing_generation_tb.vcd : VGA_timing_generation_tb.vvp
	vvp VGA_timing_generation_tb.vvp

VGA_timing_generation_tb : VGA_timing_generation_tb.vcd
	gtkwave VGA_timing_generation_tb.vcd

reflet_VGA_tb.vvp : reflet_VGA_tb.v $(MODULES)
	iverilog reflet_VGA_tb.v $(MODULES) -o reflet_VGA_tb.vvp

reflet_VGA_tb.vcd : reflet_VGA_tb.vvp
	vvp reflet_VGA_tb.vvp

reflet_VGA_tb : reflet_VGA_tb.vcd
	gtkwave reflet_VGA_tb.vcd

txt_bitmap_interactions_tb.vvp : txt_bitmap_interactions_tb.v $(MODULES)
	iverilog txt_bitmap_interactions_tb.v $(MODULES) -o txt_bitmap_interactions_tb.vvp

txt_bitmap_interactions_tb.vcd : txt_bitmap_interactions_tb.vvp
	vvp txt_bitmap_interactions_tb.vvp

txt_bitmap_interactions_tb : txt_bitmap_interactions_tb.vcd
	gtkwave txt_bitmap_interactions_tb.vcd

clean :
	rm -f *.vcd
	rm -f *.vvp

