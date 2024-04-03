`timescale 1ns / 1ps

module Top_Student(
    input clk,          // 100MHz on Basys 3
    input btnC,        // btnC on Basys 3
    output hsync,       // to VGA connector
    output vsync,       // to VGA connector
    output [11:0] rgb,   // to DAC, to VGA connector
    inout PS2Clk,
    inout PS2Data,
    output [15:0] led
    );
    
    // signals
    wire [9:0] w_x, w_y;
    wire w_video_on, w_p_tick;
    reg [11:0] rgb_reg;
    
    wire [11:0] rgb_next_test;
    wire [11:0] rgb_next_board;
    wire [11:0] rgb_next_cursor;
    wire [11:0] rgb_next_black_win;
    wire [11:0] rgb_next_white_win;
    wire [11:0] rgb_next_replay;
    wire [11:0] rgb_next_player;
    
    wire [255:0] pieceA;
    wire [255:0] pieceB;
    
    wire mouse_x;
    wire mouse_y;
    wire clicked;
    
    wire is_grid;
    wire is_cursor;
    wire is_control;
    wire is_player_display;
    
    // VGA Controller
    vga_controller vga(.clk_100MHz(clk), .reset(btnC), .hsync(hsync), .vsync(vsync),
                       .video_on(w_video_on), .p_tick(w_p_tick), .x(w_x), .y(w_y));
                       
    // Text
    ascii_test at(.clk(clk), .video_on(w_video_on), .x(w_x), .y(w_y), .rgb(rgb_next_test));
    
    //Black Win Text
    black_win_animation bwt(.clk(clk), .video_on(w_video_on), .x(w_x), .y(w_y), .rgb(rgb_next_black_win));
    
    //White Win Text
    white_win_animation wwt(.clk(clk), .video_on(w_video_on), .x(w_x), .y(w_y), .rgb(rgb_next_white_win));
    
    //Replay Text
    control_animation coa(.clk(clk), .video_on(w_video_on), .x(w_x), .y(w_y), .rgb(rgb_next_replay), .is_control(is_control));
    
    //Board
    board_animation ba (.clk(clk), .video_on(w_video_on), .x(w_x), .y(w_y), .rgb(rgb_next_board), 
    .x_in(mouse_x), .y_in(mouse_y), .clicked(clicked), .is_grid(is_grid));
    
    //Player display
     player_animation pa (.clk(clk), .video_on(w_video_on), .x(w_x), .y(w_y), .rgb(rgb_next_player), .is_player_display(is_player_display));
    
    //Cursor
    cursor_animation ca (.clk(clk), .video_on(w_video_on), .x(w_x), .y(w_y), .rgb(rgb_next_cursor), 
    .PS2Clk(PS2Clk), .PS2Data(PS2Data), .led(led), .x_out(mouse_x), .y_out(mouse_y), .clicked(clicked), 
    .is_cursor(is_cursor));
    
    // rgb buffer
    always @(posedge clk)
    begin
        if(w_p_tick)
        begin
            if (is_cursor)
            begin
                rgb_reg <= rgb_next_cursor;
            end
            else if (is_control)
            begin
                rgb_reg <= rgb_next_replay;
            end
            else if (is_player_display)
            begin
                rgb_reg <= rgb_next_player;
            end
            else
            begin
                rgb_reg <= rgb_next_board;
            end
//            else
//            begin
//                //rgb_reg <= 12'h6AD; // Colour 3
//                rgb_reg <= 12'h6AD;
//            end
             //rgb_reg <= rgb_next_replay;
        end
    end
            
    // output
    assign rgb = rgb_reg;
      
endmodule