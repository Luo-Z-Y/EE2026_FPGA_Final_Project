module board_animation(
    input clk,
    input video_on,
    input [9:0] x, y,
    output reg [11:0] rgb
);

wire board_bit_on;

// Define grid parameters
localparam GRID_WIDTH = 15; // Width of the grid (number of columns)
localparam GRID_HEIGHT = 15; // Height of the grid (number of rows)
localparam GRID_SPACING_X = 20; // Spacing between vertical grid lines
localparam GRID_SPACING_Y = 20; // Spacing between horizontal grid lines
localparam GRID_THICKNESS = 3; // Thickness of grid lines

// Calculate starting position of the grid to place it at the left middle of the screen
localparam GRID_START_X = 60; // Adjust as needed for the left padding
localparam GRID_START_Y = 100;

assign board_bit_on = (x < 343) && (y < 383) && (
                      ((x < GRID_START_X + GRID_WIDTH * GRID_SPACING_X) &&
                      (x >= GRID_START_X) &&
                      (y >= GRID_START_Y && y < GRID_START_Y + GRID_HEIGHT * GRID_SPACING_Y) &&
                      (x % GRID_SPACING_X < GRID_THICKNESS)) ||
                      ((y < GRID_START_Y + GRID_HEIGHT * GRID_SPACING_Y) &&
                      (y >= GRID_START_Y) &&
                      (x >= GRID_START_X && x < GRID_START_X + GRID_WIDTH * GRID_SPACING_X) &&
                      (y % GRID_SPACING_Y < GRID_THICKNESS)));
                      

// rgb multiplexing circuit
always @*
    if(~video_on)
        rgb = 12'h000;      // blank
    else
        if(board_bit_on)
            rgb = 12'h000;  // black
        else
            rgb = 12'hFFF;  // white background

endmodule
