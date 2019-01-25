module saw_led (input clk, output led);
    parameter steps = 16;

    reg [steps:0]over_bus;
    reg [steps:0]pwm_bus;
    reg [steps:0]count;

    localparam cycle_bits = 26;
    localparam cycle = 1 << cycle_bits;
    localparam magic_number = 100;

    genvar i;
    generate
        for (i = 0; i < steps; i=i+1) begin: gen_loop
            // TODO: find logic that has better probability distribution :(
            over #(cycle - (cycle / (i+1)), cycle_bits) brightness_step (.clk(clk), .val(over_bus[i]));
        end
    endgenerate

    assign led = |(count & over_bus);

    always @(posedge clk) count++;
endmodule
