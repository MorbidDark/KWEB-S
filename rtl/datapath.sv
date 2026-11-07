module datapath (
    input logic clk,
    reset,
    input logic regWrite,
    input logic ALUSrc,
    resultSrc,
    PCSrc,
    input logic [1:0] immSrc,
    input logic [31:7] instr,
    input logic [31:0] readData,
    input logic [2:0] ALUControl,
    output logic [31:0] pc,
    ALUResult,
    rfd2,
    output logic zero
);

  logic [31:0] immExt;
  logic [31:0] PCNext, PCPlus4, PCTarget;
  logic [31:0] rfd1, ALUSrcB, result;

  mux_2 #(32) pc_next_mux (
      .d0(PCPlus4),
      .d1(PCTarget),
      .s (PCSrc),
      .y (PCNext)
  );

  flopenr #(32) prog_count (
      .d(PCNext),
      .clk(clk),
      .en(1'b1),
      .reset(reset),
      .q(pc)
  );

  adder #(32) pc_adder (
      .a  (pc),
      .b  (32'b100),
      .sum(PCPlus4)
  );

  regfile_32 rf_32 (
      .clk(clk),
      .we3(regWrite),
      .a1 (instr[19:15]),
      .a2 (instr[24:20]),
      .a3 (instr[11:7]),
      .wd3(result),
      .rd1(rfd1),
      .rd2(rfd2)
  );

  mux_2 #(32) alu_src_b_mux (
      .d0(rfd2),
      .d1(immExt),
      .s (ALUSrc),
      .y (ALUSrcB)
  );

  extend ex (
      .imm(instr[31:7]),
      .immSrc(immSrc),
      .immext(immExt)
  );

  alu #(32) dp_alu (
      .a(rfd1),
      .b(ALUSrcB),
      .alucontrol(ALUControl),
      .result(ALUResult),
      .zero(zero)
  );

  adder #32 pc_branch_adder (
      .a  (pc),
      .b  (immExt),
      .sum(PCTarget)
  );

  mux_2 #(32) result_mux (
      .d0(ALUResult),
      .d1(readData),
      .s (resultSrc),
      .y (result)
  );

endmodule

