
//`timescale 1ns / 1ps


//module fifo_initialization (
//    input clk,
//    input rst,
//    input [7:0] cnt,
//    output reg [7:0] Data_in1,
//    output reg Ready,
//    output reg wr_en1
//);
//    always @(posedge clk or negedge  rst) begin
//        if (rst == 0 ) begin
//            wr_en1 <= 0;
//            Ready <= 0;
//        end else begin
//            wr_en1 <= 1;
//            Ready <= 1;
//            Data_in1 <= 0;
//            case (cnt)
//                0: Data_in1 <= 8'h38; // Function Set
//                1: Data_in1 <= 8'h0C; // Display ON
//                2: Data_in1 <= 8'h01; // Clear Display
//                3: Data_in1 <= 8'h06; // Entry Mode
//                4: Data_in1 <= "K";   //75 01001011
//                5: Data_in1 <= "H";   //72 01001000
//                6: Data_in1 <= "I";   //73 01001001
//                7: Data_in1 <= "E";   //69 01000101
//                8: Data_in1 <= "M";   //77 01001101
//                9: Data_in1 <= "D";
//                10: Data_in1 <= "T";
//                11: Data_in1 <= "0";
//                12: Data_in1 <= "6";
//                13: Data_in1 <= "0";
//                14: Data_in1 <= "1";
//                15: Data_in1 <= "3";
//                16: Data_in1 <= "2";
                
//                default: begin
                    
//                    wr_en1 <= 0;
//                    Ready <= 0;
//                end
//            endcase
//        end
//    end
//endmodule

`timescale 1ns / 1ps


module fifo_initialization (
    input clk,
    input rst,
    input [7:0] cnt,
    output reg [7:0] Data_in1,
    output reg Ready,
    output reg wr_en1
);
    always @(posedge clk or negedge  rst) begin
        if (rst == 0 ) begin
            wr_en1 <= 0;
            Ready <= 0;
        end else begin
            if (cnt <= 17) begin
                wr_en1 <= 1;
                Ready <= 1;
                Data_in1 <= 0;
                case (cnt)
                    0: Data_in1 <= 8'h38; // Function Set
                    1: Data_in1 <= 8'h0C; // Display ON
                    2: Data_in1 <= 8'h01; // Clear Display
                    3: Data_in1 <= 8'h06; // Entry Mode
                    4: Data_in1 <= "K";   //75 01001011
                    5: Data_in1 <= "H";   //72 01001000
                    6: Data_in1 <= "I";   //73 01001001
                    7: Data_in1 <= "E";   //69 01000101
                    8: Data_in1 <= "M";   //77 01001101
                    9: Data_in1 <= "D";
                    10: Data_in1 <= "T";
                    11: Data_in1 <= "0";
                    12: Data_in1 <= "6";
                    13: Data_in1 <= "0";
                    14: Data_in1 <= "1";
                    15: Data_in1 <= "3";
                    16: Data_in1 <= "2";
                    17: Data_in1 <= " ";
                    default: begin
                        Data_in1 <= 0;
                    end
                endcase
            end
            else begin 
                wr_en1 <= 0;
                Ready <= 0;
                Data_in1 <= 0;
            end
        end
    end
endmodule
