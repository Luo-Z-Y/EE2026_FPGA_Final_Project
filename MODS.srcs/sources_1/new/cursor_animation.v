module cursor_animation(
    input clk,
    input video_on,
    input [9:0] x, y,
    output reg [11:0] rgb,
    inout PS2Clk,
    inout PS2Data
);

wire [11:0] xpos;
wire [11:0] ypos;
wire [3:0] zpos;
wire left, middle, right, new_event;
reg setx, sety, setmax_x, setmax_y = 0;
reg [11:0] value = 0;

// Instantiate MouseCtl module
MouseCtl unit_mouse
(
    .clk(clk),
    .rst(0),
    .xpos(xpos),
    .ypos(ypos),
    .zpos(zpos),
    .left(left),
    .middle(middle),
    .right(right),
    .new_event(new_event),
    .value(value),
    .setx(setx),
    .sety(sety),
    .setmax_x(setmax_x),
    .setmax_y(setmax_y),
    .ps2_clk(PS2Clk),
    .ps2_data(PS2Data)
);

reg [3:0] cursor_bit_counter;
reg cursor_bit_on;

// Counter to control cursor animation rate
always @(posedge clk) begin
    if (cursor_bit_counter == 10'b1111111111) // Assuming 100MHz clock and 500ms period
        cursor_bit_counter <= 0;
    else
        cursor_bit_counter <= cursor_bit_counter + 1;
end

// Determine if cursor should be on or off based on counter value
always @* begin
    if (cursor_bit_counter < 10'b0101010101) // 50% duty cycle
        cursor_bit_on = 1'b1;
    else
        cursor_bit_on = 1'b0;
end

// Determine cursor position based on mouse coordinates
reg [9:0] cursor_x;
reg [9:0] cursor_y;

always @* begin
    if (video_on)
        begin
            cursor_x = xpos;
            cursor_y = ypos;
        end
    else
        begin
            // Set cursor off-screen when video is off
            cursor_x = 10'h3FF;
            cursor_y = 10'h3FF;
        end
end

// Determine RGB output based on cursor position and visibility
always @* begin
    if (~video_on)
        rgb = 12'h000;      // blank
    else if (x >= cursor_x && x < cursor_x + 5 && y >= cursor_y && y < cursor_y + 5) // Ensure cursor is within valid screen range
        if (left) rgb = 12'hF00; //Blue cursor
        else rgb = 12'h000;  // Black cursor
    else
        rgb = 12'hFFF;  // White background
end

endmodule
