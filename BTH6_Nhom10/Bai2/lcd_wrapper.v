
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2025 03:15:03 AM
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

//module lcd_wrapper (
//    input [7:0] data,
//    input clk,
//    input rst,
//    input key_valid,
//    output reg [7:0] lcd_db,
//    output reg lcd_rs,
//    output reg lcd_en,
//    output reg lcd_rw,
//    output reg lcd_ready
//);
//    reg [3:0] state = 0;
//    reg [11:0] delay_cnt = 0; 
////    reg [5:0] number = 0;
//    always @(posedge clk or negedge  rst) begin
//        if (rst == 0) begin
//            state <= 0;
//            lcd_en <= 0;
//            lcd_ready <= 0;
//            delay_cnt <= 0;
//        end
        
//        else begin
//            case (state)
//                0: begin
//                    lcd_en <= 1;
//                    lcd_db <= 8'h38;
//                    lcd_rs <= 0;
//                    lcd_rw <= 0;
////                    delay_cnt <= delay_cnt + 1;
////                    if (delay_cnt == 10) begin // Độ trễ 100 µs
////                        delay_cnt <= 0;
//                        state <= 1;
////                    end
//                end
//                1: begin
//                    lcd_en <= 1;
//                    lcd_db <= 8'h0C;
//                    lcd_rs <= 0;
//                    lcd_rw <= 0;
////                    delay_cnt <= delay_cnt + 1;
////                    if (delay_cnt == 10) begin // Độ trễ 100 µs
////                        delay_cnt <= 0;
//                        state <= 2;
////                    end
//                end
//                2: begin
//                    lcd_en <= 1;
//                    lcd_db <= 8'h01;
//                    lcd_rs <= 0;
//                    lcd_rw <= 0;
////                    delay_cnt <= delay_cnt + 1;
////                    if (delay_cnt == 10) begin // Độ trễ 100 µs
////                        delay_cnt <= 0;
//                        state <= 3;
////                    end
//                end
//                3: begin
//                    lcd_en <= 1;
//                    lcd_db <= 8'h06;
//                    lcd_rs <= 0;
//                    lcd_rw <= 0;
////                    delay_cnt <= delay_cnt + 1;
////                    if (delay_cnt == 10) begin // Độ trễ 100 µs
////                        delay_cnt <= 0;
//                        state <= 4;
////                    end
//                end
//                4: begin 
////                    if (key_valid) begin
//                        lcd_rw <= 0;                                       
//                        lcd_en <= 1;
//                        lcd_db <= data;
//                        lcd_rs <= (data >= 8'h20);
//                        lcd_ready <= 0;
////                    end  
//                    state <= 5;                                      
//                end
//                5: begin
//                    lcd_rs <= 0;                   
//                    lcd_en <= 0;
//                    lcd_ready <= 0;
//                    delay_cnt <= delay_cnt + 1;
////                    if (delay_cnt == 10) begin // Độ trễ 100 µs                       
//////                        number <= number + 1;
////                        delay_cnt <= 0;
////                        state <= 6;
////                    end
//                    state <= 5;
//                end
//                6: begin
////                    if (key_valid) begin
//                        lcd_ready <= 1;
//                        state <= 4;
////                    end
//                end
                

//            endcase
//        end
//    end
//endmodule
    module lcd_wrapper (
        input [7:0] data,
        input clk,
        input rst,
        input key_valid,
        output reg [7:0] lcd_db,
        output reg lcd_rs,
        output reg lcd_en,
        output reg lcd_rw,
        output reg lcd_ready
    );
    reg [3:0] state = 0;
    reg [11:0] delay_cnt = 0;
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= 0;
            lcd_en <= 0;
            lcd_ready <= 0;
            delay_cnt <= 0;
        end else begin
            case (state)
                0: begin 
                    lcd_rs <= 0; lcd_en <= 1; lcd_db <= 8'h38; lcd_rw <=0;
                    delay_cnt <= delay_cnt + 1;
                    if (delay_cnt == 1000) begin
                        delay_cnt <= 0; state <= 1;
                    end
                end
                1: begin 
                    lcd_rs <= 0; lcd_en <= 1; lcd_db <= 8'h0C; lcd_rw <=0;
                    delay_cnt <= delay_cnt + 1;
                    if (delay_cnt == 1000) begin
                        delay_cnt <= 0; state <= 2;
                    end
                end
                2: begin 
                    lcd_rs <= 0; lcd_en <= 1; lcd_db <= 8'h01; lcd_rw <=0;
                    delay_cnt <= delay_cnt + 1;
                    if (delay_cnt == 1000) begin
                        delay_cnt <= 0; state <= 3;
                    end
                end
                3: begin 
                    lcd_rs <= 0; lcd_en <= 1; lcd_db <= 8'h06; lcd_rw <=0;
                    delay_cnt <= delay_cnt + 1;
                    if (delay_cnt == 1000) begin
                        delay_cnt <= 0; state <= 4;
                    end
                end
                4: begin
                    lcd_en <= 1;
                    lcd_db <= data;
                    lcd_rs <= (data >= 8'h20);
                    lcd_rw <= 0;
                    lcd_ready <= 0;
                    delay_cnt <= 0;
                    state <= 5;
                end
                5: begin
                    lcd_en <= 0;  // Tạo cạnh xuống
                    delay_cnt <= delay_cnt + 1;
                    if (delay_cnt == 100) begin
                        delay_cnt <= 0; state <= 6;
                    end
                end
                6: begin
                    lcd_ready <= 1;
                    state <= 4;
                end
            endcase
        end
    end
    
    endmodule
