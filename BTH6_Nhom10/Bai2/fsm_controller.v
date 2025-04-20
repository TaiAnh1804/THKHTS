
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2025 03:14:08 AM
// Design Name: 
// Module Name: fsm_controller
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


module fsm_controller (
    input clk,
    input rst,
    input fifo_empty,
    input [7:0] fifo_data_out,
    input lcd_ready, 
    output reg fifo_rd_en,
    output reg [7:0] lcd_data,
    output reg enable_write
);
    reg [1:0] state = 0;

    always @(posedge clk or negedge  rst) begin
        if (rst == 0) begin
            fifo_rd_en <= 0;
            enable_write <= 0;
            state <= 0;
        end else begin
            case (state)
                0: if (!fifo_empty) begin
                        fifo_rd_en <= 1;
                        state <= 1;
                   end
                1: begin
                        fifo_rd_en <= 0;
                        lcd_data <= fifo_data_out;
                        enable_write <= 1;
                        state <= 2;
                   end
                2: if (lcd_ready) begin // Đợi lcd_wrapper sẵn sàng
                        enable_write <= 0;
                        state <= 0;
                   end
            endcase
        end
    end
endmodule