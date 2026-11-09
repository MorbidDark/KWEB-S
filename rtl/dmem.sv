module dmem #(
    parameter int width = 8,
    parameter int depth = 8,
    parameter int addr_width = 3
) (
    input logic [addr_width-1:0] a,
    input logic we,
    clk,
    input logic [width-1:0] wd,
    output logic [width-1:0] rd
);

  logic [width-1:0] mem[depth-1:0];

  assign rd = mem[a];

  always_ff @(posedge clk) begin
    if (we) mem[a] <= wd;
  end

endmodule
