`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/17 21:44:02
// Design Name: 
// Module Name: tb_Coffee_Vending_Machine
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


module tb_Coffee_Vending_Machine;
reg clk;
reg rst_n;
reg coin;
reg buy;
wire coffee;
wire return;

Coffee_Vending_Machine DUT(.clk(clk), .rst_n(rst_n), .coin(coin), .buy(buy), .coffee(coffee), .return(return));

initial begin
clk=1; rst_n=1; coin=0; buy=0;
#10 rst_n=0; //present_state�� S0(������)�� �ʱ�ȭ �ȴ�.
#10 rst_n=1;
#20 coin=1; //present_state�� S1(���� 100���� ����)�� �̵��Ѵ�.
#20 coin=0;
#10 coin=1;
#20 coin=0;
#20 coin=1;
#30 coin=0;
#10 buy=1;
#20 buy=0;
#10 coin = 1;
#90 $finish;
end

always #10 clk = ~clk; //positive edge�� ���(20ns,40ns,....)

endmodule
