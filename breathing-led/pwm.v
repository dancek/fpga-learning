module pwm
  #(parameter COUNTER_BITS = 8,
    parameter DIM_BITS = 3,
  ) (
    input clk,
    input rst,
    input [COUNTER_BITS - 1 : 0] min,
    output pwm
  );

  reg [COUNTER_BITS + DIM_BITS - 1 : 0] counter;

  always @(posedge clk) begin
    if (rst)
      counter = 0;
    else
      counter = counter + 1;

    pwm = (counter > min);
  end

endmodule
