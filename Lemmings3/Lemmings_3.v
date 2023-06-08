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
input bump_left; //왼쪽 장애물
input bump_right; //오른쪽 장애물
input ground; //낭떠러지
input dig; //땅을 파라는 명령
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
    if(!rst_n) present_state <= WALK_LEFT; //rst_n이 negative edge인 경우 WALK_LEFT로 초기화한다.
    else       present_state <= next_state; //next_state상태로 바꾸어준다.
end

always @(*) begin
    case(present_state) //present_state와 input값(ground,dig)에 따라서 next_state를 결정한다.
        WALK_LEFT: //현재 왼쪽으로 걷고 있는 상황
            if(ground==0) next_state = FALL_LEFT; //낭떠러지를 만난 경우(gound==0) -> 왼쪽 낭떠러지로 떨어진다.
            else begin
                if(dig==1) next_state = DIG_LEFT; //땅을 파라는 명령을 만남(dig==1) -> 왼쪽을 땅 판다.
                else //낭떨어지, 땅 파라는 명령이 없는 경우
                next_state = (bump_left) ? WALK_RIGHT : WALK_LEFT; //현재: 왼쪽으로 걷는중, 왼쪽에 장애물이 있는 경우 WALK_RIGHT(방향전환)
            end
        WALK_RIGHT: //현재 오른쪽으로 걷고 있는 상황
            if(ground==0) next_state = FALL_RIGHT; //낭떠러지를 만난 경우(gound==0) -> 오른쪽으로 떨어진다.
            else begin          
                 if(dig==1) next_state = DIG_RIGHT; //땅을 파라는 명령을 만남(dig==1) -> 오른쪽을 땅 판다.
                 else //낭떨어지, 땅 파라는 명령이 없는 경우
                 next_state = (bump_right) ? WALK_LEFT : WALK_RIGHT; //현재: 오른쪽으로 걷는중, 오른쪽에 장애물이 있는 경우 WALK_LEFT(방향전환)
            end
        FALL_LEFT: //왼쪽 낭떠러지로 떨어지고 있는 경우
            if(ground==1) next_state = WALK_LEFT; //낭떠러지가 끝난 경우, 이전 걸었던 방향 그대로 다시 걷는다.
            else          next_state = FALL_LEFT; //낭떠러지가 여전히 끝나지 않은 경우
        FALL_RIGHT: //오른쪽 낭떨어지로 떨어지고 있는 경우
            if(ground==1) next_state = WALK_RIGHT; //낭떨어지가 끝난 경우, 이전 걸었던 방향 그대로 다시 걷는다.
            else          next_state = FALL_RIGHT; //낭떨어지가 여전히 끝나지 않은 경우
        DIG_LEFT: //왼쪽 땅을 파는 중
            if(ground==0) next_state = FALL_LEFT; //땅을 다파서, 낭떠러지가 만들어진 경우, 왼쪽으로 떨어진다.
            else          next_state = DIG_LEFT; //여전히 왼쪽 땅을 파는 중인 상태
        DIG_RIGHT: //오른쪽 땅을 파는 중
             if(ground==0) next_state = FALL_RIGHT; //땅을 다파서, 낭떠러지가 만들어진 경우, 오른쪽으로 떨어진다.
             else          next_state = DIG_RIGHT; //여전히 오른쪽 땅을 파는 중인 상태
        default:
            next_state <= WALK_LEFT; //present_state가 주어지지 않은 경우, WALK_LEFT.
        endcase
end

assign walk_left = (present_state == WALK_LEFT); //현재 왼쪽으로 걷고 있다.
assign walk_right = (present_state == WALK_RIGHT); //현재 오른쪽으로 걷고 있다.
assign aaah = (present_state == FALL_LEFT) || (present_state == FALL_RIGHT); //현재 낭떠러지로 떨어지고 있다.
assign digging = (present_state == DIG_LEFT) || (present_state == DIG_RIGHT); //현재 땅을 파고 있다.

endmodule
