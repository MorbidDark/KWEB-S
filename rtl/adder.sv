`timescale 1ns / 1ps

module adder #(
    parameter int width = 8
) (
    input  logic [width-1:0] a,
    b,
    output logic [width-1:0] sum
);

  assign sum = a + b;
endmodule
