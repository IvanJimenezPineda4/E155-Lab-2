// // E155: Lab 2 - Multiplexed 7-Segment Display
// Ivan Jimenez Pineda, ijimenezpineda@g.hmc.edu
// 9/15/2026
// Testbench for seven_segment.sv

`timescale 1ns/1ps  

module seven_segment_testbench();
    logic [3:0] s;
    logic [6:0] seg;

    seven_segment dut(.s(s), .seg(seg));

    initial begin
        // test case 0
        s = 4'h0; #10;
        assert (seg == 7'b1000000) else $error("Failed for input 0");

        // test case 1
        s = 4'h1; #10;
        assert (seg == 7'b1111001) else $error("Failed for input 1");

        // test case 2
        s = 4'h2; #10;
        assert (seg == 7'b0100100) else $error("Failed for input 2");

        // test case 3
        s = 4'h3; #10;
        assert (seg == 7'b0110000) else $error("Failed for input 3");

        // test case 4
        s = 4'h4; #10;
        assert (seg == 7'b0011001) else $error("Failed for input 4");

        // test case 5
        s = 4'h5; #10;
        assert (seg == 7'b0010010) else $error("Failed for input 5");

        // test case 6
        s = 4'h6; #10;
        assert (seg == 7'b0000010) else $error("Failed for input 6");

        // test case 7
        s = 4'h7; #10;
        assert (seg == 7'b1111000) else $error("Failed for input 7");

        // test case 8
        s = 4'h8; #10;
        assert (seg == 7'b0000000) else $error("Failed for input 8");

        // test case 9
        s = 4'h9; #10;
        assert (seg == 7'b0011000) else $error("Failed for input 9");

        // test case A
        s = 4'hA; #10;
        assert (seg == 7'b0001000) else $error("Failed for input A");

        // test case B
        s = 4'hB; #10;
        assert (seg == 7'b0000011) else $error("Failed for input b");

        // test case C
        s = 4'hC; #10;
        assert (seg == 7'b1000110) else $error("Failed for input C");

        // test case D
        s = 4'hD; #10;
        assert (seg == 7'b0100001) else $error("Failed for input d");

        // test case E
        s = 4'hE; #10;
        assert (seg == 7'b0000110) else $error("Failed for input E");

        // test case F
        s = 4'hF; #10;
        assert (seg == 7'b0001110) else $error("Failed for input F");

        $display("7-segment tests completed successfully.");
        $stop;
    end
endmodule