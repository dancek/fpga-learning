module vga(
	input clk,
	input [2:0] vga_input,
	output [2:0] vga_output,
	output h_sync,
	output v_sync
);

localparam h_total_px = h_front_porch_px + h_video_px + h_sync_px + h_back_porch_px;
localparam v_total_px = v_front_porch_px + v_video_px + v_sync_px + v_back_porch_px;

localparam h_video_px = 640;
localparam v_video_px = 480;

localparam h_front_porch_px = 16;
localparam h_back_porch_px = 48;
localparam h_sync_px = 96;
localparam h_porch_start_px = h_video_px;
localparam h_sync_start_px = h_video_px + h_front_porch_px;
localparam h_sync_end_px = h_sync_start_px + h_sync_px;

localparam v_front_porch_px = 10;
localparam v_back_porch_px = 33;
localparam v_sync_px = 2;
localparam v_porch_start_px = v_video_px;
localparam v_sync_start_px = v_video_px + v_front_porch_px;
localparam v_sync_end_px = v_sync_start_px + v_sync_px;

assign in_h_blank = h_pixel > h_porch_start_px;
assign in_v_blank = v_pixel > v_porch_start_px;
assign in_blank = in_h_blank || in_v_blank;

reg[9:0] h_pixel = 10'b0;
reg[9:0] h_next_pixel;

reg[9:0] v_pixel = 9'b0;
reg[9:0] v_next_pixel;

assign h_sync = (h_sync_start_px <= h_pixel) && (h_pixel <= h_sync_end_px);
assign v_sync = (v_sync_start_px <= v_pixel) && (v_pixel <= v_sync_end_px);

assign vga_output = in_blank ? 3'b000 : vga_input;

always @(h_pixel, v_pixel) begin
	h_next_pixel = h_pixel + 1'b1;
	v_next_pixel = v_pixel + 1'b1;
end

always @(posedge clk) begin
  if(h_next_pixel == h_total_px) begin
    // Reset horizontal line at the end of horizontal line
    h_pixel <= 0;

    if(v_next_pixel == v_total_px) begin
      // Reset vertical line at the end of frame
      v_pixel <= 0;
    end else begin
      // Advance to next vertical line at the end of horizontal line
      v_pixel <= v_next_pixel;
    end
  end else begin
    // Advance to next pixel on rising clock edge
    h_pixel <= h_next_pixel;
  end
end

endmodule
