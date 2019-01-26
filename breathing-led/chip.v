module chip (
    output LED_R,
    output LED_G,
    output LED_B
  );

  localparam PWM_BITS = 16;
  localparam CYCLE_BITS = 26;

  wire clk, rst, led;

  reg [CYCLE_BITS : 0] counter;
  reg [PWM_BITS-1 : 0] min;
  reg [PWM_BITS-1 : 0] tmp;

  SB_HFOSC u_hfosc (
		.CLKHFPU(1'b1),
		.CLKHFEN(1'b1),
		.CLKHF(clk)
	);

  pwm #(PWM_BITS) pwm (
    .clk(clk),
    .rst(rst),
    .min(min),
    .pwm(led)
  );

  always @(posedge clk) begin
    if (rst)
      counter = 0;
    else
      counter = counter + 1;

    tmp = counter[(CYCLE_BITS-1):(CYCLE_BITS-PWM_BITS)];
    if (counter[CYCLE_BITS])
      min = ~tmp;
    else
      min = tmp;
  end

	assign LED_R = led;
	assign LED_G = led;
	assign LED_B = led;
endmodule
