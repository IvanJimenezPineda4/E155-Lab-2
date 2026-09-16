// // E155: Lab 2 - Multiplexed 7-Segment Display
// Ivan Jimenez Pineda, ijimenezpineda@g.hmc.edu
// 9/15/2026
// counter to output N-bit count

module lab2_counter #(parameter width = 24) (
    input logic clk,
    input logic reset,
    input logic enable,
    output logic [width-1:0] count);

    always_ff @(posedge clk) begin
        if (~reset) begin
            count <= 0;
        end
        else if (enable) begin
            count <= count + 1'b1;
        end 
    end
endmodule