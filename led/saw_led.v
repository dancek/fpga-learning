module saw_led (input clk, output led);
    parameter cycle = 24;
    reg o1, o2, o3, o4, o5, o6, o7, o8;

    reg [cycle:0] count;

    localparam base_time = (1 << cycle) / 8;

    over #(1 * base_time, cycle) over_1 (.clk(clk), .val(o1));
	over #(2 * base_time, cycle) over_2 (.clk(clk), .val(o2));
	over #(3 * base_time, cycle) over_3 (.clk(clk), .val(o3));
	over #(4 * base_time, cycle) over_4 (.clk(clk), .val(o4));
	over #(5 * base_time, cycle) over_5 (.clk(clk), .val(o5));
	over #(6 * base_time, cycle) over_6 (.clk(clk), .val(o6));
	over #(7 * base_time, cycle) over_7 (.clk(clk), .val(o7));
	over #(8 * base_time, cycle) over_8 (.clk(clk), .val(o8));

    assign led =
        (count[1] && o1) ||
        (count[2] && o2) ||
        (count[3] && o3) ||
        (count[4] && o4) ||
        (count[5] && o5) ||
        (count[6] && o6) ||
        (count[7] && o7) ||
        (count[8] && o8);

    always @(posedge clk) count++;
endmodule
