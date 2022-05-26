module mux4x2 (A,
               B,
               c,
               X,
               Y);
    input A , B , c;
    output X , Y;
    wire xg , yg /* synthesis keep */ ;
    mux2x1 M1 (A , B , c , xg);
    mux2x1 M2 (B , A , c , yg);
    assign X = xg ;
    assign Y = yg ;
endmodule
    module mux2x1 (j , k , s , m);
        input j , k , s;
        output m;
        wire sg ;
        wire jg , kg ;
        not (sg , s);
        and (jg , j , sg);
        and (kg , k , s);
        or (m , jg , kg);
    endmodule
