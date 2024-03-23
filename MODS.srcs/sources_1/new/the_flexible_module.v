`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/04 09:18:54
// Design Name: 
// Module Name: the_flexible_module
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


module the_flexible_module
(
    input clock_in,
    input [31:0] m,
    output reg clock_out
); 
   
    reg [31:0] count = 0;
    
    initial begin 
        clock_out = 0; 
    end
    
    always @ (posedge clock_in) begin 
        
        // f_desird = f_in_clock /  [2(m + 1)]
        count <= (count == m) ? 0 : count + 1;
        
        //Inside always block, use reg instead of output
        clock_out <= ( count == 0 ) ? ~clock_out : clock_out;
    end
    
endmodule

