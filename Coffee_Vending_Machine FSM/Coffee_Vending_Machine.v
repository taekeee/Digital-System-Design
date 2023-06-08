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

//present_state 설정
localparam S0 = 3'b000,
           S1 = 3'b001,
           S2 = 3'b010,
           S3 = 3'b011,
           S4 = 3'b100;
           //S0:초기상태(동전:0원), S1:100원이 입력된 상태, S2:200원이 입력된 상태, S3:300원이 입력된 상태, S4:커피를 정상적으로 구매한 상태
reg [2:0] present_state, next_state;

//update present state - Sequential logic
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) present_state <= S0; //rst_n이 negative egde인 경우, present state를 S0로 초기화한다.
    else present_state <= next_state;
end

//update next state - Combinational logic
always @(*) begin 
    case(present_state)
        S0: //현재 상태가 대기상태인 경우
            if(coin==1) next_state = S1; //coin 1개 입력한 경우, 상태가 S1(현재 동전이 100원인 경우)으로 이동.
            else next_state = S0;  //그렇지 않은 경우, 계속 초기상태로 유지한다.
        
        S1: //현재 동전이 100원이 입력되어 있는 상태
            if(coin==1) next_state = S2; //동전이 100원 입력되면, 상태 S2(현재 동전이 200원인 경우)으로 이동.
            else begin
                if(buy==1) next_state = S0; //동전이 300원이 모두 모이지 않은 상황에서 buy할 경우, 다시 상태 S0(대기상태)으로 돌아간다.
                else next_state = S1; //구매하거나 동전 입력없이 여전히 현재 100원이 입력되어있는 상태 (상태유지)
            end
                
        S2: //현재 동전이 200원이 입력되어 있는 상태
            if(coin==1) next_state = S3; //동전이 100원 입력되면, 상태 S3(현재 동전이 300원인 경우)으로 이동.
            else begin
                if(buy==1) next_state = S0; //동전이 300원이 모두 모이지 않은 상황에서 buy할 경우, 다시 상태 S0(대기상태)으로 돌아간다.
                else next_state = S2; //구매하거나 동전 입력없이 여전히 현재 200원이 입력되어있는 상태 (상태유지)
            end
            
        S3: //현재 동전이 300원이 입력되어 있는 상태, 아직 구매를 하지 않음
            if(buy==1) next_state = S4; //구매를 하면, 상태 S4(커피가 나오는 경우)으로 이동.
            else begin
                if(coin==1) next_state = S0; //현재 300원이 입력되어있는 상태에서, 동전이 더 입력되면 다시 S0(대기 상태)로 돌아간다.
                else next_state = S3; //추가적인 동전 투입이 없거나, 구매하지 않은 경우 상태 S3로 유지한다.
            end
            
        S4: //동전이 300원이 모여서, 구매한 상태
            if(coin==1) next_state = S1; //다시, 동전이 100원 들어오면 상태 S1(현재 동전이 100원인 상태)로 돌아간다.
            else next_state = S0; //커피를 구매한 상태이므로, 다시 초기상태(S0)로 돌아간다.
            
        default: next_state = S0;
    endcase
end

//출력값 output
assign coffee = (present_state == S4);
assign return = (present_state == S0);
endmodule
