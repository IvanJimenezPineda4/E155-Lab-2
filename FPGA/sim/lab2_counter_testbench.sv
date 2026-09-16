// // E155: Lab 2 - Multiplexed 7-Segment Display
// Ivan Jimenez Pineda, ijimenezpineda@g.hmc.edu
// 9/15/2026
// Testbench for lab2_counter.sv

`timescale 1ns/1ps

module lab2_counter_testbench();
    logic clk;
    logic reset;
    logic enable;
    logic [3:0] count;

    // 4-bit width
    lab2_counter #(.width(4)) dut (.clk(clk), .reset(reset), .enable(enable), .count(count));

    // Generate the simulated clock 
    always begin 
        clk = 1; #5; 
        clk = 0; #5; 
    end

    initial begin
        // test active-low reset
        reset = 0; enable = 1; #15;
        assert(count == 4'b0000) else $error("Reset failed");

        // Release reset, allow it to count up for 3 clock cycles
        reset = 1; #30;
        assert(count == 4'b0011) else $error("Count increment failed");

        // Test enable = 0 (pausing the counter)
        enable = 0; #20;
        assert(count == 4'b0011) else $error("Enable logic failed, counter did not pause");

        $display("counter tests completed.");
        $stop; 
    end
endmodule