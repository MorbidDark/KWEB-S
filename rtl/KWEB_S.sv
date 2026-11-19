`timescale 1ns/1ps

module KWEB_S (
    input logic clk,
    reset,
    input logic [31:0] readData,
    instr,
    output logic memWrite,
    output logic [31:0] memAddress,
    memData,
    pc
);

  logic PCSrc, ALUSrc, regWrite, zero;
  logic [1:0] immSrc, resultSrc;
  logic [2:0] ALUControl;

  controller control (
      .op(instr[6:0]),
      .func7(instr[30]),
      .zero(zero),
      .func3(instr[14:12]),
      .PCSrc(PCSrc),
      .resultSrc(resultSrc),
      .memWrite(memWrite),
      .ALUSrc(ALUSrc),
      .regWrite(regWrite),
      .immSrc(immSrc),
      .ALUControl(ALUControl)
  );

  datapath dp (
      .clk(clk),
      .reset(reset),
      .regWrite(regWrite),
      .ALUSrc(ALUSrc),
      .resultSrc(resultSrc),
      .PCSrc(PCSrc),
      .immSrc(immSrc),
      .instr(instr[31:7]),
      .readData(readData),
      .ALUControl(ALUControl),
      .pc(pc),
      .ALUResult(memAddress),
      .rfd2(memData),
      .zero(zero)
  );

endmodule
