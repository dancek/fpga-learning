module chip (
	output	LED_R,
	output	LED_G,
	output	LED_B);

	wire clk, led;

	SB_HFOSC u_hfosc (
		.CLKHFPU(1'b1),
		.CLKHFEN(1'b1),
		.CLKHF(clk)
	);

	saw_led #(28) my_led(
		.clk(clk),
		.led(led)
	);

	assign LED_R = led;
	assign LED_G = led;
	assign LED_B = led;
endmodule
