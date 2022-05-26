module flipflop (Df,
                 Cf,
                 Qf);
    input Df , Cf ;
    output Qf ;
    wire Qm ;
    d_latch master (Df , ~Cf , Qm);
    d_latch slave (Qm , Cf , Qf);
endmodule
