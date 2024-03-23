`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/16 22:40:11
// Design Name: 
// Module Name: task_c
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


module task_c(
	input clk,
	input btn_down,
	input enable, // Added enable signal
	output reg led3,
	input [12:0] pixel_index,
	output reg [15:0] pixel_data
	);
    
	wire clk6p25m, clk_25M, slow_clk, clk_12p5M, clk20Hz;
	wire fb, sample_pixel;
	wire [5:0] pixel_y;
	wire [6:0] pixel_x;
	assign pixel_y = pixel_index / 96;
	assign pixel_x = pixel_index % 96;
    
	// Button debounce variables
	reg btn_down_prev = 0, btn_down_debounced = 0;
    
	// Animation and position variables
	reg [5:0] square_y_pos = 0; // Initial Y position of the square
	reg [5:0] square_x_pos = 45;
	reg moving = 0;
	reg [8:0]moving_counter = 0;
	reg [8:0]count = 0;


	parameter RED = 16'b11111_000000_00000;
	parameter BLACK = 16'b00000_000000_00000;
	parameter GREEN = 16'b00000_111111_00000;
    
	always @(posedge clk20Hz) begin
	if (enable) begin
    	led3<=1;
   	if (btn_down != btn_down_prev) begin
      	btn_down_debounced <= btn_down;
      	btn_down_prev <= btn_down;
      	if (btn_down_debounced && !moving) begin
          	moving <= 1;
      	end
  	end
	end else begin
    	led3<=0;
        	moving <= 0;
    	btn_down_prev <= 0;
    	btn_down_debounced <= 0;
    	
	end
	end
 	 
 	always @(posedge clk20Hz) begin
 	if (enable) begin
        	if (moving==1 && moving_counter<=29) begin
            	moving_counter = moving_counter+1;
            	square_y_pos<=square_y_pos+1;
        	end
        	else if (moving==1&& moving_counter>29 && moving_counter<=44) begin
            	moving_counter= moving_counter+1;
            	square_x_pos<=square_x_pos+1;
        	end
        	else if (moving==1&& moving_counter>44 && moving_counter<=55) begin
            	moving_counter<= moving_counter+1;
        	end
        	else if (moving==1&& moving_counter>55 && moving_counter<85) begin
            	moving_counter<= moving_counter+1;
            	if  (moving_counter%2==0) begin
            	square_x_pos<=square_x_pos-1;
            	end
        	end
        	else if (moving==1 && moving_counter>=85 && moving_counter<=145) begin
            	moving_counter<= moving_counter+1;
            	if (moving_counter%2==0) begin
            	square_y_pos<=square_y_pos-1;
            	end
        	end
        	else if (moving==1 && moving_counter>145 && moving_counter<=154) begin
            	moving_counter<= moving_counter+1;
        	end
        	else if (moving==1 && moving_counter==155) begin
            	moving_counter<=0;
            	count<=count+1;
        	end
    	end else begin
    	square_y_pos <= 0;
    	square_x_pos <= 45;
    	moving_counter <= 0;
count <= 0;
end
    	end

	 
	always @(posedge clk6p25m) begin
	if (enable) begin
   	 
    	pixel_data<= BLACK;
    	if (count==0 && moving_counter<=29  ) begin
        	if (pixel_y < square_y_pos + 5 && pixel_x >= 45 && pixel_x < 50) begin // 0<=y<y_pos+5, 45<=x<50
            	pixel_data <= RED;
        	end
     	end
     	if (count!=0 && moving_counter<=29) begin
        	if (pixel_y < square_y_pos + 5 && pixel_x >= 45 && pixel_x < 50) begin// 0<=y<y_pos+5, 45<=x<50
            	pixel_data <= RED;
        	end
        	if (pixel_y > square_y_pos + 5 && pixel_y<35 &&  pixel_x>=45 &&  pixel_x< 50) begin // y_pos+5<=y<35, 45<=x<50
            	pixel_data <= GREEN;
        	end
        	if (pixel_y>=30 && pixel_y<35 && pixel_x>=50 &&  pixel_x< 65) begin // 30<=y<35, 50<=x<65
            	pixel_data <= GREEN;
        	end
     	end
    	 
     	if (moving_counter>29 && moving_counter<=54) begin
        	if (count==0) begin
            	if (pixel_y<35 && pixel_x>=45 && pixel_x<50 ) begin
            	pixel_data <= RED;
            	end
            	if (pixel_y>=30 && pixel_y<35 && pixel_x>=45 && pixel_x<square_x_pos + 5) begin //30<=y<35, 45<x<x-pos+5
                	pixel_data <= RED;
            	end
        	end
        	if (count!=0) begin
            	if (pixel_y<35 && pixel_x>=45 && pixel_x<50 ) begin // 0<=y<35, 45<=x<50
                	pixel_data <= RED;
            	end
            	if (pixel_y>=30 && pixel_y<35 && pixel_x>=45 && pixel_x<square_x_pos + 5) begin //30<=y<35, 45<=x<x-pos+5
                	pixel_data <= RED;
            	end
            	if (pixel_y>=30 && pixel_y<35 && pixel_x<65 && pixel_x>=square_x_pos + 5) begin //30<=y<35, x-pos+5<=x<65
                	pixel_data <= GREEN;
            	end
        	end
     	end
    	 
     	if (moving_counter>54 && moving_counter<85) begin
        	if (pixel_y<30 && pixel_x>=45 && pixel_x<50 ) begin// 0<=y<30, 45<=x<50
            	pixel_data <= RED;
        	end
        	if (pixel_y>=30 && pixel_y<35 && pixel_x>=45 && pixel_x<square_x_pos) begin //30<=y<35, 45<=x<x-pos
            	pixel_data <= RED;
        	end
        	if (pixel_y>=30 && pixel_y<35 && pixel_x<65 && pixel_x>=square_x_pos) begin //30<=y<35, x-pos<=x<65
            	pixel_data <= GREEN;
        	end
     	end
    	 
     	if (moving_counter>=85 && moving_counter<=154) begin
         	if (pixel_y>=30 && pixel_y<35 && pixel_x>=50 &&  pixel_x< 65) begin // 30<=y<35, 50<=x<65
            	pixel_data <= GREEN;
         	end
         	if (pixel_y > square_y_pos && pixel_y<35 &&  pixel_x>=45 &&  pixel_x< 50) begin // y_pos<=y<35, 45<=x<50
            	pixel_data <= GREEN;
         	end
         	if (pixel_y < square_y_pos && pixel_x >= 45 && pixel_x < 50) begin // 0<=y<y_pos, 45<=x<50
            	pixel_data <= RED;
         	end
     	end
	end    
	end
    
// Generate a 6.25MHz clock from the 100MHz input clock
        the_flexible_module clk6p25m_clocking (
            clk,
            7, // 6.25 MHz
            clk6p25m
        );
            the_flexible_module clk20Hz_clocking (
            clk,
            2499999, // 20Hz
            clk20Hz
        );
	endmodule
