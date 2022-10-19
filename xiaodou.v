//按键检测，消抖处理，使能识别按键，测试是，按一下，灯开，按一下，灯关
//默认低，按下时高
//reset按下低，

module xiaodou(	
	input clk,
    input reset,
    input key,
    output  key_out
	);
	
	reg keyout_reg;
	reg [17:0] cnt;
	reg count_full;
	
	//在按键按下时计数，计数满后立flag
	always @(posedge clk) begin
		if (!reset) cnt<=0;
		else if ( key ) cnt<=cnt+1;
		else cnt<=0;
	end
	
	//给count full值
	always @(posedge clk) begin
		if (!reset) count_full<=0;
		else if (cnt==24900) count_full<=1;
		else if (!key) count_full<=0;
		else count_full<=count_full;
	end
	
	//根据前面的东西决定输出
	always @ (posedge clk) begin
		if (!reset) keyout_reg<=0;
		else if (!count_full && cnt==24900) keyout_reg<=1;
		else keyout_reg<=0;
	end
	
	assign key_out=keyout_reg;
endmodule

	