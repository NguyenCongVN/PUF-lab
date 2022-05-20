`timescale 100ns / 1ps
`define clk_period 10

module controller_simple_tb ();
    
    reg clk;
    // reg rx;
    // wire tx;
    // reg[63:0] rx_data;
    integer count;


    wire[63:0] responseGet;
    
    
    
    // Generate Clock signal
    initial count   = 0;
    initial clk                    = 1'b1;
    // always #(`clk_period/2) clk = ~clk;
    
    // controller controllertest(clk, rx, tx);
    controller_simple controllertest(clk, responseGet);
    
    always #(`clk_period/2) begin
        clk = ~clk;
        $display(responseGet);
        // rx    <= rx_data[count];
        // count <= count + 1;
    end
endmodule
