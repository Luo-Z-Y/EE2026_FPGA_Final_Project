`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/16 23:03:41
// Design Name: 
// Module Name: counter_a
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


module counter_a(input basys_clock, reset, output reg [31:0] count);
    always @ (posedge basys_clock) 
    begin
        count <= (count == 550000000 || reset)? 0:(count + 1);
    end
endmodule

