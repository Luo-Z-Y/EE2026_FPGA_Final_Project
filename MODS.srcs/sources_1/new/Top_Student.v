`timescale 1ns / 1ps

module Top_Student(
    input clk,          // 100MHz on Basys 3
    input btnC,        // btnC on Basys 3
    output hsync,       // to VGA connector
    output vsync,       // to VGA connector
    output [11:0] rgb,   // to DAC, to VGA connector
    inout PS2Clk,
    inout PS2Data
    );
    
    // Define grid parameters
    localparam GRID_WIDTH = 15; // Width of the grid (number of columns)
    localparam GRID_HEIGHT = 15; // Height of the grid (number of rows)
    localparam GRID_SPACING_X = 20; // Spacing between vertical grid lines
    localparam GRID_SPACING_Y = 20; // Spacing between horizontal grid lines
    localparam GRID_THICKNESS = 3; // Thickness of grid lines
    
    // Calculate starting position of the grid to place it at the left middle of the screen
    localparam GRID_START_X = 60; // Adjust as needed for the left padding
    localparam GRID_START_Y = 100;
    
    // signals
    wire [9:0] w_x, w_y;
    wire w_video_on, w_p_tick;
    reg [11:0] rgb_reg;
    wire [11:0] rgb_next_test;
    wire [11:0] rgb_next_board;
    wire [11:0] rgb_next_cursor;
    wire [11:0] rgb_next_win;
    wire [11:0] rgb_next_lose;
    
    wire grid;
    assign grid = (w_x < 343) && (w_y < 383) && (
                                      ((w_x < GRID_START_X + GRID_WIDTH * GRID_SPACING_X) &&
                                      (w_x >= GRID_START_X) &&
                                      (w_y >= GRID_START_Y && w_y < GRID_START_Y + GRID_HEIGHT * GRID_SPACING_Y) &&
                                      (w_x % GRID_SPACING_X < GRID_THICKNESS)) ||
                                      ((w_y < GRID_START_Y + GRID_HEIGHT * GRID_SPACING_Y) &&
                                      (w_y >= GRID_START_Y) &&
                                      (w_x >= GRID_START_X && w_x < GRID_START_X + GRID_WIDTH * GRID_SPACING_X) &&
                                      (w_y % GRID_SPACING_Y < GRID_THICKNESS)));
    
    // VGA Controller
    vga_controller vga(.clk_100MHz(clk), .reset(btnC), .hsync(hsync), .vsync(vsync),
                       .video_on(w_video_on), .p_tick(w_p_tick), .x(w_x), .y(w_y));
                       
    // Text
    ascii_test at(.clk(clk), .video_on(w_video_on), .x(w_x), .y(w_y), .rgb(rgb_next_test));
    
    //board
    board_animation ba (.clk(clk), .video_on(w_video_on), .x(w_x), .y(w_y), .rgb(rgb_next_board));
    
    //cursor
    cursor_animation ca (.clk(clk), .video_on(w_video_on), .x(w_x), .y(w_y), .rgb(rgb_next_cursor), 
    .PS2Clk(PS2Clk), .PS2Data(PS2Data));
    
    // rgb buffer
    always @(posedge clk)
    begin
        if(w_p_tick)
        begin
            if (grid)
            begin
                rgb_reg <= rgb_next_board;
            end
            else
            begin
                rgb_reg <= rgb_next_cursor;
            end
        end
    end
            
    // output
    assign rgb = rgb_reg;
      
endmodule