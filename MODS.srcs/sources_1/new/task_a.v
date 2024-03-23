`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/16 22:56:08
// Design Name: 
// Module Name: task_a
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


module task_a (input basys_clock, btnC,btnD, reset, [12:0] pixel_index, output reg [15:0] oled_data, output led1);

assign led1 = !reset;

wire my_clk_6p25m, clk_25MHz;

wire [31:0] count_unit;
wire [6:0] x, y;
reg [1:0] state = 0;
reg flag = 0;
reg [31:0] counter_1 = 0;
assign x = pixel_index % 96;
assign y = pixel_index / 96; 

the_flexible_module clk_divider_25m (basys_clock, 1, clk_25MHz);
counter_a count (basys_clock, reset & !flag, count_unit);

always @ (posedge clk_25MHz) begin
if (!reset) begin
    oled_data <= 0;
    if ((x >= 3 && x <= 92 && y == 3) || (x >= 3 && x <= 92 && y == 60) || (x == 3 && y >= 3 && y <= 60) || (x == 92 && y >= 3 && y <= 60)) begin
        oled_data <= 16'b11111_000000_00000;
    end
    if (btnC) begin
        flag <= 1;
    end
    if (flag) begin
        if (((x >= 7 && x <= 88 && y >= 54 && y <= 56) || (x >= 7 && x <= 88 && y >= 7 && y <= 9) || (x >= 7 && x <= 9 && y >= 7 && y <= 56) || (x >= 86 && x <= 88 && y >= 7 && y <= 56))) begin
            oled_data <= 16'b11111_110001_00101;
        end
        if (count_unit >= 200000000) begin
            if (((x >= 13 && x <= 82 && y == 50) || (x >= 13 && x <= 82 && y == 13) || (x == 13 && y >= 13 && y <= 50) || (x == 82 && y >= 13 && y <= 50))) begin
                    oled_data <= 16'b00000_111111_00000;
            end
        end
         if (count_unit >= 350000000) begin
            if (((x >= 17 && x <= 78 && y >= 45 && y <= 46) || (x >= 17 && x <= 78 && y >= 17 && y <= 18) || (x >= 17 && x <= 18 && y >= 17 && y <= 46) || (x >= 77 && x <= 78 && y >= 17 && y <= 46))) begin
                    oled_data <= 16'b00000_111111_00000;
            end
         end
         if (count_unit >= 450000000) begin
            if (((x >= 22 && x <= 73 && y >= 39 && y <= 41) || (x >= 22 && x <= 73 && y >= 22 && y <= 24) || (x >= 22 && x <= 24 && y >= 22 && y <= 41) || (x >= 71 && x <= 73 && y >= 22 && y <= 41))) begin
                    oled_data <= 16'b00000_111111_00000;
            end
         end
         if (btnD && counter_1 == 0) begin
            state <= (state == 3) ? 1 : state + 1;
            counter_1 <= 1;
         end
    end
    if (counter_1 != 0) begin
        counter_1 <= (counter_1 == 5000000) ? 0 : counter_1 + 1;
    end
    case(state)
    0:begin
        if (x >= 40 && x <= 55 && y >= 25 && y <= 38) begin
            oled_data <= 16'b00000_000000_00000;
        end
    end
    1:begin
        if (x >= 45 && x <= 50 && y>= 29 && y <= 34) begin
            oled_data <= 16'b11111_000000_00000;
        end
    end
    2:begin
        if ((((47 - x) * (47 - x)) + ((31 - y) * (31 - y))) <= 9) begin
            oled_data <= 16'b11111_110001_00101;
        end
    end
    3:begin
        if ((((x >= 47) && ((x - 47) <= (y - 31))) || ((x < 47) && ((47 - x) <= (y - 31)))) && y >= 31 && y <= 34) begin
            oled_data <= 16'b00000_111111_00000;
        end
    end                
    endcase    
end
    else begin
        flag <= 0;
        counter_1 <= 0;
        state <= 0;
    end
end

endmodule
