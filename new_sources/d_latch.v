module d_latch (input D,
                input C,
                output Q);
    wire R , S , Qn ;
    wire R_g , S_g /* synthesis keep */ ;
    assign S = D;
    assign R = ~D;
    and (R_g , R , C);
    and (S_g , S , C);
    nor (Q , R_g , Qn);
    nor (Qn , S_g , Q);
endmodule
