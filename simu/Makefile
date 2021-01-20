
all : VGA_timing_generation_tb.vcd

VGA_timing_generation_tb.vvp : VGA_timing_generation_tb.v ../misc_modules/reflet_counter.v ../VGA_base/VGA_timing_generation.v
	iverilog VGA_timing_generation_tb.v ../misc_modules/reflet_counter.v ../VGA_base/VGA_timing_generation.v -o VGA_timing_generation_tb.vvp

VGA_timing_generation_tb.vcd : VGA_timing_generation_tb.vvp
	vvp VGA_timing_generation_tb.vvp

VGA_timing_generation_tb : VGA_timing_generation_tb.vcd
	gtkwave VGA_timing_generation_tb.vcd

clean :
	rm -f *.vcd
	rm -f *.vvp

