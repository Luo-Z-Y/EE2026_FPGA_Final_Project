`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/16 22:22:05
// Design Name: 
// Module Name: altstep
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


module altstep(
    input clk,
    input btnL,
    input btnR,
    input reached200ms,
    input reach50ms,
    output reg [2:0] step
    );
    reg prev_btnL = 0;
    reg prev_btnR = 0;
    initial step = 5;
    always @ (posedge clk) begin
        if (reached200ms) begin
            // Handling button L press
            if (btnL && !prev_btnL) begin
                if (step > 1)
                    step <= step - 1;
                prev_btnL <= 1;
            end
            else if (!btnL)
                prev_btnL <= 0;

            // Handling button R press
            if (btnR && !prev_btnR) begin
                if (step < 5)
                    step <= step + 1;
                prev_btnR <= 1;
            end
            else if (!btnR)
                prev_btnR <= 0;

            // Ensure step remains unchanged when at the edge
            if (step == 1 && btnL)
                prev_btnL <= 1;
            if (step == 5 && btnR)
                prev_btnR <= 1;
        end
    end
endmodule

