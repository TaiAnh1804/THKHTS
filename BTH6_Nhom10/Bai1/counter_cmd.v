
`timescale 1ns / 1ps


module counter_cmd (
    input clk,
    input rst,
    input enable,
    input lcd_ready, 
    output reg [7:0] cnt
);
    always @(posedge clk or negedge  rst) begin
        if (rst == 0)
            cnt <= 0;
        else if (enable && lcd_ready) // Chỉ tăng khi LCD sẵn sàng
            cnt <= cnt + 1;
    end
endmodule