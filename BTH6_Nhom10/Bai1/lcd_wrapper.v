
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 03:52:17 PM
// Design Name: 
// Module Name: lcd_wrapper
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


module lcd_wrapper (
    input [7:0] data,
    input clk,
    input rst,
    output reg [7:0] lcd_db,
    output reg lcd_rs,
    output reg lcd_en,
    output reg lcd_rw,
    output reg lcd_ready
);
    reg [3:0] state = 0;
    reg [6:0] delay_cnt = 0; // Tạo độ trễ ~100 µs tại 1 MHz

    always @(posedge clk or negedge  rst) begin
        if (rst == 0) begin
            state <= 0;
            lcd_en <= 0;
            lcd_ready <= 0;
            delay_cnt <= 0;
        end else begin
            case (state)
                0: begin
                    lcd_en <= 1;
                    lcd_db <= data;
                    lcd_rs <= ((data >= 8'h30) & (data != 8'h38));
                    lcd_rw <= 0;
                    lcd_ready <= 0;
                    state <= 1;
                end
                1: begin
                    lcd_en <= 0;
                    lcd_ready <= 0;
                    delay_cnt <= delay_cnt + 1;
                    if (delay_cnt == 100) begin // Độ trễ 100 µs
                        delay_cnt <= 0;
                        state <= 2;
                    end
                end
                2: begin
                    lcd_ready <= 1;
                    state <= 0;
                end
            endcase
        end
    end
endmodule

//module lcd_wrapper (
//    input [7:0] data,
//    input clk,
//    input rst,
//    output reg [7:0] lcd_db,
//    output reg lcd_rs,
//    output reg lcd_en,
//    output reg lcd_rw,
//    output reg lcd_ready
//);
//    reg [3:0] state = 0;
//    always @(posedge clk or negedge  rst) begin
//        if (rst == 0) begin
//            state <= 0;
//            lcd_en <= 0;
//            lcd_ready <= 0;
//        end else begin
//            case (state)
//                0: begin
//                    lcd_en <= 1;
//                    lcd_db <= data;
//                    lcd_rs <= ((data >= 8'h30) & (data != 8'h38));
//                    lcd_rw <= 0;
//                    lcd_ready <= 0;
//                    state <= 1;
//                end
//                1: begin
//                    lcd_en <= 0;
//                    lcd_ready <= 0;
//                    state <= 2;
//                end
//                2: begin
//                    lcd_ready <= 1;
//                    state <= 0;
//                end
//            endcase
//        end
//    end
//endmodule