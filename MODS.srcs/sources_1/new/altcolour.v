`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/16 22:20:35
// Design Name: 
// Module Name: altcolour
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


module altcolour(
    input clk,
    input btnC,
    input reach200ms,
    output reg [1:0] colour_sequence
    );
    reg prev_btnC = 0;
    always @(posedge clk) begin
        if (reach200ms == 1) begin
            if (btnC == 1 && prev_btnC == 0) begin
                // Toggle color sequence in the desired pattern
                case(colour_sequence)
                    2'b00: colour_sequence <= 2'b01; // white -> red
                    2'b01: colour_sequence <= 2'b10; // red -> green
                    2'b10: colour_sequence <= 2'b11; // green -> blue
                    2'b11: colour_sequence <= 2'b00; // blue -> white
                    default: colour_sequence <= 2'b00; // Default case
                endcase
            end
            // Update previous button state
            prev_btnC <= btnC;
        end
    end
endmodule
