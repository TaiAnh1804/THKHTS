
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2025 05:43:28 AM
// Design Name: 
// Module Name: lcd_display
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


module lcd_display (
    input clk,
    input rst,
    input [7:0] char1,
    input [7:0] char2,
    input [7:0] char3,
    input [7:0] char4,
    input show,
    output reg [7:0] display
);
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            display <= 32'h20202020;
        end else if (show) begin
//            display <= {char1, char2, char3, char4};
            display <= char4;
        end
    end
endmodule
