
`timescale 1ns / 1ps
//Instruction memory. Has one read port.
module imem (
    /*ideally we want this to be [31:2] to ignore address reads that are not divisible by 4.
    If I ever adjust KWEB to allow for non-word aligned reads, perhaps I will change this.
    This is [11:2] for now since this instruction memory for testing only holds 1000 words.
    */
    input  logic [31:0] a,
    output logic [31:0] rd
);

  logic [31:0] mem[1000];

  initial $readmemh("riscv_prog.txt", mem);
  //word alignment. Addresses that are not divisible by 4 are ignored.
  assign rd = mem[a[11:2]];

endmodule
