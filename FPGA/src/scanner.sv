// // E155: Lab 2 - Multiplexed 7-Segment Display
// Ivan Jimenez Pineda, ijimenezpineda@g.hmc.edu
// 9/15/2026
// Keypad scanner to output 4-bit number corresponding to the key pressed

module scanner (input logic clk,
                input logic reset,
                input logic enable,
                output logic [3:0] row_scan);

    logic [24:0] scan_count; // 25-bit counter. 

    lab2_counter #(.width(25)) scan_cntr (.clk(clk), .reset(reset), enable(enable), .count(scan_count));

    logic [1:0] state; // top two bits of scan_count to form a 4-state machine
    assign state = scan_count[24:23];

    assign row_scan[3] = (state == 2'b00); // row_scan[3] is high when state is 00
    assign row_scan[2] = (state == 2'b01); // row_scan[2] is high when state is 01
    assign row_scan[1] = (state == 2'b10); // row_scan[1] is high when state is 10
    assign row_scan[0] = (state == 2'b11); // row_scan[0] is high when state is 11

endmodule