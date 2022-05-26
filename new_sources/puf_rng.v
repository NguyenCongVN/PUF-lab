module puf_rng (input clk);
    parameter idle           = 3'b000 ;
    parameter lfsr_start     = 3'b001 ;
    parameter lfsr_wait      = 3'b111 ;
    parameter puf_start      = 3'b010 ;
    parameter puf_wait       = 3'b011 ;
    parameter puf_store_bit  = 3'b100 ;
    parameter puf_store_word = 3'b101 ;
    parameter start_wait     = 3'b110 ;
    reg [2:0] state ;
    reg [6:0] cnt_128 ;
    reg [4:0] cnt_wait_cycles ;
    reg start ;
    reg stop ;
    reg rst_n ;
    reg store_bit ;
    reg store_word ;
    reg puf_en ;
    reg en_lfsr ;
    reg rst_lfsr ;
    reg [127:0] challenge ;
    wire response ;
    reg [127:0] word_128 ;
    always @(posedge clk or negedge rst_n)
    begin
        if (! rst_n)
        begin
            state           <= idle ;
            puf_en          <= 1'b0 ;
            store_bit       <= 1'b0 ;
            store_word      <= 1'b0 ;
            cnt_128         <= 7'b1111111 ;
            cnt_wait_cycles <= 5'b11111 ;
            stop            <= 1'b0 ;
        end
        else begin
            puf_en     <= 1'b0 ;
            store_bit  <= 1'b0 ;
            store_word <= 1'b0 ;
            en_lfsr    <= 1'b0 ;
            case (state)
                idle :
                begin
                    if (! start) begin
                        stop <= 1'b0 ;
                    end
                    if (start && (! stop)) begin
                        cnt_128 <= 7'b1111111 ;
                        state   <= lfsr_start ;
                    end
                end
                lfsr_start :
                begin
                    en_lfsr         <= 1'b1 ;
                    cnt_wait_cycles <= 5'b11111 ;
                    state           <= lfsr_wait ;
                end
                lfsr_wait :
                begin
                    cnt_wait_cycles <= cnt_wait_cycles - 1;
                    if (cnt_wait_cycles == 0) state < = puf_start ;
                end
                puf_start :
                begin
                    puf_en          <= 1'b1 ; // pos edge gen
                    cnt_wait_cycles <= 5'b11111 ;
                    state           <= puf_wait ;
                end
                puf_wait :
                begin
                    cnt_wait_cycles <= cnt_wait_cycles - 1;
                    if (cnt_wait_cycles == 0) state <= puf_store_bit ;
                end
                puf_store_bit :
                begin
                    store_bit <= 1'b1 ;
                    state     <= puf_store_word ;
                end
                puf_store_word :
                begin
                    if (cnt_128 == 0) begin
                        store_word <= 1'b1 ;
                        state      <= start_wait ;
                    end
                    else begin
                        cnt_128 <= cnt_128 - 1;
                        state   <= lfsr_start ;
                    end
                end
                start_wait :
                begin
                    if (mem_wr == 1 && mem_addr == 13'b1111111111111) begin
                        stop <= 1'b1 ;
                    end
                    if (mem_wr == 1) begin
                        state <= idle ;
                    end
                end
                default :
                begin
                    state <= idle ;
                end
            endcase
        end
    end
    always @(posedge clk or negedge rst_n)
    begin
        if (! rst_n) begin
            word_128 <= 128'b0 ;
        end
        else
            if (store_bit) begin
                word_128     <= (word_128 << 1) ;
                word_128 [0] <= response ;
            end
    end
    reg [127:0] mem_data ;
    reg [12:0] mem_addr ;
    reg mem_wr ;
    always @(posedge clk or negedge rst_n)
    begin
        if (! rst_n) begin
            mem_addr <= 13'b1111111111111 ;
            
            mem_wr   <= 1'b0 ;
            mem_data <= 0;
        end
        else begin
            mem_wr <= 1' b0 ;
            if (store_word) begin
                mem_data <= word_128 ;
                mem_addr <= mem_addr + 1;
                mem_wr   <= 1'b1 ;
            end
        end
    end
    reg [2:0] source ;
    wire [127:0] chal_cst ;
    wire [127:0] chal_lfsr ;
    reg sel ;
    always @(posedge clk or negedge rst_n) rst_lfsr <= (! rst_n);


    // testreg testreg (.probe() , //
    // probes.probe
    // .source_clk(clk) , //
    // source_clk.clk
    // .source(source) //
    // sources.source
    // );


    always @(posedge clk)
    begin
        start <= source[0];
        rst_n <= source[1];
        sel   <= source[2];
    end
    // lfsr_reg lfsrreg (
    // .probe() , //
    // probes.probe
    // .source_clk(clk) , //
    // source_clk.clk
    // .source(chal_cst) //
    // sources.source
    // );


    
    // G_LFSR128 lfsr_ins(.clk(clk),
    // .en(en_lfsr),
    // .rst(rst_lfsr),
    // .stage(chal_lfsr)
    // );
    // always @(posedge clk or negedge rst_n)
    // begin
    //     if (! rst_n)
    //         challenge <= 128'b0 ;
    //     else begin
    //         if (sel == 1) challenge      < = chal_cst ; else challenge < = chal_lfsr ;
    //     end
    // end
    // assign challenge = (sel == 1) ? chal_cst : chal_lfsr;
    // arbiter_puf puf_ins (.in_X(puf_en) ,
    // .in_Y(puf_en) ,
    // .Chal(challenge) ,
    // .out_Q(response)
    // );
    // test_mem testmem(.address(mem_addr) ,
    // .clock(clk),
    // .data(mem_data) ,
    // .wren(mem_wr) ,
    // .q()
    // );
endmodule
