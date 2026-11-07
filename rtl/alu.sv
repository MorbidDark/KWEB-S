module alu #(
    parameter int width = 8
) (
    input logic [width-1:0] a,
    b,
    input logic [2:0] alucontrol,
    output logic [width-1:0] result,
    output logic zero
);

  always_comb begin
    case (alucontrol)
      3'b000:  result = a + b;
      3'b001:  result = a - b;
      3'b010:  result = a & b;
      3'b011:  result = a | b;
      3'b101:  if (a < b) result = 1;
 else result = 0;
      default: result = 'x;
    endcase
    if (result == 0) zero = 1;
    else zero = 0;
  end
endmodule
