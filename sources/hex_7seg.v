module hex_7seg(hex_digit,
                seg);
    input[2:0] hex_digit;
    output [6:0] seg;
    reg [6:0] seg;
    // seg = {g,f,e,d,c,b,a};
    // 0 is on and 1 is off
    always @ (hex_digit)
        // CONG_|_|_|_
        case (hex_digit)
            3'h0: seg    = ~7'b0111111; //{0,1,1,1,0,0,1};
            3'h1: seg    = ~7'b0000011;//{0,1,1,1,1,1,1};
            // 3'h2: seg    = ~7'b0111111; //{0,1,1,0,1,1,1};
            // 3'h3: seg    = ~7'b0111001; //{1,1,1,1,1,0,1};
            // 3'h4: seg    = ~7'b0000000; //{1,1,1,1,1,0,1};
            // 3'h5: seg    = ~7'b0000000; //{0,1,1,1,1,1,1};
            // 3'h6: seg    = ~7'b0000000; //{1,1,1,1,1,0,1};
            // 3'h7: seg    = ~7'b0000000; //{1,1,1,1,1,0,1};
            // 4'h1: seg = ~7'h06; // ---a----
            // 4'h2: seg = ~7'h5B; // | |
            // 4'h3: seg = ~7'h4F; // f b
            // 4'h4: seg = ~7'h66; // | |
            // 4'h5: seg = ~7'h6D; // ---g----
            // 4'h6: seg = ~7'h7D; // | |
            // 4'h7: seg = ~7'h07; // e c
            // 4'h8: seg = ~7'h7F; // | |
            // 4'h9: seg = ~7'h67; // ---d----
            // 4'ha: seg = ~7'h77;
            // 4'hb: seg = ~7'h7C;
            // 4'hc: seg = ~7'h39;
            // 4'hd: seg = ~7'h5E;
            // 4'he: seg = ~7'h79;
            // 4'hf: seg = ~7'h71;
        endcase
endmodule
