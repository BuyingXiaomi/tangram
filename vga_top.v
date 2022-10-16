module top (
	input clk_100m,
	input [6:0] select,
	input rotate,
	input [3:0] move,
	
	output hsync,vsync,
	output [3:0] red,green,blue
	);
	
	
	wire clk_40m;
	wire [10:0] hc,vc;
	wire vidon;
	
	clk_wiz_0 U1(
		.clk_in1(clk_100m),
		.clk_out1(clk_40m)
	);
	
	
	vga_driver U2(
		.clk(clk_40m),
		.clr(1'b0),
		.hsync(hsync),
		.vsync(vsync),
		.hc(hc),
		.vc(vc),
		.vidon(vidon)
	);
	
	
	vga_display U3(
		.clk_40m(clk_40m),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		
		.select(select),
		.rotate_btn(rotate),
		.move_btn(move),
		
		.red(red),
		.green(green),
		.blue(blue)
	);
	
	
	
endmodule
	
	
	
	
	