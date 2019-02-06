module chip (
    output HSYNC,
    output VSYNC,
    output VGA_R,
    output VGA_G,
    output VGA_B
  );

  wire base_clk, pll_clk, hsync, vsync;
  wire [2:0] vga_out;

  SB_HFOSC u_hfosc (
		.CLKHFPU(1'b1),
		.CLKHFEN(1'b1),
		.CLKHF(base_clk)
	);

  pll pll (
    .clock_in(base_clk),
    .clock_out(pll_clk)
  );

  reg clk;
  always @(posedge base_clk) clk = ~clk;

  vga vga (clk, 3'b101, vga_out, hsync, vsync);

	assign VGA_R = vga_out[0];
	assign VGA_G = vga_out[1];
	assign VGA_B = vga_out[2];
  assign HSYNC = hsync;
  assign VSYNC = vsync;
endmodule
