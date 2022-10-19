module top (
	input clk_100m,
	
	input reset_btn,//最开始的整块
	input disturb,//打乱七巧板
	input rotate_btn,//旋转按钮
	
	input [6:0] select,//七块图形的选择端
	input [3:0] move_btn,//移动按钮
	
	output hsync,vsync,
	output reg [3:0] red,green,blue,
	
	output [6:0] seg0,//没用上
	output [6:0] seg1,
	output [7:0] cs
	
	);
	parameter triangle1=2'b00,triangle2=2'b01,parallelogram=2'b10,diamond=2'b11;
	parameter big=8'b11001000,sml=8'b01100100;//200,100
	
	wire [7:0] color;

	wire clk_40m;
	clk_wiz_0 U1(
		.clk_in1(clk_100m),
		.clk_out1(clk_40m)
	);
	
	wire [10:0] hc ,vc;
	wire vidon;
	vga_driver U2(
		.clk(clk_40m),
		.clr(1'b1),
		.hsync(hsync),
		.vsync(vsync),
		.hc(hc),
		.vc(vc),
		.vidon(vidon)
	);
	
	wire reset;
	xiaodou reset_xd(
		.clk(clk_40m),
		.reset(1'b1),
		.key(reset_btn),
		.key_out(reset)
	);
	
	
	wire rotate;
	xiaodou rotate_xd(
		.clk(clk_40m),
		.reset(1'b1),
		.key(rotate_btn),
		.key_out(rotate)
	);
	
/* 	wire [3:0] move;
    parameter NUM_OF_MOVE=4;
    generate
        genvar n;
        for (n=0;n<NUM_OF_MOVE;n=n+1) begin 
            xiaodou move_xd(
                .clk(clk_40m),
                .reset(1'b1),
                .key(move_btn[n]),
                .key_out(move[n])
            );
        end
    endgenerate
	 */
	
	
	
	reg [6:0] disturb_flag;	//用来解决这些块一起打乱的话，位置一样的问题
	shape_control shape1(
		.reset(reset_btn),
		.clk(clk_40m),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		.flag(1),
		
		.shape(triangle1),
		.size(big),
		.select(select[0]),
		.move(move_btn),
		.rotate(rotate),
		.disturb(disturb_flag[0]),

		.color(color[1])
	);
	
	shape_control shape2(
		.reset(reset_btn),
		.clk(clk_40m),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		.flag(2),
		
		.shape(triangle1),
		.size(big),
		.select(select[1]),
		.move(move_btn),
		.rotate(rotate),
		.disturb(disturb_flag[1]),

		
		.color(color[2])
	);	
	
	
	shape_control shape3(
		.reset(reset_btn),
		.clk(clk_40m),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		.flag(3),
		
		.shape(triangle1),
		.size(sml),
		.select(select[2]),
		.move(move_btn),
		.rotate(rotate),
		.disturb(disturb_flag[2]),

		
		.color(color[3])
	);	
	shape_control shape4(
		.reset(reset_btn),
		.clk(clk_40m),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		.flag(4),
		
		.shape(triangle1),
		.size(sml),
		.select(select[3]),
		.move(move_btn),
		.rotate(rotate),
		.disturb(disturb_flag[3]),

		
		.color(color[4])
	);		
	shape_control shape5(
		.reset(reset_btn),
		.clk(clk_40m),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		.flag(5),
		
		.shape(triangle2),
		.size(big),
		.select(select[4]),
		.move(move_btn),
		.rotate(rotate),
		.disturb(disturb_flag[4]),

		
		.color(color[5])
	);
	shape_control shape6(
		.reset(reset_btn),
		.clk(clk_40m),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		.flag(6),
		
		.shape(diamond),
		.size(sml),
		.select(select[5]),
		.move(move_btn),
		.rotate(rotate),
		.disturb(disturb_flag[5]),

		
		.color(color[6])
	);
	shape_control shape7(
		.reset(reset_btn),
		.clk(clk_40m),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		.flag(7),
		
		.shape(parallelogram),
		.size(sml),
		.select(select[6]),
		.move(move_btn),
		.rotate(rotate),
		.disturb(disturb_flag[6]),

		
		.color(color[7])
	);
	
	
	
	
	reg [25:0] cnt;				//技术不行，暴力让它足够大，大到不会再第二次让flag为1.这个可能会实现，隔一会儿就刷新一次
	always @(posedge clk_40m)begin 
		if (~disturb) cnt<=0;
		else begin
			cnt<=cnt+1;
			case (cnt)
				10:disturb_flag<=7'b0000001;
				20:disturb_flag<=7'b0000010;
				30:disturb_flag<=7'b0000100;
				40:disturb_flag<=7'b0001000;
				50:disturb_flag<=7'b0010000;
				60:disturb_flag<=7'b0100000;
				70:disturb_flag<=7'b1000000;
				default:disturb_flag<=7'b0;
			endcase
		end
	end
	
	
	
    always @(*) begin
        red   = 0;
        green = 0;
        blue  = 0;

        if(vidon) begin
           if (color[4] == 1 || color[5] == 1 || color[6] == 1 || color[7] == 1) 
               red = 4'b1111;
           if (color[2] == 1 || color[3] == 1 || color[6] == 1 || color[7] == 1) 
               green = 4'b1111;
           if (color[1] == 1 || color[3] == 1 || color[5] == 1 || color[7] == 1) 
               blue = 4'b1111;
        end
    end
	
endmodule
	
	
	
	
	