module KWEB_S_test ();

  //inputs
  logic [31:0] instr, readData;

  logic clk, reset;

  //outputs
  logic memWrite;

  logic [31:0] memAddress, memData, pc;

  KWEB_S dut_KWEB_S(
      .clk        (clk        ),
      .reset      (reset      ),
      .readData   (readData   ),
      .instr      (instr      ),
      .memWrite   (memWrite   ),
      .memAddress (memAddress ),
      .memData    (memData    ),
      .pc         (pc         )
  );
  

  always begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
  end

  initial begin

    //set t0-t4
    dut_KWEB_S.dp.rf_32.rf[5] = 0;
    dut_KWEB_S.dp.rf_32.rf[6] = 69;
    dut_KWEB_S.dp.rf_32.rf[7] = 6969;
    dut_KWEB_S.dp.rf_32.rf[28] = 696969;
    dut_KWEB_S.dp.rf_32.rf[29] = 69696969;

    //reset pc
    reset = 1'b1;

    //flags for lw
    
    //test lw instructions
    $display("\n\n\nBegin lw testing:");
    instr = 32'b000000000000_00110_010_01000_0000011;
    readData = 42;
    #40 reset = 1'b0;
    #10 $display("%t memWrite = %b, memAddress = %d, memData = %d, pc = %d", $time, memWrite, memAddress, memData, pc);
    instr = 32'b000000000101_00111_010_01001_0000011;
    readData = 4242;
    #10 $display("%t memWrite = %b, memAddress = %d, memData = %d, pc = %d", $time, memWrite, memAddress, memData, pc);
    instr = 32'b000000000011_11100_010_10010_0000011;
    readData = 424242;
    #10 $display("%t memWrite = %b, memAddress = %d, memData = %d, pc = %d", $time, memWrite, memAddress, memData, pc);
    $display("%t, s0 = %d, s1 = %d, s2 = %d", $time, dut_KWEB_S.dp.rf_32.rf[8], dut_KWEB_S.dp.rf_32.rf[9],
             dut_KWEB_S.dp.rf_32.rf[18]);

    //Begin sw testing
    $display("\n\n\nBegin sw testing:");
    //flags for sw
    instr = 32'b0000000_00101_00110_010_00000_0100011;
    #10 $display("%t memWrite = %b, memAddress = %d, memData = %d, pc = %d", $time, memWrite, memAddress, memData, pc);
    instr = 32'b0000000_10010_11101_010_00110_0100011;
    #10 $display("%t memWrite = %b, memAddress = %d, memData = %d, pc = %d", $time, memWrite, memAddress, memData, pc);
    instr = 32'b0000000_01001_10100_010_01111_0100011;
    #10 $display("%t memWrite = %b, memAddress = %d, memData = %d, pc = %d", $time, memWrite, memAddress, memData, pc);
    
    //Begin R-type testing
    $display("\n\n\nBegin R instruction testing:");
    //flags for R-Type
    instr = 32'b0000000_11100_00110_000_01000_0110011;
    #10 $display("%t memWrite = %b, memAddress = %d, memData = %d, pc = %d", $time, memWrite, memAddress, memData, pc);
    instr = 32'b0100000_11100_00110_000_01001_0110011;
    #10 $display("%t memWrite = %b, memAddress = %d, memData = %d, pc = %d", $time, memWrite, memAddress, memData, pc);
    instr = 32'b0000000_00111_00110_111_10010_0110011;
    #10 $display("%t memWrite = %b, memAddress = %d, memData = %d, pc = %d", $time, memWrite, memAddress, memData, pc);
    instr = 32'b0000000_11101_11100_110_10010_0110011;
    #10 $display("%t memWrite = %b, memAddress = %d, memData = %d, pc = %d", $time, memWrite, memAddress, memData, pc);
    instr = 32'b0000000_11100_00101_010_10010_0110011;
    #10 $display("%t memWrite = %b, memAddress = %d, memData = %d, pc = %d", $time, memWrite, memAddress, memData, pc);
    instr = 32'b0000000_00101_11100_010_10010_0110011;
    #10 $display("%t memWrite = %b, memAddress = %d, memData = %d, pc = %d", $time, memWrite, memAddress, memData, pc);
    $display("%t, s0 = %d, s1 = %d, s2 = %d", $time, dut_KWEB_S.dp.rf_32.rf[8], $signed(dut_KWEB_S.dp.rf_32.rf[9]),
             dut_KWEB_S.dp.rf_32.rf[18]);

    //Begin branch testing
    $display("\n\n\nBegin branch testing:");
    instr = 32'b0000001_00110_00101_000_00000_1100011;
    #10 $display("%t memWrite = %b, memAddress = %d, memData = %d, pc = %d", $time, memWrite, memAddress, memData, pc);
    instr = 32'b0000001_10010_00101_000_00000_1100011;
    #10 $display("%t memWrite = %b, memAddress = %d, memData = %d, pc = %d", $time, memWrite, memAddress, memData, pc);

    $stop;
  end

endmodule
