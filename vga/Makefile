chip.bin: chip.v vga.v pll.v vga-upduino.pcf
	yosys -q -p "synth_ice40 -blif chip.blif" chip.v vga.v pll.v
	arachne-pnr -d 5k -P sg48 -p vga-upduino.pcf chip.blif -o chip.txt
	icepack chip.txt chip.bin

.PHONY: flash
flash:
	iceprog chip.bin

.PHONY: clean
clean:
	$(RM) -f chip.blif chip.txt chip.ex chip.bin
