`timescale 100ns / 1ps
`define clk_period 10

module controller_tb ();
    
    reg clk;
    reg rx;
    wire tx;
    reg[63:0] rx_data;
    integer count;
    
    
    
    // Generate Clock signal
    initial rx_data = 64'b0110100101101001011010010110100101101001011010010110100101101001;
    initial count   = 0;
    
    initial clk                    = 1'b1;
    // always #(`clk_period/2) clk = ~clk;
    
    controller controllertest(clk, rx, tx);
    
    always #(`clk_period/2) begin
        clk = ~clk;
        $display("1");
        rx    <= rx_data[count];
        count <= count + 1;
    end
endmodule
