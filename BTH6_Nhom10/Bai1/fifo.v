
`timescale 1ns / 1ps


module fifo #(
    parameter DEPTH = 16,
    parameter WIDTH = 8
)(
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input ffi_ready,
    input [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout,
    output reg full,
    output reg empty
);
    reg [WIDTH-1:0] mem[0:DEPTH-1];
    reg [3:0] wr_ptr = 0;
    reg [3:0] rd_ptr = 0;
    reg [4:0] count = 0;
    reg [3:0] clk_cnt = 0;
    always @(posedge clk) begin
        if (rst == 0) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count <= 0;
            full <= 0;
            empty <= 1;
        end    
        else begin
            if (wr_en && !full) begin
                mem[wr_ptr] <= din;
                wr_ptr <= wr_ptr + 1;
                count <= count + 1;
            end
            if (rd_en && !empty) begin
                dout <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                count <= count - 1;
            end
            full <= (count == DEPTH);
            empty <= (count == 0);           
        end
    end
endmodule
