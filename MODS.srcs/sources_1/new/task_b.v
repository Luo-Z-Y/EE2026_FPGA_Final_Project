`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/16 22:12:32
// Design Name: 
// Module Name: task_b
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


module task_b 
(
    input basys_clock,
    input sw,
    input btnC,
    input btnR,
    input btnL,
    input [12:0] pixel_index,
    output reg [15:0] oled_data,
    input reset
);

    wire [7:0]JC;
    wire my_6p25mMHz_clock;
    wire my_1kHz_clock;
    wire my_1Hz_clock;
   // reg [15:0] oled_data;
    wire fb;
    wire sample_p;
    reg [7:0] x; //horizontal
    reg [6:0] y; //vertical
    wire [31:0] count;
    reg [2:0] greenpos = 5;
    wire reach50ms;
    wire [1:0] colour_sequence;
    wire btnL_debounce;
    wire btnR_debounce;
    wire [2:0] step;
    wire reached200ms;
 
    the_flexible_module clk_dividing_6p25m (basys_clock, 3'b111,my_6p25mMHz_clock);
    the_flexible_module clk_dividing_1khz (basys_clock,49999 ,my_1kHz_clock);
    the_flexible_module clk_dividing_1hz (basys_clock, 49999999,my_1Hz_clock);
    counter count_add(my_6p25mMHz_clock, count);
    reach200ms yes(my_6p25mMHz_clock,btnL, btnR, btnC, reached200ms);
//    count50ms dut (my_1kHz_clock, btnR, btnL ,reach50ms);
//    handle_debounce avoid_debounce(my_1kHz_clock, btnL, btnR, btnR_debounce, btnL_debounce, start);
    altcolour changeclr(my_6p25mMHz_clock, btnC,reached200ms, colour_sequence);
    altstep changestep(my_6p25mMHz_clock, btnL, btnR,reached200ms,reach50ms, step);
    always @ (posedge my_6p25mMHz_clock) begin
        if(reset == 0) begin
            x <= pixel_index % 96;
            y <= pixel_index / 96;
             if(sw && count >= 50000000) begin
         
                    case (step)
                    5: 
                         if ((x >= 78 && x <= 94 && y >= 24 && y <= 40) &&  !(x >= 81 && x <= 91 && y >= 27 && y <= 37)) begin //green square at the most right
                                    oled_data = 16'b00000_111111_00000;
                            end
                        else begin
                                oled_data = 16'b00000_000000_00000;
                            end
                    4:
                        if(( x>= 64 && x <= 80 && y >= 24 && y <= 40) && !(x >= 67 && x <= 77 && y >= 27 && y <= 37)) begin
                                oled_data = 16'b00000_111111_00000;
                            end
                        else begin
                                oled_data = 16'b00000_000000_00000;
                            end
                   3:                
                        if(( x>= 43 && x <= 59 && y >= 24 && y <= 40) && !(x >= 46 && x <= 56 && y >= 27 && y <= 37)) begin
                            oled_data = 16'b00000_111111_00000;
                            end
                        else begin
                            oled_data = 16'b00000_000000_00000;
                        end 
                    2:
                        if(( x>= 22 && x <= 38 && y >= 24 && y <= 40) && !(x >= 25 && x <= 35 && y >= 27 && y <= 37)) begin
                                oled_data = 16'b00000_111111_00000;
                                end
                        else begin
                            oled_data = 16'b00000_000000_00000;
                        end
                    1: 
                        if(( x>= 1 && x <= 17 && y >= 24 && y <= 40) && !(x >= 4 && x <= 14 && y >= 27 && y <= 37)) begin
                                oled_data = 16'b00000_111111_00000;
                        end
                        else begin
                            oled_data = 16'b00000_000000_00000;
                        end
                   default:  oled_data = 16'b11111_000000_00000;  // no conditions met become red 
                endcase
                case (colour_sequence)
                2'b00:
                     if ((x >= 84 && x <= 89 && y >= 30 && y <= 35) ||   // Rightmost solid white square
                           (x >= 70 && x <= 75 && y >= 30 && y <= 35) ||   // Fourth square
                           (x >= 49 && x <= 54 && y >= 30 && y <= 35) ||   // Third square
                           (x >= 28 && x <= 33 && y >= 30 && y <= 35) ||   // Second square
                           (x >= 7 && x <= 12 && y >= 30 && y <= 35))
                           begin
                               oled_data = 16'b11111_111111_11111;  // Solid white color
                           end
    
                2'b01:
                     if ((x >= 84 && x <= 89 && y >= 30 && y <= 35) ||   // Rightmost solid white square
                           (x >= 70 && x <= 75 && y >= 30 && y <= 35) ||   // Fourth square
                           (x >= 49 && x <= 54 && y >= 30 && y <= 35) ||   // Third square
                           (x >= 28 && x <= 33 && y >= 30 && y <= 35) ||   // Second square
                           (x >= 7 && x <= 12 && y >= 30 && y <= 35))
                           begin
                               oled_data = 16'b11111_000000_00000;  // Solid red color
                           end
    
                2'b10:
                     if ((x >= 84 && x <= 89 && y >= 30 && y <= 35) ||   // Rightmost solid white square
                           (x >= 70 && x <= 75 && y >= 30 && y <= 35) ||   // Fourth square
                           (x >= 49 && x <= 54 && y >= 30 && y <= 35) ||   // Third square
                           (x >= 28 && x <= 33 && y >= 30 && y <= 35) ||   // Second square
                           (x >= 7 && x <= 12 && y >= 30 && y <= 35))
                           begin
                               oled_data = 16'b00000_111111_00000;  // Solid green color
                           end
     
                2'b11:
                     if ((x >= 84 && x <= 89 && y >= 30 && y <= 35) ||   // Rightmost solid white square
                           (x >= 70 && x <= 75 && y >= 30 && y <= 35) ||   // Fourth square
                           (x >= 49 && x <= 54 && y >= 30 && y <= 35) ||   // Third square
                           (x >= 28 && x <= 33 && y >= 30 && y <= 35) ||   // Second square
                           (x >= 7 && x <= 12 && y >= 30 && y <= 35))
                           begin
                               oled_data = 16'b00000_000000_11111;  // Solid blue color
                           end
                default:
                    oled_data = 16'b11111_000000_00000;
                endcase
            
        end //end if sw && count >= 50000000
        else begin //initial condition
            if ((x>= 43 && x <= 59 && y >= 24 && y <= 40) && !(x >= 46 && x <= 56 && y >= 27 && y <= 37))
            begin
                oled_data = 16'b00000_111111_00000;
            end
            else begin
                oled_data = 16'b00000_000000_00000;  
            end
        end
        end
        else if(reset == 1)begin
             oled_data = 16'b00000_000000_00000;  
        end
    end //end always block    

endmodule

