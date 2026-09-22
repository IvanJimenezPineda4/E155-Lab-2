// // E155: Lab 2 - Multiplexed 7-Segment Display
// Ivan Jimenez Pineda, ijimenezpineda@g.hmc.edu
// 9/15/2026
// Top level module to connect the scanner and seven segment modules

module lab2_ivan (input logic reset,
                  input logic [3:0] dip_s, // 4-bit input from DIP switch on-board
                  input logic [3:0] bread_s, // 4-bit input from breadboard DIP switch
                  input logic [3:0] column, // keypad column input
                  output logic [6:0] seg, // multiplexed 7-segment output
                  output logic [1:0] anode, // anode output for 2-digit display
                  output logic [3:0] rows, // keypad row output
                  output logic [3:0] led); // keypad led output

    logic int_osc; // 48MHz divided by 2 = 24MHz
    HSOSC #(.CLKHF_DIV("0b01")) hf_osc(.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

    logic [16:0] mux_count; // 17-bit counter at 24MHz 
    lab2_counter #(.width(17)) mux_cntr (.clk(int_osc), .reset(reset), .enable(1'b1), .count(mux_count));

    logic mux_out;
    assign mux_out = mux_count[16];

    logic[3:0] current_hex;
    assign current_hex = mux_out ? dip_s : bread_s; // if mux_out = 1, current_hex = dip_s

    assign anode[0] = mux_out; // A low signal turns the transistor ON
    assign anode[1] = ~mux_out;

    seven_segment segments (.s(current_hex), .seg(seg));

    scanner keypad_scan (.clk(int_osc), .reset(reset), .enable(1'b1), .row_scan(rows));

    assign led = ~column;

endmodule

