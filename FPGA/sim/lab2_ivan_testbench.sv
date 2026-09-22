// // E155: Lab 2 - Multiplexed 7-Segment Display
// Ivan Jimenez Pineda, ijimenezpineda@g.hmc.edu
// 9/15/2026
// Testbench for lab2_ivan

`timescale 1ns/1ps

module lab2_ivan_testbench();
    logic reset;
    logic [3:0] dip_s;
    logic [3:0] bread_s;
    logic [3:0] column;
    logic [6:0] seg;
    logic [1:0] anode;
    logic [3:0] rows;
    logic [3:0] led;

    lab2_ivan dut (.reset(reset), .dip_s(dip_s), .bread_s(bread_s), .column(column), .seg(seg), .anode(anode), .rows(rows), .led(led));

    initial begin
        // Hold reset, set distinct hex values for the two displays
        reset = 0;
        dip_s = 4'hA;     // Expect segment 'A'
        bread_s = 4'h3;   // Expect segment '3'
        column = 4'b1111; // Default unpressed keypad state (pulled high)
        #100; 
        reset = 1;

        // test keypad (expecting inverted output)
        column = 4'b1010; #10;
        assert(led == 4'b0101) else $error("keypad led failed, expected 0101");

        column = 4'b0101; #10;
        assert(led == 4'b1010) else $error("keypad led failed, expected 1010");

        // test multiplexing
        // multiplexer toggles every 2^16 cycles of the 24MHz clock.
        #3000000; 

        reset = 0; // toggle reset
        #100;

        reset = 1;
        #100;
        
        $display("Top level tests completed.");
        $stop;
    end
endmodule