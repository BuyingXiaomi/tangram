
//扫描到一些位置的时�?�给行同步和场同步�?�当的�??
//以及搞明白有效显示范围在：hc(216~1016) vc(27~627)


module vga_driver (
	input wire clk,       // 时钟脉冲
    input wire clr,       // 清零
    output reg hsync,     // HSync 行同步信hao
    output reg vsync,     // VSync 场同步信hao
    output reg [10:0] hc, // count for HSync
    output reg [10:0] vc, // count for VSync
    output reg vidon	  // 1 for count is in visiable range
	);    
    

	
    parameter hpixels = 11'b10000100000; // 行像素点 = 1056
    parameter vlines  = 11'b01001110100; // 行数  = 628
    parameter hbp     = 11'b00011011000; // 行显示后yan     = 216
    parameter hfp     = 11'b01111111000; // 行显示前yan     = 1016
    parameter vbp     = 11'b00000011011; // 场显示后yan     = 27
    parameter vfp     = 11'b01001110011; // 场显示前yan     = 627
    reg vsenable      = 0; // Enable for the Vertical counter
    
	
	
	
	
    initial begin
        hsync = 0;
        vsync = 0;
        hc    = 0;
        vc    = 0;
        vidon = 0;
    end
    
    
    always @(posedge clk or posedge clr) begin
        if (clr == 1)
            hc <= 0;
        else begin
            if (hc == hpixels - 1) begin
                hc       <= 0;
                vsenable <= 1;
            end
            else begin
                hc       <= hc + 1;
                vsenable <= 0;
            end
        end
    end
    
    // 产生HSync脉冲
    // 当hc = 0~127时，行同步脉冲为低电ping
    always @ (*)
    begin
        if (hc < 128) hsync = 0;
        else hsync          = 1;
    end
    
    
    always @(posedge clk or posedge clr) begin
        if (clr == 1) vc <= 0;
        else begin
        if (vsenable == 1) begin
            if (vc == vlines - 1) vc <= 0;
            else vc <= vc + 1;
            end
        end
    end
    
    // 产生VSync脉冲
    // When hc = 0 or 1, 场同步脉冲为低电ping
    always @(*) begin
        if (vc < 4) vsync = 0;
        else vsync        = 1;
    end
    
    // Enable video out when within the proches
    always @ (*) begin
        if ((hc < hfp) && (hc > hbp) && (vc < vfp) && (vc > vbp)) begin
            vidon = 1;
        end
        else vidon = 0;
    end
    
endmodule //VGA_800x600
