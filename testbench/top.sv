module top();
    
    logic clk, 
    reset;

    logic memWrite;

    logic [31:0] readData,
    memAddress,
    memData,
    pc,
    instr;
    
    KWEB_S u_KWEB_S(
        .clk        (clk),
        .reset      (reset),
        .readData   (readData),
        .instr      (instr),
        .memWrite   (memWrite),
        .memAddress (memAddress),
        .memData    (memData),
        .pc         (pc)
    );
    
    imem 
    #(
        .width      (32),
        .depth      (1000),
        .addr_width (32)
    )
    instr_mem(
        .a  (pc),
        .rd (instr)
    );

    dmem 
    #(
        .width      (32),
        .depth      (10000),
        .addr_width (32)
    )
    data_mem(
        .a   (memAddress),
        .we  (memWrite),
        .clk (clk),
        .wd  (memData),
        .rd  (readData)
    );
        
endmodule
