module over (input clk, output val);
    parameter min = 0;
    parameter cycle = 24;

    reg [cycle:0] count;

    assign val = count > min;

    always @(posedge clk) count++;
endmodule
