`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/16 20:21:39
// Design Name: 
// Module Name: task_d
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


module task_d
(
    input clk,
    input btnC, btnL, btnR, btnU, btnD,
    input sw0,
    input sw4,
    output led4,
    input [12:0] pi,
    output [15:0] pd,
    input reset_task
);

    //Clock
    reg [31:0] m1 = 1;
    wire clk_25mhz;  
    the_flexible_module clock_25mhz (clk, m1, clk_25mhz);
    
    //led4 lights up
    assign led4= sw4;
    
    //task
    reg state = 0; 
    reg [3:0] dir = 0; 
    reg reset_move = 0;
    reg [15:0] pixel_data_out = 0;
        
    reg [6:0] y1, y2;
    reg [7:0] x1, x2;
    wire [6:0] y_1, y_2;
    wire [7:0] x_1, x_2;
    wire [6:0] row;
    wire [7:0] col;
    assign row = pi / 96;
    assign col = pi % 96;
    
    //Main loop 
    always @(posedge clk_25mhz)
    begin
        if(reset_task)
        begin
            state <= 0;
            dir <= 0;
        end 
        //Task D starting display
        //Blue square at the top left corner
        begin
            if (row >= 0 && row <= 4 && col >= 0 && col <= 4)
            begin
                pixel_data_out <= 16'b00000_000000_11111;
            end
            else 
            begin
                pixel_data_out <= 16'b00000_000000_00000;
            end
        end
        
        //Change state
        //White square at the bottom centre
        if (btnC)
        begin
            state <= 1;
            x1 <= 45;
            x2 <= 49;
            y1 <= 59;
            y2 <= 63;            
        end
        
        //White square moves as respective button being pressed and released
        if (state == 1)
        begin
            if (row >= y1 && row <= y2 && col >= x1 && col <= x2)
            begin
                pixel_data_out <= 16'b11111_111111_11111;
            end
            else 
            begin
                pixel_data_out <= 16'b00000_000000_00000;  
            end      
            x1 <= x_1;
            y1 <= y_1;
            x2 <= x_2;
            y2 <= y_2;
            
            if (btnU)
            begin
                reset_move <= 0;
                dir = 4'b1000;
            end
            if (btnD)
            begin
                reset_move <= 0;
                dir <= 4'b0100;
            end
           if (btnL)
            begin
                reset_move <= 0;
                dir <= 4'b0010;
            end
            if (btnR)
            begin
                reset_move <= 0;
                dir <= 4'b0001;
            end 
            if (btnC)
            begin
                reset_move <= 1;
                dir <= 4'b0000;
            end                        
        end
    end
    
    assign pd = pixel_data_out;
    
    move_controller move_unit (x1, x2, y1, y2, clk, dir[3], dir[2], dir[1], dir[0], reset_move, sw0, x_1, x_2, y_1, y_2);
    
        
endmodule
