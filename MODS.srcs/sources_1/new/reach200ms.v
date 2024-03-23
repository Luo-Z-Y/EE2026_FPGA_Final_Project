`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/16 22:18:52
// Design Name: 
// Module Name: reach200ms
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

module reach200ms(
    input clk,
    input btnL,
    input btnR,
    input btnC,
    output reg reached200ms
    );
    parameter COUNT_MAX = 1250000; // 200ms at 1kHz clock frequency
      reg [31:0] count = 0;
      reg [1:0] state = 2'b00; // 00: Idle, 01: Counting, 10: Wait for debounce
      reg [2:0] last_button_state = 3'b111; // Initialize to '1' (unpressed)
  
      always @(posedge clk) begin
          // Debounce logic
          if (state == 2'b10) begin
              // Wait for debounce
              if (btnL == last_button_state[0] && btnR == last_button_state[1] && btnC == last_button_state[2])
                  state <= 2'b00; // Transition to Idle state
          end
          else begin
              // Update last_button_state after debounce
              last_button_state <= {btnL, btnR, btnC};
  
              // Detect button press
              if (btnL != last_button_state[0] || btnR != last_button_state[1] || btnC != last_button_state[2]) begin
                  state <= 2'b10; // Transition to Wait for debounce state
                  count <= 0; // Reset counter
              end
  
              // Counter logic
              if (state == 2'b01) begin
                  if (count < COUNT_MAX)
                      count <= count + 1;
                  else begin
                      reached200ms <= 1; // 200ms elapsed
                      state <= 2'b00; // Transition to Idle state
                  end
              end
          end
      end
  
      // Start counting on button press
      always @(posedge clk) begin
          if (state == 2'b10)
              state <= 2'b01; // Transition to Counting state
      end
endmodule

