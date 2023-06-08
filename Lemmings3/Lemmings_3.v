`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/16 18:32:31
// Design Name: 
// Module Name: Lemmings_3
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


module Lemmings_3(clk, rst_n, bump_left, bump_right, ground, dig, walk_left, walk_right, aaah, digging);
input clk;
input rst_n;
input bump_left; //���� ��ֹ�
input bump_right; //������ ��ֹ�
input ground; //��������
input dig; //���� �Ķ�� ���
output walk_left;
output walk_right;
output aaah;
output digging;

localparam WALK_LEFT = 3'b000, 
           WALK_RIGHT = 3'b001,
           FALL_LEFT = 3'b010,
           FALL_RIGHT = 3'b011,
           DIG_LEFT = 3'b100,
           DIG_RIGHT = 3'b101;
           //0:WALK_LEFT, 1:WALK_RIGHT, 2:FALL_LEFT, 3:FALL_RIGHT, 4:DIG_LEFT, 5:DIG_RIGHT

reg [2:0] present_state, next_state;

always @(posedge clk or negedge rst_n) begin
    //update present state - Sequential logic 
    if(!rst_n) present_state <= WALK_LEFT; //rst_n�� negative edge�� ��� WALK_LEFT�� �ʱ�ȭ�Ѵ�.
    else       present_state <= next_state; //next_state���·� �ٲپ��ش�.
end

always @(*) begin
    case(present_state) //present_state�� input��(ground,dig)�� ���� next_state�� �����Ѵ�.
        WALK_LEFT: //���� �������� �Ȱ� �ִ� ��Ȳ
            if(ground==0) next_state = FALL_LEFT; //���������� ���� ���(gound==0) -> ���� ���������� ��������.
            else begin
                if(dig==1) next_state = DIG_LEFT; //���� �Ķ�� ����� ����(dig==1) -> ������ �� �Ǵ�.
                else //��������, �� �Ķ�� ����� ���� ���
                next_state = (bump_left) ? WALK_RIGHT : WALK_LEFT; //����: �������� �ȴ���, ���ʿ� ��ֹ��� �ִ� ��� WALK_RIGHT(������ȯ)
            end
        WALK_RIGHT: //���� ���������� �Ȱ� �ִ� ��Ȳ
            if(ground==0) next_state = FALL_RIGHT; //���������� ���� ���(gound==0) -> ���������� ��������.
            else begin          
                 if(dig==1) next_state = DIG_RIGHT; //���� �Ķ�� ����� ����(dig==1) -> �������� �� �Ǵ�.
                 else //��������, �� �Ķ�� ����� ���� ���
                 next_state = (bump_right) ? WALK_LEFT : WALK_RIGHT; //����: ���������� �ȴ���, �����ʿ� ��ֹ��� �ִ� ��� WALK_LEFT(������ȯ)
            end
        FALL_LEFT: //���� ���������� �������� �ִ� ���
            if(ground==1) next_state = WALK_LEFT; //���������� ���� ���, ���� �ɾ��� ���� �״�� �ٽ� �ȴ´�.
            else          next_state = FALL_LEFT; //���������� ������ ������ ���� ���
        FALL_RIGHT: //������ ���������� �������� �ִ� ���
            if(ground==1) next_state = WALK_RIGHT; //���������� ���� ���, ���� �ɾ��� ���� �״�� �ٽ� �ȴ´�.
            else          next_state = FALL_RIGHT; //���������� ������ ������ ���� ���
        DIG_LEFT: //���� ���� �Ĵ� ��
            if(ground==0) next_state = FALL_LEFT; //���� ���ļ�, ���������� ������� ���, �������� ��������.
            else          next_state = DIG_LEFT; //������ ���� ���� �Ĵ� ���� ����
        DIG_RIGHT: //������ ���� �Ĵ� ��
             if(ground==0) next_state = FALL_RIGHT; //���� ���ļ�, ���������� ������� ���, ���������� ��������.
             else          next_state = DIG_RIGHT; //������ ������ ���� �Ĵ� ���� ����
        default:
            next_state <= WALK_LEFT; //present_state�� �־����� ���� ���, WALK_LEFT.
        endcase
end

assign walk_left = (present_state == WALK_LEFT); //���� �������� �Ȱ� �ִ�.
assign walk_right = (present_state == WALK_RIGHT); //���� ���������� �Ȱ� �ִ�.
assign aaah = (present_state == FALL_LEFT) || (present_state == FALL_RIGHT); //���� ���������� �������� �ִ�.
assign digging = (present_state == DIG_LEFT) || (present_state == DIG_RIGHT); //���� ���� �İ� �ִ�.

endmodule
