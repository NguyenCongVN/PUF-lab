module arbiter_puf #(parameter le = 128)
                    (input in_X,
                     input in_Y,
                     input [le -1:0] Chal,
                     output out_Q);
    wire [le -1:0] A;
    wire [le -1:0] B;
    mux4x2 loop0 (. A(in_X) ,
    .B(in_Y) ,
    .c(Chal[0]) ,
    .X(A[0]) ,
    .Y(B[0])
    );
    genvar i;
    generate
    for (i = 1; i < le ; i = i + 1)
        begin : loop
        mux4x2 inst (.A(A[i -1]) ,
        .B(B[i -1]) ,
        .c(Chal [i]) ,
        .X(A[i]) ,
        .Y(B[i])
        );
    end
    endgenerate
    flipflop FF(A[127],B[127],out_Q);
endmodule
