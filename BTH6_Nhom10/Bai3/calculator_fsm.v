`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2025 05:44:46 AM
// Design Name: 
// Module Name: calculator_fsm
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


module calculator_fsm (
    input clk,
    input rst,
    input key_valid,
    input [7:0] key_ascii,
    output reg [7:0] lcd_out1, // a
    output reg [7:0] lcd_out2, // op
    output reg [7:0] lcd_out3, // b
    output reg [7:0] lcd_out4, // result
    output reg done
);
    reg [3:0] state = 0;
    reg [3:0] a = 0, b = 0, result = 0;
    reg [7:0] op;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= 0; done <= 0;
        end else begin
            case (state)
                0: if (key_valid && key_ascii >= "0" && key_ascii <= "9") begin
                        a <= key_ascii - "0";
                        lcd_out1 <= key_ascii;
                        state <= 1;
                   end
                1: if (key_valid && (key_ascii == "+" || key_ascii == "*")) begin
                        op <= key_ascii;
                        lcd_out2 <= key_ascii;
                        state <= 2;
                   end
                2: if (key_valid && key_ascii >= "0" && key_ascii <= "9") begin
                        b <= key_ascii - "0";
                        lcd_out3 <= key_ascii;
                        state <= 3;
                   end
                3: begin
                        if (op == "+") result <= a + b;
                        else if (op == "*") result <= a * b;
                        lcd_out4 <= (result >= 10) ? ("A" + (result - 10)) : (result + "0");
                        done <= 1;
                        state <= 4;
                   end
                4: if (key_valid) begin
                        done <= 0;
                        state <= 0;
                   end
            endcase
        end
    end
endmodule

