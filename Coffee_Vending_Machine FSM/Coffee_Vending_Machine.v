`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/17 20:44:33
// Design Name: 
// Module Name: Coffee_Vending_Machine
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


module Coffee_Vending_Machine(clk, rst_n, coin, buy, coffee, return);
input clk;
input rst_n;
input coin;
input buy;
output coffee;
output return;

//present_state ����
localparam S0 = 3'b000,
           S1 = 3'b001,
           S2 = 3'b010,
           S3 = 3'b011,
           S4 = 3'b100;
           //S0:�ʱ����(����:0��), S1:100���� �Էµ� ����, S2:200���� �Էµ� ����, S3:300���� �Էµ� ����, S4:Ŀ�Ǹ� ���������� ������ ����
reg [2:0] present_state, next_state;

//update present state - Sequential logic
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) present_state <= S0; //rst_n�� negative egde�� ���, present state�� S0�� �ʱ�ȭ�Ѵ�.
    else present_state <= next_state;
end

//update next state - Combinational logic
always @(*) begin 
    case(present_state)
        S0: //���� ���°� �������� ���
            if(coin==1) next_state = S1; //coin 1�� �Է��� ���, ���°� S1(���� ������ 100���� ���)���� �̵�.
            else next_state = S0;  //�׷��� ���� ���, ��� �ʱ���·� �����Ѵ�.
        
        S1: //���� ������ 100���� �ԷµǾ� �ִ� ����
            if(coin==1) next_state = S2; //������ 100�� �ԷµǸ�, ���� S2(���� ������ 200���� ���)���� �̵�.
            else begin
                if(buy==1) next_state = S0; //������ 300���� ��� ������ ���� ��Ȳ���� buy�� ���, �ٽ� ���� S0(������)���� ���ư���.
                else next_state = S1; //�����ϰų� ���� �Է¾��� ������ ���� 100���� �ԷµǾ��ִ� ���� (��������)
            end
                
        S2: //���� ������ 200���� �ԷµǾ� �ִ� ����
            if(coin==1) next_state = S3; //������ 100�� �ԷµǸ�, ���� S3(���� ������ 300���� ���)���� �̵�.
            else begin
                if(buy==1) next_state = S0; //������ 300���� ��� ������ ���� ��Ȳ���� buy�� ���, �ٽ� ���� S0(������)���� ���ư���.
                else next_state = S2; //�����ϰų� ���� �Է¾��� ������ ���� 200���� �ԷµǾ��ִ� ���� (��������)
            end
            
        S3: //���� ������ 300���� �ԷµǾ� �ִ� ����, ���� ���Ÿ� ���� ����
            if(buy==1) next_state = S4; //���Ÿ� �ϸ�, ���� S4(Ŀ�ǰ� ������ ���)���� �̵�.
            else begin
                if(coin==1) next_state = S0; //���� 300���� �ԷµǾ��ִ� ���¿���, ������ �� �ԷµǸ� �ٽ� S0(��� ����)�� ���ư���.
                else next_state = S3; //�߰����� ���� ������ ���ų�, �������� ���� ��� ���� S3�� �����Ѵ�.
            end
            
        S4: //������ 300���� �𿩼�, ������ ����
            if(coin==1) next_state = S1; //�ٽ�, ������ 100�� ������ ���� S1(���� ������ 100���� ����)�� ���ư���.
            else next_state = S0; //Ŀ�Ǹ� ������ �����̹Ƿ�, �ٽ� �ʱ����(S0)�� ���ư���.
            
        default: next_state = S0;
    endcase
end

//��°� output
assign coffee = (present_state == S4);
assign return = (present_state == S0);
endmodule
