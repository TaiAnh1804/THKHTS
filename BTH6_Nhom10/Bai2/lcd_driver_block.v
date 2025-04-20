`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2025 03:15:36 AM
// Design Name: 
// Module Name: lcd_driver_block
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


module lcd_driver_block (
    input clk_100MHz,
    input rst,
    input [3:0] row,
    output [3:0] col,
    output [7:0] lcd_db,
    output lcd_rs,
    output lcd_en,
    output lcd_rw
);
    wire clk_1MHz;
    wire [7:0] cnt;
    wire [7:0] data_in1, lcd_data, fifo_data_out;
    wire ready, wr_en1, fifo_rd_en, enable_write, fifo_empty, lcd_ready;

    // Chia tần
    clock_divider clk_div (
        .clk_100MHz(clk_100MHz),
        .rst(rst),
        .clk_1MHz(clk_1MHz)
    );
   
    // Kết nối bàn phím
//    wire [3:0] row; // từ mạch ngoài
//    wire [3:0] col;
    wire [7:0] key_ascii;
    wire key_valid;
    
        keypad_decoder keypad (
            .clk(clk_1MHz),
            .rst(rst),
            .row(row),
            .col(col),
            .key_ascii(key_ascii),
            .key_valid(key_valid)
        );
        
        // FIFO ghi khi có phím hợp lệ
        wire wr_en_key = key_valid;
        
        fifo fifo_inst (
            .clk(clk_1MHz),
            .rst(rst),
            .wr_en(wr_en_key),
            .rd_en(fifo_rd_en),
            .din(key_ascii),
            .dout(fifo_data_out),
            .full(),
            .empty(fifo_empty)
        );
        
        // Bộ điều khiển FSM
        fsm_controller fsm (
            .clk(clk_1MHz),
            .rst(rst),
            .fifo_empty(fifo_empty),
            .fifo_data_out(fifo_data_out),
            .lcd_ready(lcd_ready),
            .fifo_rd_en(fifo_rd_en),
            .lcd_data(lcd_data),
            .enable_write(enable_write)
        );
    
        // Giao tiếp LCD
        lcd_wrapper lcd (
            .data(lcd_data),
            .clk(clk_1MHz),
//            .key_valid(key_valid),
            .rst(rst),
            .lcd_db(lcd_db),
            .lcd_rs(lcd_rs),
            .lcd_en(lcd_en),
            .lcd_rw(lcd_rw),
            .lcd_ready(lcd_ready)
        );
endmodule
