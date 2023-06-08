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

 //state들을 localparm으로 정의
localparam S0 = 2'b00,
           S1 = 2'b01,
           S2 = 2'b10,
           S3 = 2'b11; 

 reg [1:0] present_state, next_state;
  
//Next State 계산 - Combinational logic을 이용하여 다음 상태를 계산한다.
always @(present_state or X) begin
    next_state = S0; //next state값을 S0(00)으로 초기값 설정
    case(present_state)
        S0:
        if(X)
            next_state = S1; //X=1인 경우 S0 -> S1
        else
            next_state = S0; //X=0인 경우 S0 -> S0 (현재 상태 유지)
        
        S1:
        if(X)
            next_state = S1; //X=1인 경우 S1 -> S1 (현재 상태 유지)
        else
            next_state = S2; //X=0인 경우 S1 -> S2
        
        S2:
        if(X)
            next_state = S3; //X=1인 경우 S2 -> S3
        else
            next_state = S0; //X=0인 경우 S2 -> S0 (초기화해준다. 0이 2개이상부터는 "101"의 형태를 벗어나기 때문)

        S3:
        if(X)
             next_state = S1; //"1011"인 상황.
        else
            next_state = S0;//"1010"인 상황, 다시 처음부터 초기화를 해줘야한다.

        default : next_state = S0;
    endcase
end

//Present State 계산 - Sequential logic을 이용하여 현재 상태를 업데이트한다.
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) present_state <= S0; //rest작동시, present_state를 S0(00)으로 저장한다.
    else
        present_state <= next_state;
end

//assign문을 이용하여 출력 계산 - Combinational logic
assign Y = (present_state == S2 && X == 1);
 
endmodule