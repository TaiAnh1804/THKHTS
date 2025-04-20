
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2025 03:13:34 AM
// Design Name: 
// Module Name: keypad_decoder
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


//module keypad_decoder (
//    input clk,
//    input rst,
//    input [3:0] row,
//    output reg [3:0] col,
//    output reg [7:0] key_ascii,
//    output reg key_valid
//);
//    reg [1:0] state = 0;
//    reg [19:0] debounce = 0;

//    always @(posedge clk or negedge rst) begin
//        if (!rst) begin
//            col <= 4'b1110; // bắt đầu với cột 0
//            state <= 0;
//            key_valid <= 0;
//        end else begin
//            debounce <= debounce + 1;

//            if (debounce == 20'd500_000) begin // debounce ~5ms
//                debounce <= 0;
//                col <= {col[2:0], col[3]}; // quét cột luân phiên

//                case ({col, row})                   
//                    8'b1110_1110: begin key_ascii <= "1"; key_valid <= 1; end       //cot 1 hang 1
//                    8'b1101_1110: begin key_ascii <= "2"; key_valid <= 1; end       //cot 2 hang 1
//                    8'b1011_1110: begin key_ascii <= "3"; key_valid <= 1; end       //cot 3 hang 1
//                    8'b1110_1101: begin key_ascii <= "4"; key_valid <= 1; end       //cot 1 hang 2
//                    8'b1101_1101: begin key_ascii <= "5"; key_valid <= 1; end       //cot 2 hang 2
//                    8'b1011_1101: begin key_ascii <= "6"; key_valid <= 1; end       //cot 3 hang 2
//                    8'b1110_1011: begin key_ascii <= "7"; key_valid <= 1; end       //cot 1 hang 3
//                    8'b1101_1011: begin key_ascii <= "8"; key_valid <= 1; end       //cot 2 hang 3
//                    8'b1011_1011: begin key_ascii <= "9"; key_valid <= 1; end       //cot 3 hang 3
//                    8'b1101_0111: begin key_ascii <= "0"; key_valid <= 1; end       //cot 2 hang 4
//                    default: key_valid <= 0;
//                endcase
//            end else begin
//                key_valid <= 0;
//            end
//        end
//    end
//endmodule



module keypad_decoder (
    input clk,
    input rst,
    input [3:0] row,
    output reg [3:0] col,
    output reg [7:0] key_ascii,
    output reg key_valid
);
    parameter LAG = 10;                   // 

	reg [19:0] scan_timer = 0;            // to count up to 499
	reg [1:0] col_select = 0;             // 2 bit counter to select 4 columns
	
	always @(posedge clk)          //  sau 100 xung clk =  scan-timer + 1
		if(scan_timer == 99) begin    // 
			scan_timer <= 0;
			col_select <= col_select + 1;
		end
		else
			scan_timer <= scan_timer + 1;

    // set columns, check rows
	always @(posedge clk) begin
            case(col_select)
                2'b00 :	begin
                           col = 4'b0111;
                           if(scan_timer == LAG)
                              case(row)
                                  4'b0111 :	begin key_ascii <= "1"; key_valid <= 1; end	// 1
                                  4'b1011 :	begin key_ascii <= "4"; key_valid <= 1; end	// 4
                                  4'b1101 :	begin key_ascii <= "7"; key_valid <= 1; end	// 7
                                  4'b1110 :	begin key_ascii <= "0"; key_valid <= 1;	end // 0
                              endcase
                        end
                2'b01 :	begin
                           col = 4'b1011;
                           if(scan_timer == LAG)
                              case(row)    		
                                  4'b0111 :	begin key_ascii <= "2"; key_valid <= 1; end 	// 2	
                                  4'b1011 :	begin key_ascii <= "5"; key_valid <= 1; end 	// 5	
                                  4'b1101 :	begin key_ascii <= "8"; key_valid <= 1; end	    // 8	
                                  4'b1110 : begin key_ascii <= 8'h01; key_valid <= 1; end	// F clear display
                              endcase
                        end 
                2'b10 :	begin       
                           col = 4'b1101;
                           if(scan_timer == LAG)
                              case(row)    		       
                                  4'b0111 :	begin key_ascii <= "3"; key_valid <= 1; end	    // 3 		
                                  4'b1011 :	begin key_ascii <= "6"; key_valid <= 1; end	    // 6 		
                                  4'b1101 :	begin key_ascii <= "9"; key_valid <= 1; end 	// 9 		
                                  4'b1110 : begin key_ascii <= "="; key_valid <= 1; end 	// E =	 
                              endcase      
                        end
                2'b11 :	begin
                           col = 4'b1110;
                           if(scan_timer == LAG)
                              case(row)    
                                  4'b0111 :	begin key_ascii <= "+"; key_valid <= 1; end 	// A +
                                  4'b1011 :	begin key_ascii <= "-"; key_valid <= 1; end 	// B -
                                  4'b1101 :	begin key_ascii <= "*"; key_valid <= 1; end     // C *
                                  4'b1110 :	begin key_ascii <= "/"; key_valid <= 1; end 	// D /
                              endcase      
                        end
            endcase
            
		end
endmodule
