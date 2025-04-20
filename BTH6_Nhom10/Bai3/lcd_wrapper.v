//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 04/20/2025 12:15:04 PM
//// Design Name: 
//// Module Name: lcd_wrapper
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


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
//    reg [11:0] delay_cnt = 0;

//    always @(posedge clk or negedge rst) begin
//        if (!rst) begin
//            state <= 0;
//            lcd_en <= 0;
//            lcd_ready <= 0;
//            delay_cnt <= 0;
//            lcd_db <= 8'h00;
//            lcd_rs <= 0;
//            lcd_rw <= 0;
//        end else begin
//            case (state)
//                0: begin // Function set: 8-bit, 2 lines, 5x8 font
//                    lcd_rs <= 0;
//                    lcd_en <= 1;
//                    lcd_db <= 8'h38;
//                    lcd_rw <= 0;
//                    delay_cnt <= delay_cnt + 1;
//                    if (delay_cnt == 1000) begin // 1 ms
//                        delay_cnt <= 0;
//                        state <= 1;
//                    end
//                end
//                1: begin // Display on, cursor off
//                    lcd_rs <= 0;
//                    lcd_en <= 1;
//                    lcd_db <= 8'h0C;
//                    lcd_rw <= 0;
//                    delay_cnt <= delay_cnt + 1;
//                    if (delay_cnt == 1000) begin // 1 ms
//                        delay_cnt <= 0;
//                        state <= 2;
//                    end
//                end
//                2: begin // Clear display
//                    lcd_rs <= 0;
//                    lcd_en <= 1;
//                    lcd_db <= 8'h01;
//                    lcd_rw <= 0;
//                    delay_cnt <= delay_cnt + 1;
//                    if (delay_cnt == 1000) begin // 1 ms
//                        delay_cnt <= 0;
//                        state <= 3;
//                    end
//                end
//                3: begin // Entry mode: increment, no shift
//                    lcd_rs <= 0;
//                    lcd_en <= 1;
//                    lcd_db <= 8'h06;
//                    lcd_rw <= 0;
//                    delay_cnt <= delay_cnt + 1;
//                    if (delay_cnt == 1000) begin // 1 ms
//                        delay_cnt <= 0;
//                        state <= 4;
//                    end
//                end
//                4: begin // Write data
//                    lcd_en <= 1;
//                    lcd_db <= data;
//                    lcd_rs <= (data >= 8'h20);
//                    lcd_rw <= 0;
//                    lcd_ready <= 0;
//                    delay_cnt <= delay_cnt + 1;
//                    if (delay_cnt == 100) begin // 100 us
//                        delay_cnt <= 0;
//                        state <= 5;
//                    end
//                end
//                5: begin // Create falling edge
//                    lcd_en <= 0;
//                    delay_cnt <= delay_cnt + 1;
//                    if (delay_cnt == 100) begin // 100 us
//                        delay_cnt <= 0;
//                        state <= 6;
//                    end
//                end
//                6: begin // Signal ready
//                    lcd_ready <= 1;
//                    state <= 4;
//                end
//            endcase
//        end
//    end
//endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2025 12:15:04 PM
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
    input [7:0] data,          // Dữ liệu đầu vào
    input clk,                 // Clock 1 MHz
    input rst,                 // Reset active-low
    input key_valid,           // Tín hiệu xác nhận phím hợp lệ
    output reg [7:0] lcd_db,   // Bus dữ liệu LCD
    output reg lcd_rs,         // Register select
    output reg lcd_en,         // Enable LCD
    output reg lcd_rw,         // Read/Write
    output reg lcd_ready       // Tín hiệu LCD sẵn sàng
);
    reg [3:0] state = 0;       // Trạng thái FSM
    reg [11:0] delay_cnt = 0;  // Bộ đếm thời gian delay
    reg [4:0] dem = 0;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= 0;
            lcd_en <= 0;
            lcd_ready <= 0;
            delay_cnt <= 0;
            lcd_db <= 8'h00;
            lcd_rs <= 0;
            lcd_rw <= 0;
        end else begin
            case (state)
                0: begin // Thiết lập chức năng: 8-bit, 2 dòng, font 5x8
                    lcd_rs <= 0;
                    lcd_en <= 1;
                    lcd_db <= 8'h38;
                    lcd_rw <= 0;
                    delay_cnt <= delay_cnt + 1;
                    if (delay_cnt == 1000) begin // 1 ms
                        delay_cnt <= 0;
                        state <= 1;
                    end
                end
                1: begin // Bật hiển thị, tắt con trỏ
                    lcd_rs <= 0;
                    lcd_en <= 1;
                    lcd_db <= 8'h0C;
                    lcd_rw <= 0;
                    delay_cnt <= delay_cnt + 1;
                    if (delay_cnt == 1000) begin // 1 ms
                        delay_cnt <= 0;
                        state <= 2;
                    end
                end
                2: begin // Xóa màn hình
                    lcd_rs <= 0;
                    lcd_en <= 1;
                    lcd_db <= 8'h01;
                    lcd_rw <= 0;
                    delay_cnt <= delay_cnt + 1;
                    if (delay_cnt == 1000) begin // 1 ms
                        delay_cnt <= 0;
                        state <= 3;
                    end
                end
                3: begin // Chế độ nhập: ô thứ 2
                    lcd_rs <= 0;
                    lcd_en <= 1;
                    lcd_db <= 8'h81;
                    lcd_rw <= 0;
                    delay_cnt <= delay_cnt + 1;
                    if (delay_cnt == 1000) begin // 1 ms
                        delay_cnt <= 0;
                        state <= 4;
                    end
                end
                4: begin // Chờ dữ liệu hợp lệ
                    lcd_en <= 0;
                    lcd_ready <= 1;
                    if (key_valid) begin
                        lcd_db <= data;
                        lcd_rs <= (data >= 8'h20); // RS = 1 cho dữ liệu, 0 cho lệnh
                        lcd_rw <= 0;
                        lcd_ready <= 0;
                        dem <= dem + 1;
                        state <= 5;
                    end
                end
                5: begin // Ghi dữ liệu
                    lcd_en <= 1; // Kích hoạt cạnh lên
                    delay_cnt <= delay_cnt + 1;
                    if (delay_cnt == 100) begin // 100 us
                        delay_cnt <= 0;
                        state <= 6;
                    end
                end
                6: begin // Tạo cạnh xuống
                    lcd_en <= 0;
                    delay_cnt <= delay_cnt + 1;
                    if (delay_cnt == 100) begin // 100 us
                        delay_cnt <= 0;
                        state <= 4; // Quay lại chờ dữ liệu mới
                    end
                end
            endcase
        end
    end
endmodule
