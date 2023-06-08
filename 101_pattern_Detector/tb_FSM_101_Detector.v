`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/12 01:22:28
// Design Name: 
// Module Name: tb_FSM_101_Detector
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


module tb_FSM_101_Detector;
reg clk;
reg rst_n;
reg X;
wire Y;

FSM_101_Detector DUT(.clk(clk), .rst_n(rst_n), .X(X), .Y(Y));

initial begin
clk=0; rst_n=1; X=0;
#5 rst_n=0; //rst_n : 1 -> 0 ���� negative edge, present_state <= S0(00) �ʱ�ȭ
#5 rst_n=1;
#10 X=1;
#10 X=0;
#10 X=0;
#10 X=1;
#10 X=0;
#10 X=1;
#10 X=0;
#10 X=0;
#10 X=1;
#10 X=0;
#10 X=0;
#10 X=1;
#10 X=1;
#10 X=0;
#10 X=1;
#10 X=0;
#10 $finish;
end

always #5 clk=~clk; //�ֱⰡ 10�� clk����

endmodule
