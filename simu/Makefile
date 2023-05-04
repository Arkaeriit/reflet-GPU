
MODULES = ../misc_modules/reflet_counter.v ../misc_modules/reflet_ram_dual_port.v ../VGA_base/pixel_memory.v ../VGA_base/reflet_VGA.v ../VGA_base/VGA_timing_generation.v ../VGA_base/reflet_VGA_bitmap.v ../VGA_base/reflet_VGA_txt.v ../VGA_base/public_pixel.v ../misc_modules/reflet_slow_multiplication.v ../misc_modules/reflet_delay.v ../VGA_base/alpha_blending.v
TEST_BENCHES := reflet_VGA_tb txt_bitmap_interactions_tb VGA_timing_generation_tb slow_multiplication_tb delay_tb

all :

define test_bench_template
$(1).vvp: $$(MODULES) $(1).v
	@echo "[IVERILOG] $(1).v"
	@iverilog $$(MODULES) $(1).v -o $(1).vvp

$(1).vcd: $(1).vvp
	@echo "[VDC]      $(1).vvp"
	@vvp $$<

.PHONY: $(1)
$(1): $(1).vcd
	@echo "[GTKWAVE]  $(1).vcd"
	@gtkwave $$<

ALL_VCD += $(1).vcd

$(1)_clean:
	rm -f $(1).vcd
	rm -f $(1).vvp

.PHONY: $(1)_clean
ALL_CLEAN += $(1)_clean

endef

$(foreach tb, $(TEST_BENCHES), $(eval $(call test_bench_template, $(tb))))

all: $(ALL_VCD)

clean : $(ALL_CLEAN)

