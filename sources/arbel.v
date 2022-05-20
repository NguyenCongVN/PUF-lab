`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2017 02:11:57 PM
// Design Name: Arbiter Element
// Module Name: arbel
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


(* keep_hierarchy = "yes" *) module arbel(
    input X, // if x , y = 0 -> W = 0
    input Y,
    input C,
    output W,
    output Z
    );
    
    wire W1, W2;
    wire Z1, Z2;



    // Truth Table Mux2x1 -> X-Y-C-Result if C = 0 -> Get X
    // if C = 1 -> Get Y.
    //
    //
    //
    //
    
    mux2x1 M1(X, Y, C, W1); // W1 -> output, X -> S0 , Y -> S1 , C -> S
    mux2x1 M2(Y, X, C, Z1); // 
    
    not N1(W2, W1); // Why keep same value???
    not N2(W, W2);
    not N7(Z2, Z1);
    not N8(Z, Z2);
    
endmodule
