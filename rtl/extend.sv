module extend (
    input  logic [31:7] imm,
    input  logic [ 1:0] immSrc,
    output logic [31:0] immext
);

  always_comb
    case (immSrc)
      2'b00:   immext = {{20{imm[31]}}, imm[31:20]};
      2'b01:   immext = {{20{imm[31]}}, imm[31:25], imm[11:7]};
      2'b11:   immext = {{20{imm[31]}}, imm[7], imm[30:25], imm[11:8], 1'b0};
      default: immext = 32'hx;
    endcase
endmodule
