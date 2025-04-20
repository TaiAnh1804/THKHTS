`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2025 05:35:45 AM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider (
    input clk_100MHz,
    input rst,
    output reg clk_1MHz
);
    reg [4:0] counter;

    always @(posedge clk_100MHz or negedge rst) begin
        if (rst == 0) begin
            counter <= 0;
            clk_1MHz <= 0;
        end else begin
            counter <= counter + 1;
            if (counter == 399) begin
                clk_1MHz <= ~clk_1MHz;
                counter <= 0;
            end
        end
    end
endmodule

