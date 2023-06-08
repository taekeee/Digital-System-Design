`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/25 15:09:57
// Design Name: 
// Module Name: tb_muxlfsr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_muxlfsr;
reg clk;
reg arst_n;
reg [2:0] r; //3bit
reg L;
wire [2:0] LFSR;

initial begin
clk=0; arst_n=1; r=0; L=0;
#5 arst_n=0;
#5 arst_n=1; L=0;
#50 L=1; r=3'b111; //L=1�� ��� �������Ϳ� ���ο(010)�� ����ȴ�.
#10 L=0;

end

always #5 clk=~clk; //�ֱⰡ 10�� clk����

muxlfsr DUT(.clk(clk), .arst_n(arst_n), .r(r), .L(L), .LFSR(LFSR));

endmodule
