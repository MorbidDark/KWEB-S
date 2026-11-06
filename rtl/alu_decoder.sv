module alu_decoder(
    input logic op, func7,
    input logic [1:0] ALUOp,
    input logic [2:0] func3,
    output logic [2:0] ALUControl);

    always_comb
        case(ALUOp)
            2'b00: ALUControl = 3'b000;
            2'b01: ALUControl = 3'b001;
            2'b10: 
                case(func3)
                    3'b000: 
                        if(op & func7)
                            ALUControl = 3'b001;
                        else
                            ALUControl = 3'b000;
                    3'b010: ALUControl = 3'b101;
                    3'b110: ALUControl = 3'b011;
                    3'b111: ALUControl = 3'b010;
                    default: ALUControl = 3'bx;
                endcase
            default: ALUControl = 3'bx;
        endcase

endmodule
