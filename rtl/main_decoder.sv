`timescale 1ns / 1ps
module main_decoder (
    input logic [6:0] op,
    output logic jump,
    branch,
    memWrite,
    ALUSrc,
    regWrite,
    output logic [1:0] immSrc,
    ALUOp,
    resultSrc
);

  logic [10:0] controls;

  assign {regWrite, immSrc, ALUSrc, memWrite, resultSrc, jump, branch, ALUOp} = controls;

  always_comb
    case (op)
      7'b0000011: controls = 11'b1_00_1_0_01_0_0_00;
      7'b0010011: controls = 11'b1_00_1_0_00_0_0_00;
      7'b0100011: controls = 11'b0_01_1_1_xx_0_0_00;
      7'b0110011: controls = 11'b1_xx_0_0_00_0_0_10;
      7'b1100011: controls = 11'b0_10_0_0_xx_0_1_01;
      7'b1101111: controls = 11'b1_11_x_0_1x_1_x_xx;
      default: controls = 11'bx;
    endcase

endmodule
