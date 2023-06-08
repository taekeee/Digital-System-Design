`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/25 15:09:57
// Design Name: 
// Module Name: tb_muxlfsr
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


module tb_muxlfsr;
reg clk;
reg arst_n;
reg [2:0] r; //3bit
reg L;
wire [2:0] LFSR;

initial begin
clk=0; arst_n=1; r=0; L=0;
#5 arst_n=0;
#5 arst_n=1; L=0;
#50 L=1; r=3'b111; //L=1인 경우 레지스터에 새로운값(010)이 저장된다.
#10 L=0;

end

always #5 clk=~clk; //주기가 10인 clk형성

muxlfsr DUT(.clk(clk), .arst_n(arst_n), .r(r), .L(L), .LFSR(LFSR));

endmodule
