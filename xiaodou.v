//������⣬��������ʹ��ʶ�𰴼��������ǣ���һ�£��ƿ�����һ�£��ƹ�
//Ĭ�ϵͣ�����ʱ��
//reset���µͣ�

module xiaodou(	
	input clk,
    input reset,
    input key,
    output  key_out
	);
	
	reg keyout_reg;
	reg [17:0] cnt;
	reg count_full;
	
	//�ڰ�������ʱ����������������flag
	always @(posedge clk) begin
		if (!reset) cnt<=0;
		else if ( key ) cnt<=cnt+1;
		else cnt<=0;
	end
	
	//��count fullֵ
	always @(posedge clk) begin
		if (!reset) count_full<=0;
		else if (cnt==24900) count_full<=1;
		else if (!key) count_full<=0;
		else count_full<=count_full;
	end
	
	//����ǰ��Ķ����������
	always @ (posedge clk) begin
		if (!reset) keyout_reg<=0;
		else if (!count_full && cnt==24900) keyout_reg<=1;
		else keyout_reg<=0;
	end
	
	assign key_out=keyout_reg;
endmodule

	