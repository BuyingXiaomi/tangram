module shape(
	input clk_40m,
	input [10:0] hc,vc,
	input vidon,
	input [1:0] shape,
	input [9:0] size,
	input [10:0] px,py,
	input [1:0] toward,

	
	output reg color);
	
	parameter triangle1=2'b00,triangle2=2'b01,parallelogram=2'b10,diamond=2'b11;
	
	
	reg in_shape;
	always @(posedge clk_40m) begin
		case (shape)	
			triangle1:begin 
				case (toward)
					2'b00:	
						begin
							if((vc+hc+size>px+py) && (vc+px+size>hc+py) && ( vc<py))
								in_shape<=1;
							else in_shape<=0;
						end
					2'b01:
						begin 
							if((hc>px )&&(vc+hc<size+px+py )&&(vc+px+size>hc+py ))
								in_shape<=1;
							else in_shape<=0;
						
						end
					
					
					2'b10:
						begin 
							if((vc+px<hc+size+py)&&(vc+hc<size+px+py )&&(vc>py))
								in_shape<=1;
							else in_shape<=0;
						
						end
					
					
					2'b11:
						begin
							if(	(vc+px<hc+size+py )&&(vc+size+hc>px+py)&&(hc<px))
								in_shape<=1;
							else in_shape<=0;
						
						end
				endcase
					
			end
			
			triangle2:
				case (toward)
					2'b00:	
						begin 
							if ((vc+px <hc+size+py)&&(hc<px)&&(vc>py))
								in_shape<=1;
							else in_shape<=0;
						end
					2'b01:
						begin 
							if((hc<px )&&(vc<py )&&(vc+hc+size>px+py ))
								in_shape<=1;
							else in_shape<=0;
						
						end
					
					
					2'b10:
						begin 
							if((hc>px)&&(vc<py)&&(vc+px+size >hc+py ))
								in_shape<=1;
							else in_shape<=0;
						
						end
					
					
					2'b11:
						begin
							if((hc>px )&&(vc>py )&&(vc+hc<size+px+py ))
								in_shape<=1;
							else in_shape<=0;
						
						end
				endcase
			
			

			
			parallelogram:
				case (toward)
					2'b00:	
						begin
							if ((hc<px)&&(hc+size>px )&&(vc+px <hc+py) && (vc+px+size+size>hc+py))
								in_shape<=1;
							else in_shape<=0;
						end
					2'b01:
						begin 
							if((vc<py) &&(vc+size>py)&&(vc+hc>px+py)&&(vc+hc<px+py+size+size))
								in_shape<=1;
							else in_shape<=0;
						
						end
					
					
					2'b10:
						begin 
							if((hc>px )&&(hc<px+size)&&(vc+px>hc+py)&&(vc+px <hc+py+size+size))
								in_shape<=1;
							else in_shape<=0;
						
						end
					
					
					2'b11:
						begin
							if((vc>py)&&(vc<py+size)&&(vc+hc<px+py)&&(vc+hc+size+size>px+py))
								in_shape<=1;
							else in_shape<=0;
						
						end
				endcase
			

			diamond:begin
				if ((vc+px<hc+size+py)&&(vc+px+size >hc+py )&&(vc+hc<px+py+size) &&(vc+hc+size>px+py))
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