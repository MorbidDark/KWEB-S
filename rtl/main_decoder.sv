module main_decoder (
    input logic [6:0] op,
    output logic branch, resultSrc, memWrite, ALUSrc, regWrite,
    output logic [1:0] immSrc, ALUOp);

    logic [8:0] controls;

    assign {regWrite, immSrc, ALUSrc, memWrite, resultSrc, branch, ALUOp}
        = controls;

    always_comb
        case(op)
            7'b0000011: controls = 9'b1_00_1_0_1_0_00;
            7'b0100011: controls = 9'b0_01_1_1_x_0_00;
            7'b0110011: controls = 9'b1_xx_0_0_0_0_10;
            7'b1100011: controls = 9'b0_10_0_0_x_1_01;
            default: controls = 9'bx;
        endcase

endmodule
