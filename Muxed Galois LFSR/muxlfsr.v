`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/25 14:56:20
// Design Name: 
// Module Name: muxlfsr
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


module muxlfsr(clk, arst_n, r, L, LFSR);
input clk;
input arst_n;
input [2:0] r; //mux�� L�� 1�� ���, ���Ӱ� �Է��� 3bit r
input L; //L=1�� ���: ���ο�� �������Ϳ� ����, L=0�� ���: SHIFT����
output reg [2:0] LFSR; //3bit

always @(posedge clk or negedge arst_n) begin
    if(!arst_n) LFSR <= 4'b001; //arst_n�� 0�� ��� LFSR�� �ش� ������ �ʱ�ȭ
    else begin
        if(L) LFSR <= {r[0],r[1],r[2]}; //L=1�� ���
        else LFSR <= {LFSR[0],LFSR[2],LFSR[1]^LFSR[0]}; //L=0�� ���
    end
end

endmodule
