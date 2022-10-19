module shape_control(
	input clk,
	input reset,
	input [10:0] hc,vc,
	input vidon,
	input [2:0] flag,
	
	input [1:0] shape,
	input [9:0] size ,
	input select,
	input [3:0] move,
	input rotate,
	input disturb,
	
	output color 
	
);
	
	wire  [10:0] px_st,py_st;
    wire  [1:0] tw_st;
	assign px_st=	(flag==1)?416:
					(flag==2)?616:
					(flag==3)?516:
					(flag==4)?716:
					(flag==5)?816:
					(flag==6)?616:
					816;
					
	assign py_st=	(flag==1)?327:
					(flag==2)?527:
					(flag==3)?127:
					(flag==4)?327:
					(flag==5)?127:
					(flag==6)?227:
					527;	
	
	assign tw_st=	(flag==1)?1:
					(flag==2)?0:
					(flag==3)?2:
					(flag==4)?3:
					(flag==5)?0:
					(flag==6)?0:
					0;		
	
	reg [10:0] px,py;
	reg [1:0] toward;
	
	reg [11:0] q;
    always@(posedge clk)begin
        if(!reset)begin
            q <= 12'd1;
        end
        else begin
			q[11] <= q[0];
			q[10] <= q[11];
			q[9] <= q[10];
			q[8] <= q[9];
			q[7] <= q[8];
			q[6] <= q[7];
			q[5] <= q[6];
            q[4] <= q[5];
            q[3] <= q[4];
            q[2] <= q[3] ^ q[0];
            q[1] <= q[2];
            q[0] <= q[1];
        end
    end

	

	



	reg [18:0] cnt_btn;
	always @(posedge clk) begin 
		if (move) cnt_btn<=cnt_btn+1;
		else cnt_btn<=0;
	
	end
	
	
	
	always @(posedge clk) begin 
		if (!reset) begin		//恢复成初始的位置
			px<=px_st;
			py<=py_st;
			toward<=tw_st;
		end
		
		else if (disturb) begin //扰动成随机的
			px<=q%600+316;
			py<=q%400+127;
		end
	
		else begin 				//按照上下左右的按键移�?
			if (select) begin 
				if (cnt_btn==523) begin 
					if (move[0]) begin px<=px;py<=py-1;toward<=toward; end
					else if (move[1]) begin px<=px;py<=py+1;toward<=toward; end
					else if (move[2]) begin px<=px-1;py<=py;toward<=toward;end
					else if (move[3]) begin px<=px+1;py<=py;toward<=toward;end
					else if (rotate) begin px<=px;py<=py;toward<=toward+1;end
					else begin px<=px;py<=py;toward<=toward;end
				end
				
				else begin end
			end
			
			else begin px<=px;py<=py;toward<=toward;end
		
		end	
	
	end

 

	shape shape1(
	    .clk_40m(clk),
		.hc(hc),
		.vc(vc),
		.vidon(vidon),
		
		.shape(shape),
		.size(size),
		.px(px),
		.py(py),
		.toward(toward),
		
		.color(color)
	);

	


	
	

	
endmodule