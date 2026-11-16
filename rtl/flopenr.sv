`timescale 1ns/1ps

module flopenr #(
    parameter width = 8
) (
    input logic [width - 1:0] d,
    input logic clk,
    en,
    reset,
    output logic [width-1:0] q
);

  always_ff @(posedge clk, posedge reset)
    if (reset) q <= 0;
    else if (en) q <= d;

endmodule
