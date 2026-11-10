module datapath_test ();

  logic [31:7] instr;

  logic [31:0] readData, ALUResult, rfd2, pc;

  logic clk, reset;

  logic regWrite, ALUSrc, resultSrc, PCSrc, zero;

  logic [1:0] immSrc;

  logic [2:0] ALUControl;

  datapath dut (
      .clk       (clk),
      .reset     (reset),
      .regWrite  (regWrite),
      .ALUSrc    (ALUSrc),
      .resultSrc (resultSrc),
      .PCSrc     (PCSrc),
      .immSrc    (immSrc),
      .instr     (instr),
      .readData  (readData),
      .ALUControl(ALUControl),
      .pc        (pc),
      .ALUResult (ALUResult),
      .rfd2      (rfd2),
      .zero      (zero)
  );

  always begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
  end

  initial begin

    //set t0-t4
    dut.rf_32.rf[5] = 32'b0;
    dut.rf_32.rf[6] = 32'd69;
    dut.rf_32.rf[7] = 32'd6969;
    dut.rf_32.rf[28] = 32'd696969;
    dut.rf_32.rf[29] = 32'd69696969;

    //reset pc
    reset = 1'b1;

    //flags for lw
    {regWrite, ALUSrc, resultSrc, PCSrc, immSrc, ALUControl} = 9'b1_1_1_0_00_000;
    
    //test lw instructions
    $display("\n\n\nBegin lw testing:");
    instr = 25'b000000000000_00110_010_01000;
    readData = 32'd42;
    #10 reset = 1'b0;
    #10 $display("%t pc = %d, ALUResult = %d, zero = %b", $time, pc, ALUResult, zero);
    instr = 25'b000000000101_00111_010_01001;
    readData = 4242;
    #10 $display("%t pc = %d, ALUResult = %d, zero = %b", $time, pc, ALUResult, zero);
    instr = 25'b000000000011_11100_010_10010;
    readData = 424242;
    #10 $display("%t pc = %d, ALUResult = %d, zero = %b", $time, pc, ALUResult, zero);
    $display("%t, s0 = %d, s1 = %d, s2 = %d", $time, dut.rf_32.rf[8], dut.rf_32.rf[9],
             dut.rf_32.rf[18]);

    //Begin sw testing
    $display("\n\n\nBegin sw testing:");
    //flags for sw
    {regWrite, ALUSrc, resultSrc, PCSrc, immSrc, ALUControl} = 9'b0_1_0_0_01_000;
    instr = 25'b0000000_00101_00110_010_00000;
    #10 $display("%t pc = %d, ALUResult = %d, rfd2 = %d, zero = %b", $time, pc, ALUResult, rfd2, zero);
    instr = 25'b0000000_10010_11101_010_00110;
    #10 $display("%t pc = %d, ALUResult = %d, rfd2 = %d, zero = %b", $time, pc, ALUResult, rfd2, zero);
    instr = 25'b0000000_01001_10100_010_01111;
    #10 $display("%t pc = %d, ALUResult = %d, rfd2 = %d, zero = %b", $time, pc, ALUResult, rfd2, zero);
    
    //Begin R-type testing
    $display("\n\n\nBegin R instruction testing:");
    //flags for R-Type
    { regWrite, ALUSrc, resultSrc, PCSrc, immSrc} = 6'b1_0_0_0_00;
    ALUControl = 3'b000;
    instr = 25'b0000000_11100_00110_000_01000;
    #10 $display("%t pc = %d, ALUResult = %d, zero = %b", $time, pc, ALUResult, zero);
    ALUControl = 3'b001;
    instr = 25'b0100000_11100_00110_000_01001;
    #10 $display("%t pc = %d, ALUResult = %d, zero = %b", $time, pc, $signed(ALUResult), zero);
    ALUControl = 3'b010;
    instr = 25'b0000000_00111_00110_111_10010;
    #10 $display("%t pc = %d, ALUResult = %d, zero = %b", $time, pc, ALUResult, zero);
    ALUControl = 3'b011;
    instr = 25'b0000000_11101_11100_110_10010;
    #10 $display("%t pc = %d, ALUResult = %d, zero = %b", $time, pc, ALUResult, zero);
    ALUControl = 3'b101;
    instr = 25'b0000000_11100_00101_010_10010;
    #10 $display("%t pc = %d, ALUResult = %d, zero = %b", $time, pc, ALUResult, zero);
    ALUControl = 3'b101;
    instr = 25'b0000000_00101_11100_010_10010;
    #10 $display("%t pc = %d, ALUResult = %d, zero = %b", $time, pc, ALUResult, zero);
    $display("%t, s0 = %d, s1 = %d, s2 = %d", $time, dut.rf_32.rf[8], dut.rf_32.rf[9],
             dut.rf_32.rf[18]);

    //Begin branch testing
    $display("\n\n\nBegin branch testing:");
    { regWrite, ALUSrc, resultSrc, immSrc, ALUControl } = 8'b1_0_0_11_001;
    PCSrc = 1'b0;
    instr = 25'b0000001_00110_00101_000_00000;
    #10 $display("%t pc = %d, ALUResult = %d, zero = %b", $time, pc, $signed(ALUResult), zero);
    PCSrc = 1'b1;
    instr = 25'b0000001_10010_00101_000_00000;
    #10 $display("%t pc = %d, ALUResult = %d, zero = %b", $time, pc, $signed(ALUResult), zero);


    $stop;
  end

endmodule
