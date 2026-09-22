// // E155: Lab 2 - Multiplexed 7-Segment Display
// Ivan Jimenez Pineda, ijimenezpineda@g.hmc.edu
// 9/15/2026
// Testbench for scanner.sv

`timescale 1ns/1ps

module scanner_testbench();
    logic clk;
    logic reset;
    logic enable;
    logic [3:0] row_scan;

    scanner dut (.clk(clk), .reset(reset), .enable(enable), .row_scan(row_scan));

    // Generate simulated clock
    always begin 
        clk = 1; #5; 
        clk = 0; #5; 
    end

    initial begin
        // Initialize and reset
        reset = 0; enable = 1; #20;
        assert(row_scan == 4'b1000) else $error("Reset state failed (expected 1000)");

        // Release reset and allow counting to the next state
        reset = 1;
        
        // Bit 23 toggles after 2^23 clock cycles. 
        // 2^23 cycles * 10ns = 83,886,080 ns delay per state transition
        #83886100;
        assert(row_scan == 4'b0100) else $error("State 01 transition failed");
        
        enable = 0; // toggle enable off (pause the counter)
        #500000;
        assert(row_scan == 4'b0100) else $error("Enable failed, state changed while disabled");
        
        enable = 1; // resume counting
        #83886080;
        assert(row_scan == 4'b0010) else $error("State 10 transition failed");

        reset = 0; #20;
        assert(row_scan == 4'b1000) else $error("Reset failed");
        
        reset = 1; // release reset
        #83886100;
        assert(row_scan == 4'b0100) else $error ("Reset recovery failed, state 01 transition failed");

        #83886080;
        assert(row_scan == 4'b0010) else $error("State 10 transition failed");

        #83886080;
        assert(row_scan == 4'b0001) else $error("State 11 transition failed");

        $display("Scanner transition tests completed.");
        $stop;
    end
endmodule