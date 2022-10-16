module vga_display(
	input clk_40m,
	input [10:0] hc,vc,
	input vidon,
	
	
	input [6:0] select,
	input rotate_btn,
	input [3:0] move_btn,
	
	output reg [3:0] red,green,blue
	);
	
	parameter triangle1=2'b00,triangle2=2'b01,parallelogram=2'b10,diamond=2'b11;
	parameter big=8'b11001000,sml=8'b01100100;//200,150,100
	
	
	wire [7:0] color;
	
	
	wire rotate;
	xiaodou rotate_xd(
		.clk(clk_40m),
		.reset(1'b1),
		.key(rotate_btn),
		.key_out(rotate)
	);
	
	wire [3:0] move;
	xiaodou move_up(
		.clk(clk_40m),
		.reset(1'b1),
		.key(move_btn[0]),
		.key_out(move[0])	
	);
	
	xiaodou move_down(
		.clk(clk_40m),
		.reset(1'b1),
		.key(move_btn[1]),
		.key_out(move[1])	
	);

	xiaodou move_left(
		.clk(clk_40m),
		.reset(1'b1),
		.key(move_btn[2]),
		.key_out(move[2])	
	);

	xiaodou move_right(
		.clk(clk_40m),
		.reset(1'b1),
		.key(move_btn[3]),
		.key_out(move[3])	
	);	
	
	shape shape1(
		.clk_40m(clk_40m),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		.shape(triangle1),
		.size(big),
		.px(416),
		.py(327),
		
		.select(select[0]),
		.rotate(rotate),
		.move(move),
		
		.color(color[1])
	);
	
	shape shape2(
		.clk_40m(clk_40m),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		.shape(triangle1),
		.size(big),
		.px(616),
		.py(527),
		
		.select(select[1]),
		.rotate(rotate),
		.move(move),
		
		.color(color[2])
	);
	
	
	shape shape3(
		.clk_40m(clk_40m),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		.shape(triangle1),
		.size(sml),
		.px(516),
		.py(127),
		
		.select(select[2]),
		.rotate(rotate),
		.move(move),
		
		.color(color[3])
	);
	
	shape shape4(
		.clk_40m(clk_40m),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		.shape(triangle1),
		.size(sml),
		.px(716),
		.py(327),
		
		.select(select[3]),
		.rotate(rotate),
		.move(move),
		
		.color(color[4])
	);
	
	shape shape5(
		.clk_40m(clk_40m),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		.shape(triangle2),
		.size(big),
		.px(816),
		.py(127),
		.move(move),
		
		.select(select[4]),
		.rotate(rotate),
		
		.color(color[5])
	);

	shape shape6(
		.clk_40m(clk_40m),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		.shape(diamond),
		.size(sml),
		.px(616),
		.py(227),
		
		.select(select[5]),
		.rotate(rotate),
		.move(move),
		
		.color(color[6])
	);	
	
	shape shape7(
		.clk_40m(clk_40m),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		.shape(parallelogram),
		.size(sml),
		.px(816),
		.py(527),
		
		.select(select[6]),
		.rotate(rotate),
		.move(move),
		
		.color(color[7])
	);
	
	
always @(*) begin
        red   = 0;
        green = 0;
        blue  = 0;
		
		//这能显示多少种颜色？三原�? 000 001 010 ....八种？只控制这三个四位就够是�?
		//比如，正方形是粉色，也就是红加蓝。不叠加时，在这里面就是，红色为1，蓝色为1。如果叠加了，对应的color位为1，然后�?�颜色是他们的混�?
		
        if(vidon) begin
           if (color[1] == 1 || color[4] == 1 || color[5] == 1 || color[7] == 1) 
               red = 4'b1111;
           if (color[2] == 1 || color[4] == 1 || color[6] == 1 || color[7] == 1) 
               green = 4'b1111;
           if (color[3] == 1 || color[5] == 1 || color[6] == 1 || color[7] == 1) 
               blue = 4'b1111;
        end
    end
	
endmodule