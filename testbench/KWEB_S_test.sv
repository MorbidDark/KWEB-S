`timescale 1ns / 1ps

module KWEB_S_test ();

  //inputs
  logic [31:0] instr, readData;

  logic clk, reset;

  //outputs
  logic memWrite;

  logic [31:0] memAddress, memData, pc;

  KWEB_S dut_KWEB_S (
      .clk       (clk),
      .reset     (reset),
      .readData  (readData),
      .instr     (instr),
      .memWrite  (memWrite),
      .memAddress(memAddress),
      .memData   (memData),
      .pc        (pc)
  );


  always begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
  end

  initial begin

    //reset pc
    reset = 1'b1;

    //test addi instructions
    $display("\n\n\nBegin addi testing:");
    instr = 32'b000000000000_00000_000_00101_0010011;
    #40 reset = 1'b0;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    instr = 32'b000001000101_00000_000_00110_0010011;
    readData = 42;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    instr = 32'b000001000011_00000_000_00111_0010011;
    readData = 42;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    instr = 32'b000101011111_00110_000_11100_0010011;
    readData = 42;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    instr = 32'b111001110111_11100_000_11101_0010011;
    readData = 42;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    $display("%t, t0 = %d, \nt1 = %d, \nt2 = %d, \nt3 = %d, \nt4 = %d", $time,
             dut_KWEB_S.dp.rf_32.rf[5], dut_KWEB_S.dp.rf_32.rf[6], dut_KWEB_S.dp.rf_32.rf[7],
             dut_KWEB_S.dp.rf_32.rf[28], dut_KWEB_S.dp.rf_32.rf[29]);

    //test lw instructions
    $display("\n\n\nBegin lw testing:");
    instr = 32'b000000000000_00110_010_01000_0000011;
    readData = 42;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    instr = 32'b000000000101_00111_010_01001_0000011;
    readData = 4242;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    instr = 32'b000000000011_11100_010_10010_0000011;
    readData = 424242;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    $display("%t, s0 = %d, s1 = %d, s2 = %d", $time, dut_KWEB_S.dp.rf_32.rf[8],
             dut_KWEB_S.dp.rf_32.rf[9], dut_KWEB_S.dp.rf_32.rf[18]);

    //Begin sw testing
    $display("\n\n\nBegin sw testing:");
    //sw t0, 0(t1)
    instr = 32'b0000000_00101_00110_010_00000_0100011;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    instr = 32'b0000000_10010_11101_010_00110_0100011;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    instr = 32'b0000000_01001_10100_010_01111_0100011;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );

    //Begin R-type testing
    $display("\n\n\nBegin R instruction testing:");
    //flags for R-Type
    instr = 32'b0000000_11100_00110_000_01000_0110011;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    instr = 32'b0100000_11100_00110_000_01001_0110011;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    instr = 32'b0000000_00111_00110_111_10010_0110011;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    instr = 32'b0000000_11101_11100_110_10010_0110011;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    instr = 32'b0000000_00101_11100_010_10010_0110011;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    instr = 32'b0000000_11100_00101_010_10010_0110011;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    $display("%t, s0 = %d, s1 = %d, s2 = %d", $time, dut_KWEB_S.dp.rf_32.rf[8],
             $signed(dut_KWEB_S.dp.rf_32.rf[9]), dut_KWEB_S.dp.rf_32.rf[18]);

    //Begin branch testing
    $display("\n\n\nBegin branch testing:");
    instr = 32'b0000001_00110_00101_000_00000_1100011;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    instr = 32'b0000001_00101_00101_000_00000_1100011;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );

    //Begin jump testing
    $display("\n\n\nBegin jump testing:");
    //jal ra, -104
    instr = 32'b11111001100111111111_00001_1101111;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    //jal ra, 2000
    instr = 32'b01111101000000000000_00001_1101111;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );
    //jal ra, -80
    instr = 32'b11111011000111111111_00001_1101111;
    #10
    $display(
        "%t memWrite = %b, memAddress = %d, memData = %d, pc = %d",
        $time,
        memWrite,
        memAddress,
        memData,
        pc
    );

    $stop;
  end

endmodule
