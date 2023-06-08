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
#5 rst_n =1; //현재 왼쪽 방향으로 걷는중
#10 bump_right=1; //오른쪽에 장애물이 있는 경우
#10 bump_left=1; bump_right=0; //왼쪽에 장애물이 있는 경우 ->  오른쪽 방향으로 걷기 시작한다.
#10 bump_left=0; bump_right=0; 
#10 bump_left=1; bump_right=1;//왼쪽과 오른쪽 둘다 장애물이 있는 경우 ->  오른쪽에 장애물이 존재해서 왼쪽으로 걷다가
                               //왼쪽에도 장애물이 있어서 다시, 오른쪽 방향으로 걷기 시작한다.
#40 bump_left=0; bump_right=0;
#10 ground=0; //낭떨어지가 존재 -> 오른쪽으로 떨어진다. 
#40 ground=1; //다시, 오른쪽으로 걷기 시작한다.
#20 dig=1; //오른쪽 땅을 파기 시작한다.
#10 dig=0; ground=0; //땅을 다 파서, 오른쪽으로 떨어진다.
#20 ground=1; //다시, 오른쪽으로 걷기 시작한다.
#20 $finish;

end

always #10 clk=~clk; //주기가 20인 clk 생성(20ns,40ns,..에서 positive edge)

Lemmings_3 DUT(.clk(clk), .rst_n(rst_n), .bump_left(bump_left), .bump_right(bump_right), .ground(ground), .dig(dig), 
               .walk_left(walk_left), .walk_right(walk_right), .aaah(aaah), .digging(digging));

endmodule
