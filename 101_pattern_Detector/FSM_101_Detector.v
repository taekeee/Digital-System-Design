`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/11 23:30:08
// Design Name: 
// Module Name: FSM_101_Detector
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


module FSM_101_Detector(clk, rst_n, X, Y);
input clk;
input rst_n;
input X;
output Y;

 //state���� localparm���� ����
localparam S0 = 2'b00,
           S1 = 2'b01,
           S2 = 2'b10,
           S3 = 2'b11; 

 reg [1:0] present_state, next_state;
  
//Next State ��� - Combinational logic�� �̿��Ͽ� ���� ���¸� ����Ѵ�.
always @(present_state or X) begin
    next_state = S0; //next state���� S0(00)���� �ʱⰪ ����
    case(present_state)
        S0:
        if(X)
            next_state = S1; //X=1�� ��� S0 -> S1
        else
            next_state = S0; //X=0�� ��� S0 -> S0 (���� ���� ����)
        
        S1:
        if(X)
            next_state = S1; //X=1�� ��� S1 -> S1 (���� ���� ����)
        else
            next_state = S2; //X=0�� ��� S1 -> S2
        
        S2:
        if(X)
            next_state = S3; //X=1�� ��� S2 -> S3
        else
            next_state = S0; //X=0�� ��� S2 -> S0 (�ʱ�ȭ���ش�. 0�� 2���̻���ʹ� "101"�� ���¸� ����� ����)

        S3:
        if(X)
             next_state = S1; //"1011"�� ��Ȳ.
        else
            next_state = S0;//"1010"�� ��Ȳ, �ٽ� ó������ �ʱ�ȭ�� ������Ѵ�.

        default : next_state = S0;
    endcase
end

//Present State ��� - Sequential logic�� �̿��Ͽ� ���� ���¸� ������Ʈ�Ѵ�.
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) present_state <= S0; //rest�۵���, present_state�� S0(00)���� �����Ѵ�.
    else
        present_state <= next_state;
end

//assign���� �̿��Ͽ� ��� ��� - Combinational logic
assign Y = (present_state == S2 && X == 1);
 
endmodule