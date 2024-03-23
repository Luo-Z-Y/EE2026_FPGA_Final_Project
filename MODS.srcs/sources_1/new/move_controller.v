`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/11 21:25:57
// Design Name: 
// Module Name: move_controller
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



module move_controller
( 
    input [7:0] x1, x2,
    input [6:0] y1, y2,      
    input clk,
    input btnU, btnD, btnL, btnR,
    input reset,
    input sw,
    output [7:0] x_1, x_2,
    output [6:0] y_1, y_2
);   
        
    //Clock
    reg [31:0] m1 = 1111110;
    reg [31:0] m2 = 1666666;
    
    wire clk_45hz;
    wire clk_30hz;
    
    the_flexible_module clock_45hz (clk, m1, clk_45hz);
    the_flexible_module clock_30hz (clk, m2, clk_30hz);
    
    reg [7:0] left_bound1, right_bound1, left_bound2, right_bound2, left_bound3, right_bound3;
    reg [6:0] up_bound1, down_bound1, up_bound2, down_bound2, up_bound3, down_bound3;

    //bound1
    always @(posedge clk_30hz)
    begin    
        if (!btnU && !btnD && !btnL && !btnR)
        begin
            left_bound1 <= x1; 
            right_bound1 <= x2; 
            up_bound1 <= y1; 
            down_bound1 <= y2;
        end
        else if (btnU && y1 > 0)
        begin
            left_bound1 <= x1;
            right_bound1 <= x2;
            up_bound1 <= up_bound1 - 1;
            down_bound1 <= down_bound1 - 1;
        end
        else if (btnD && y2 < 63)
        begin
            left_bound1 <= x1;
            right_bound1 <= x2;
            up_bound1 <= up_bound1 + 1;
            down_bound1 <= down_bound1 + 1;
        end
        else if (btnL && x1 > 0)
        begin
            left_bound1 <= left_bound1 - 1;
            right_bound1 <= right_bound1 - 1;
            up_bound1 <= y1;
            down_bound1 <= y2;
        end
        else if (btnR && x2 < 95)
        begin
            left_bound1 <= left_bound1 + 1;
            right_bound1 <= right_bound1 + 1;
            up_bound1 <= y1;
            down_bound1 <= y2;
        end
    end
    
     //bound2
    always @(posedge clk_45hz)
    begin
        if (!btnU && !btnD && !btnL && !btnR)
        begin
            left_bound2 <= x1; 
            right_bound2 <= x2;
            up_bound2 <= y1; 
            down_bound2 <= y2; 
        end
        if (btnU && y1 > 0)
        begin
            left_bound2 <= x1;
            right_bound2 <= x2;
            up_bound2 <= up_bound2 - 1;
            down_bound2 <= down_bound2 - 1;
        end
        if (btnD && y2 < 63)
        begin
            left_bound2 <= x1;
            right_bound2 <= x2;
            up_bound2 <= up_bound2 + 1;
            down_bound2 <= down_bound2 + 1;
        end
        if (btnL && x1 > 0)
        begin
            left_bound2 <= left_bound2 - 1;
            right_bound2 <= right_bound2 - 1;
            up_bound2 <= y1;
            down_bound2 <= y2;
        end
        if (btnR && x2 < 95)
        begin
            left_bound2 <= left_bound2 + 1;
            right_bound2 <= right_bound2 + 1;
            up_bound2 <= y1;
            down_bound2 <= y2;
        end
    end
    
    always @(posedge clk)
    begin
        if (reset)
        begin
            left_bound3 <= 45;
            right_bound3 <= 49;
            up_bound3 <= 59;
            down_bound3 <= 63;
        end
    end
    
    assign x_1 = reset ? left_bound3 :
     sw ? left_bound1 : left_bound2;
    assign x_2 = reset ? right_bound3 :
    sw ? right_bound1 : right_bound2;
    assign y_1 = reset ? up_bound3 :
    sw ? up_bound1 : up_bound2;
    assign y_2 = reset ? down_bound3 :
    sw ? down_bound1 : down_bound2;
    
endmodule
