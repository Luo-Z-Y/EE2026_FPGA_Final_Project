`timescale 1ns / 1ps
// Reference book: "FPGA Prototyping by Verilog Examples"
//                    "Xilinx Spartan-3 Version"
// Authored by: Pong P. Chu
// Published by: Wiley, 2008
// Adapted for use on Basys 3 FPGA with Xilinx Artix-7
// by: David J. Marion aka FPGA Dude

module ascii_test(
    input clk,
    input video_on,
    input [9:0] x, y,
    output reg [11:0] rgb
    );
    
    // signal declarations
    wire [10:0] rom_addr;           // 11-bit text ROM address
    wire [6:0] ascii_char;          // 7-bit ASCII character code
    
    wire [3:0] char_row;            // 4-bit row of ASCII character
    wire [2:0] bit_addr;            // column number of ROM data
    wire [7:0] rom_data;            // 8-bit row data from text ROM
    wire ascii_bit, ascii_bit_on;     // ROM bit and status signal
    
    wire red; 
    wire green;
    
    // instantiate ASCII ROM
    ascii_rom rom(.clk(clk), .addr(rom_addr), .data(rom_data));
      
    // ASCII ROM interface
    assign rom_addr = {ascii_char, char_row};   // ROM address is ascii code + row
    assign ascii_bit = rom_data[~bit_addr];     // reverse bit order
    
    //assign ascii_char = {y[5:4], x[7:3]};   // 7-bit ascii code
    assign ascii_char = (x >= 192 && x < 200) ? 7'h52 :  //R
                        (x >= 200 && x < 208) ? 7'h45 :  //E
                        (x >= 208 && x < 216) ? 7'h44 :  //D
                        (x >= 216 && x < 224) ? 7'h01 :  //SMILE
                        (x >= 224 && x < 232) ? 7'h57 :  //W
                        (x >= 232 && x < 240) ? 7'h49 :  //I
                        (x >= 240 && x < 248) ? 7'h4e :  //N
                        (x >= 248 && x < 256) ? 7'h00 :  //SPACE
                        (x >= 256 && x < 264) ? 7'h00 :  //SPACE
                        (x >= 264 && x < 272) ? 7'h00 :  //SPACE
                        (x >= 272 && x < 280) ? 7'h00 :  //SPACE
                        (x >= 288 && x < 296) ? 7'h47 :  //G
                        (x >= 296 && x < 304) ? 7'h52 :  //R
                        (x >= 304 && x < 312) ? 7'h45 :  //E 
                        (x >= 312 && x < 320) ? 7'h45 :  //E 
                        (x >= 320 && x < 328) ? 7'h4e :  //N
                        (x >= 328 && x < 336) ? 7'h01 :  //SMILE
                        (x >= 336 && x < 344) ? 7'h57 :  //W 
                        (x >= 344 && x < 352) ? 7'h49 :  //I 
                        (x >= 352 && x < 360) ? 7'h4e :  //N                    
                        7'h00;
    
    assign red = (x >= 192 && x < 248);
    assign green = (x >= 288 && x < 360);
                        
    assign char_row = y[3:0];               // row number of ascii character rom
    assign bit_addr = x[2:0];               // column number of ascii character rom
    // "on" region in center of screen
    assign ascii_bit_on = ((x >= 192 && x < 360) && (y >= 208 && y < 224)) ? ascii_bit: 1'b0;
    
    // rgb multiplexing circuit
    always @*
        if(~video_on)
            rgb = 12'h000;      // blank
        else
            if(ascii_bit_on)
            begin
                if (red)
                begin
                    rgb = 12'h00F;  // red letters
                end
                else if (green)
                begin
                    rgb = 12'h0F0; // green letterss
                end
            end
            else
                rgb = 12'hFFF;  // white background
   
endmodule