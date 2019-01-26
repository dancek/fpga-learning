module chip (
    output LED_R,
    output LED_G,
    output LED_B
  );

  localparam PWM_BITS = 8;
  localparam DIM_BITS = 3;
  localparam CYCLE_BITS = 27;

  wire clk, rst, led;

  reg [CYCLE_BITS : 0] counter;

  SB_HFOSC u_hfosc (
		.CLKHFPU(1'b1),
		.CLKHFEN(1'b1),
		.CLKHF(clk)
	);

  pwm #(PWM_BITS) pwm (
    .clk(clk),
    .rst(rst),
    .min(counter[(CYCLE_BITS-1):(CYCLE_BITS-PWM_BITS+DIM_BITS)]),
    .pwm(led)
  );

  always @(posedge clk) begin
    if (rst)
      counter = 0;
    else
      counter = counter + 1;
  end

	assign LED_R = led;
	assign LED_G = led;
	assign LED_B = led;
endmodule
