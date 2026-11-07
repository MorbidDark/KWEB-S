module controller (
    input logic [6:0] op,
    input logic func7,
    zero,
    input logic [2:0] func3,
    output logic PCSrc,
    resultSrc,
    memWrite,
    ALUSrc,
    regWrite,
    output logic [1:0] immSrc,
    output logic [2:0] ALUControl
);

  logic branch;
  logic [1:0] ALUOp;

  assign PCSrc = branch & zero;

  main_decoder dec (
      .op(op),
      .branch(branch),
      .resultSrc(resultSrc),
      .memWrite(memWrite),
      .ALUSrc(ALUSrc),
      .regWrite(regWrite),
      .immSrc(immSrc),
      .ALUOp(ALUOp)
  );

  alu_decoder alu_dec (
      .op(op[5]),
      .func7(func7),
      .ALUOp(ALUOp),
      .func3(func3),
      .ALUControl(ALUControl)
  );

endmodule
