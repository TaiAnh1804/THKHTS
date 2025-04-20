`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2025 05:41:03 AM
// Design Name: 
// Module Name: keypad_decoder
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


module keypad_decoder (
    input clk,
    input rst,
    input [7:0] key_test,
    input trigger,
    output reg [7:0] key_ascii,
    output reg key_valid
);
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            key_valid <= 0;
        end else begin
            if (trigger) begin
                key_ascii <= key_test;
                key_valid <= 1;
            end else begin
                key_valid <= 0;
            end
        end
    end
endmodule
