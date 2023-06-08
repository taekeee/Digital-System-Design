`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/17 19:05:16
// Design Name: 
// Module Name: tb_Lemmings_3
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


module tb_Lemmings_3;
reg clk;
reg rst_n;
reg bump_left;
reg bump_right;
reg ground;
reg dig;
wire walk_left;
wire walk_right;
wire aaah;
wire digging;

initial begin
clk=1; rst_n=1; bump_left=0; bump_right=0; ground=1; dig=0;
#5 rst_n=0;
#5 rst_n =1; //���� ���� �������� �ȴ���
#10 bump_right=1; //�����ʿ� ��ֹ��� �ִ� ���
#10 bump_left=1; bump_right=0; //���ʿ� ��ֹ��� �ִ� ��� ->  ������ �������� �ȱ� �����Ѵ�.
#10 bump_left=0; bump_right=0; 
#10 bump_left=1; bump_right=1;//���ʰ� ������ �Ѵ� ��ֹ��� �ִ� ��� ->  �����ʿ� ��ֹ��� �����ؼ� �������� �ȴٰ�
                               //���ʿ��� ��ֹ��� �־ �ٽ�, ������ �������� �ȱ� �����Ѵ�.
#40 bump_left=0; bump_right=0;
#10 ground=0; //���������� ���� -> ���������� ��������. 
#40 ground=1; //�ٽ�, ���������� �ȱ� �����Ѵ�.
#20 dig=1; //������ ���� �ı� �����Ѵ�.
#10 dig=0; ground=0; //���� �� �ļ�, ���������� ��������.
#20 ground=1; //�ٽ�, ���������� �ȱ� �����Ѵ�.
#20 $finish;

end

always #10 clk=~clk; //�ֱⰡ 20�� clk ����(20ns,40ns,..���� positive edge)

Lemmings_3 DUT(.clk(clk), .rst_n(rst_n), .bump_left(bump_left), .bump_right(bump_right), .ground(ground), .dig(dig), 
               .walk_left(walk_left), .walk_right(walk_right), .aaah(aaah), .digging(digging));

endmodule
