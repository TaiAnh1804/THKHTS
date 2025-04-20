
`timescale 1ns / 1ps

module lcd_driver_block (
    input clk_24MHz,
    input rst,
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
        .clk_24MHz(clk_24MHz),
        .rst(rst),
        .clk_1MHz(clk_1MHz)
    );

    // Bộ đếm cho chuỗi khởi tạo
    counter_cmd cnt_cmd (
        .clk(clk_1MHz),
        .rst(rst),
        .enable(ready),
        .lcd_ready(lcd_ready),
        .cnt(cnt)
    );

    // Khởi tạo FIFO
    fifo_initialization fifo_init (
        .clk(clk_1MHz),
        .rst(rst),
        .cnt(cnt),
        .Data_in1(data_in1),
        .Ready(ready),
        .wr_en1(wr_en1)
    );

    // FIFO
    fifo fifo_inst (
        .clk(clk_1MHz),
        .rst(rst),
        .wr_en(wr_en1),
        .rd_en(fifo_rd_en),
        .din(data_in1),
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
        .rst(rst),
        .lcd_db(lcd_db),
        .lcd_rs(lcd_rs),
        .lcd_en(lcd_en),
        .lcd_rw(lcd_rw),
        .lcd_ready(lcd_ready)
    );
endmodule

//module lcd_driver_block (
//    input clk_24MHz,
//    input rst,
//    output [7:0] lcd_db,
//    output lcd_rs,
//    output lcd_en,
//    output lcd_rw,
//    output [7:0] Data_test1,
//    output [7:0] Data_test2
//);
//    wire clk_1MHz;
//    wire [7:0] cnt;
//    wire [7:0] data_in1, lcd_data, fifo_data_out;
//    wire ready, wr_en1, fifo_rd_en, enable_write, fifo_empty, lcd_ready;
    
//    //test
    
//    assign Data_test1 = lcd_data;
//    assign Data_test2 = lcd_db;
    
//    // Chia tần
//    clock_divider clk_div (
//        .clk_24MHz(clk_24MHz),
//        .rst(rst),
//        .clk_1MHz(clk_1MHz)
//    );

//    // Bộ đếm cho chuỗi khởi tạo
//    counter_cmd cnt_cmd (
//        .clk(clk_1MHz),
//        .rst(rst),
//        .enable(ready),
//        .lcd_ready(lcd_ready),
//        .cnt(cnt)
//    );

//    // Khởi tạo FIFO
//    fifo_initialization fifo_init (
//        .clk(clk_1MHz),
//        .rst(rst),
//        .cnt(cnt),
//        .Data_in1(data_in1),
//        .Ready(ready),
//        .wr_en1(wr_en1)
//    );

//    // FIFO
//    fifo fifo_inst (
//        .clk(clk_1MHz),
//        .rst(rst),
//        .ffi_ready(ready),
//        .wr_en(wr_en1),
//        .rd_en(fifo_rd_en),
//        .din(data_in1),
//        .dout(fifo_data_out),
//        .full(),
//        .empty(fifo_empty)
//    );

//    // Bộ điều khiển FSM
//    fsm_controller fsm (
//        .clk(clk_1MHz),
//        .rst(rst),
//        .fifo_empty(fifo_empty),
//        .fifo_data_out(fifo_data_out),
//        .lcd_ready(lcd_ready),
//        .fifo_rd_en(fifo_rd_en),
//        .lcd_data(lcd_data),
//        .enable_write(enable_write)
//    );

//    // Giao tiếp LCD
//    lcd_wrapper lcd (
//        .data(lcd_data),
//        .clk(clk_1MHz),
//        .rst(rst),
//        .lcd_db(lcd_db),
//        .lcd_rs(lcd_rs),
//        .lcd_en(lcd_en),
//        .lcd_rw(lcd_rw),
//        .lcd_ready(lcd_ready)
//    );
//endmodule