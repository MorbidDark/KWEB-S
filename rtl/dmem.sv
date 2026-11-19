`timescale 1ns / 1ps

module dmem (
    input logic [31:0] a,
    input logic we,
    clk,
    input logic [31:0] wd,
    output logic [31:0] rd
);

  logic [31:0] mem[10000];

  //To ignore address reads/writes that are not divisible by 4
  assign rd = mem[a[15:2]];

  always_ff @(posedge clk) begin
    if (we) mem[a[15:2]] <= wd;
  end

endmodule
