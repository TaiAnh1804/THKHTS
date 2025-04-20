`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2025 05:44:15 AM
// Design Name: 
// Module Name: calculator_top
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


module calculator_top (
    input clk_100MHz,
    input rst,
    input [7:0] key_test,
    input key_trigger,
    output [7:0] lcd_text
);
    wire clk_1MHz;
    wire [7:0] key_ascii;
    wire key_valid;
    wire [7:0] lcd_out1, lcd_out2, lcd_out3, lcd_out4;
    wire done;
    
    clock_divider div_inst (
        .clk_100MHz(clk_100MHz),
        .rst(rst),
        .clk_1MHz(clk_1MHz)
    );
    
    keypad_decoder keypad (
        .clk(clk),
        .rst(rst),
        .key_test(key_test),
        .trigger(key_trigger),
        .key_ascii(key_ascii),
        .key_valid(key_valid)
    );

    calculator_fsm calc (
        .clk(clk),
        .rst(rst),
        .key_valid(key_valid),
        .key_ascii(key_ascii),
        .lcd_out1(lcd_out1),
        .lcd_out2(lcd_out2),
        .lcd_out3(lcd_out3),
        .lcd_out4(lcd_out4),
        .done(done)
    );

    lcd_display lcd (
        .clk(clk),
        .rst(rst),
        .char1(lcd_out1),
        .char2(lcd_out2),
        .char3(lcd_out3),
        .char4(lcd_out4),
        .show(done),
        .display(lcd_text)
    );
endmodule
