`timescale 1ns / 1ps

module control_animation(
    input clk,
    input video_on,
    input [9:0] x, y,
    output reg [11:0] rgb,
    output is_control
    );
    
    // signal declarations
    wire [10:0] rom_addr;           // 11-bit text ROM address
    wire [6:0] ascii_char;          // 7-bit ASCII character code
    
    wire [3:0] char_row;            // 4-bit row of ASCII character
    wire [2:0] bit_addr;            // column number of ROM data
    wire [7:0] rom_data;            // 8-bit row data from text ROM
    wire ascii_bit, ascii_bit_on;     // ROM bit and status signal
    
    // instantiate ASCII ROM
    ascii_rom rom(.clk(clk), .addr(rom_addr), .data(rom_data));
      
    // ASCII ROM interface
    assign rom_addr = {ascii_char, char_row};   // ROM address is ascii code + row
    assign ascii_bit = rom_data[~bit_addr];     // reverse bit order
    
    assign ascii_char = (x >= 192 && x < 200) ? 7'h52 :  //R
                        (x >= 200 && x < 208) ? 7'h45 :  //E
                        (x >= 208 && x < 216) ? 7'h50 :  //P
                        (x >= 216 && x < 224) ? 7'h4c :  //L
                        (x >= 224 && x < 232) ? 7'h41 :  //A
                        (x >= 232 && x < 240) ? 7'h59 :  //Y
                        
                        (x >= 272 && x < 280) ? 7'h52 :  //R
                        (x >= 280 && x < 288) ? 7'h45 :  //E
                        (x >= 288 && x < 296) ? 7'h53 :  //S
                        (x >= 296 && x < 304) ? 7'h54 :  //T
                        (x >= 304 && x < 312) ? 7'h41 :  //A
                        (x >= 312 && x < 320) ? 7'h52 :  //R
                        (x >= 320 && x < 328) ? 7'h54 :  //T
                        
                        (x >= 360 && x < 368) ? 7'h51 :  //Q
                        (x >= 368 && x < 376) ? 7'h55 :  //U
                        (x >= 376 && x < 384) ? 7'h49 :  //I
                        (x >= 384 && x < 392) ? 7'h54 :  //T                       
                        7'h00;
                        
    assign char_row = y[3:0];               // row number of ascii character rom
    assign bit_addr = x[2:0];               // column number of ascii character rom
    // "on" region in center of screen
    assign ascii_bit_on = ((x >= 192 && x < 392) && (y >= 64 && y < 80)) ? ascii_bit: 1'b0;
    
    assign is_control = (x >= 192 && x < 392) && (y >= 64 && y < 80);
    
    // rgb multiplexing circuit
    always @*
        if(~video_on)
            rgb = 12'h000;      // blank
        else
            if(ascii_bit_on)
            begin
                rgb = 12'h641;  // navy blue coloured letters
            end
            else
                rgb = 12'hFFF;  // white background
   
endmodule