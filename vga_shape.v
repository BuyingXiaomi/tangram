module shape(
	input clk_40m,
	input [10:0] hc,vc,
	input vidon,
	input [1:0] shape,
	input [9:0] size,
	input [9:0] px,py,
	
	input select,
	input rotate,//确定四个方向的七巧板中的哪一�?
	input [3:0] move,//0123_上下左右
	
	output reg color);
	
	parameter triangle1=2'b00,triangle2=2'b01,parallelogram=2'b10,diamond=2'b11;
	
	
	
	reg signed [10:0] cx=0,cy=0;
	always @(posedge clk_40m) begin 
		if (select) begin 
			if (move[0]) cy<=cy-5;
			else if (move[1]) cy<=cy+5;
			else if (move[2]) cx<=cx-5;
			else if (move[3]) cx<=cx+5;
		end
	end
	

	
	reg [1:0] rotate_cnt;
	always @(posedge clk_40m) begin 
		if (select) begin
			if (rotate) rotate_cnt<=rotate_cnt+1;
			else rotate_cnt<=rotate_cnt;
		end
		
		else rotate_cnt<=rotate_cnt;
	
	end
	
	
	
	reg in_shape;
	always @(posedge clk_40m) begin
		case (shape)	
			triangle1:begin 
				case (rotate_cnt)
					2'b00:	
						begin
							if((vc+hc+size>px+py+cx+cy) && (vc+px+cx+size>hc+py+cy) && ( vc<py+cy))
								in_shape<=1;
							else in_shape<=0;
						end
					2'b01:
						begin 
							if((hc>px+cx)&&(vc+hc<size+px+py+cx+cy)&&(vc+px+size+cx>hc+py+cy))
								in_shape<=1;
							else in_shape<=0;
						
						end
					
					
					2'b10:
						begin 
							if((vc+px+cx<hc+size+py+cy)&&(vc+hc<size+px+cx+py+cy)&&(vc>py+cy))
								in_shape<=1;
							else in_shape<=0;
						
						end
					
					
					2'b11:
						begin
							if(	(vc+px+cx<hc+size+py+cy)&&(vc+size+hc>px+py+cx+cy)&&(hc<px+cx))
								in_shape<=1;
							else in_shape<=0;
						
						end
				endcase
					
			end
			
			triangle2:
				case (rotate_cnt)
					2'b00:	
						begin 
							if ((vc+px+cx<hc+size+py+cy)&&(hc<px+cx)&&(vc>py+cy))
								in_shape<=1;
							else in_shape<=0;
						end
					2'b01:
						begin 
							if((hc<px+cx)&&(vc<py+cy)&&(vc+hc+size>px+py+cx+cy))
								in_shape<=1;
							else in_shape<=0;
						
						end
					
					
					2'b10:
						begin 
							if((hc>px+cx)&&(vc<py+cy)&&(vc+px+size+cx>hc+py+cy))
								in_shape<=1;
							else in_shape<=0;
						
						end
					
					
					2'b11:
						begin
							if((hc>px+cx)&&(vc>py+cy)&&(vc+hc<size+px+py+cx+cy))
								in_shape<=1;
							else in_shape<=0;
						
						end
				endcase
			
			

			
			parallelogram:
				case (rotate_cnt)
					2'b00:	
						begin
							if ((hc<px+cx)&&(hc+size>px+cx)&&(vc+px+cx<hc+py+cy) && (vc+px+size+size+cx>hc+py+cy))
								in_shape<=1;
							else in_shape<=0;
						end
					2'b01:
						begin 
							if((vc<py+cy) &&(vc+size>py+cy)&&(vc+hc>px+py+cx+cy)&&(vc+hc<px+py+size+size+cx+cy))
								in_shape<=1;
							else in_shape<=0;
						
						end
					
					
					2'b10:
						begin 
							if((hc>px+cx)&&(hc<px+size+cx)&&(vc+px+cx>hc+py+cy)&&(vc+px+cx<hc+py+size+size+cy))
								in_shape<=1;
							else in_shape<=0;
						
						end
					
					
					2'b11:
						begin
							if((vc>py+cy)&&(vc<py+size+cy)&&(vc+hc<px+py+cx+cy)&&(vc+hc+size+size>px+py+cx+cy))
								in_shape<=1;
							else in_shape<=0;
						
						end
				endcase
			

			diamond:begin
				if ((vc+px+cx<hc+size+py+cy)&&(vc+px+size+cx>hc+py+cy)&&(vc+hc<px+py+size+cx+cy) &&(vc+hc+size>px+py+cx+cy))
					in_shape<=1;
				else in_shape<=0;
			end
		endcase
	end
	
	
	
	always @(posedge clk_40m) begin
		if (vidon==1) begin 
			if(in_shape) color <=1; 
			else color<=0;
		end
		
		else color<=0;
	end
	
	
	
	endmodule