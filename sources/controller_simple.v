`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/26/2017 06:38:45 PM
// Design Name:
// Module Name: controller
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


module controller_simple(input CLOCK_50,
                         input [3:0] KEY,
                         input [17:0] SW,
                         output [6:0] HEX0,
                         HEX1,
                         HEX2,
                         HEX3,
                         HEX4,
                         HEX5,
                         HEX6,
                         HEX7,
                         output [8:0] LEDG,    // LED Green[8:0]
                         output [23:0] LEDR,   // LED Red[17:0]
                         inout [35:0] GPIO_0);
    
    reg rst = 1;
    reg [63:0]challenge; // 8 bytes
    wire [7:0]response; // 8 bytes
    reg signal = 1;
    
    reg [2:0] A0;
    reg [2:0] A1;
    reg [2:0] A2;
    reg [2:0] A3;
    reg [2:0] A4;
    reg [2:0] A5;
    reg [2:0] A6;
    reg [2:0] A7;
    
    arbiterpuf A(signal, challenge, response); // Signal = input as A and B in Mux for what????
    
    // set all inout ports to tri-state
    assign GPIO_0 = 36'hzzzzzzzzz;
    // Connect register to red LEDs
    assign LEDR[2:0]   = A0;
    assign LEDR[5:3]   = A1;
    assign LEDR[8:6]   = A2;
    assign LEDR[11:9]  = A3;
    assign LEDR[14:12] = A4;
    assign LEDR[17:15] = A5;
    assign LEDR[20:18] = A6;
    assign LEDR[23:21] = A7;
    // turn off green LEDs
    assign LEDG[8:0] = 0;
    
    // map to 7-segment displays
    hex_7seg dsp0(A0,HEX0);
    hex_7seg dsp1(A1,HEX1);
    hex_7seg dsp2(A2,HEX2);
    hex_7seg dsp3(A3,HEX3);
    hex_7seg dsp4(A4,HEX4);
    hex_7seg dsp5(A5,HEX5);
    hex_7seg dsp6(A6,HEX6);
    hex_7seg dsp7(A7,HEX7);
    // control (set) value of A, signal with KEY3
    
    initial begin
        // challenge        = 64'h62dfa0145403b846;
        challenge        = 64'h19f6cf91b090ac77;
        A0               = 3'b000;
        A1               = 3'b000;
        A2               = 3'b000;
        A3               = 3'b000;
        A4               = 3'b000;
        A5               = 3'b000;
        A6               = 3'b000;
        A7               = 3'b000;
    end
    
    always @(posedge CLOCK_50) begin
        //Process while the PUF is working on the response
        if (signal) begin
            A0[0]  <= response[0];
            A1[0]  <= response[1];
            A2[0]  <= response[2];
            A3[0]  <= response[3];
            A4[0]  <= response[4];
            A5[0]  <= response[5];
            A6[0]  <= response[6];
            A7[0]  <= response[7];
            signal <= 0;
        end
    end
    
endmodule
