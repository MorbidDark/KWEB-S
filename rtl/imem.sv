module imem
	#(parameter int width = 8,
	parameter int depth = 8,
	parameter int addr_width = 3)
	(input logic [addr_width-1:0] a,
	output logic [width-1:0] rd);

	logic [width-1:0] mem [depth-1:0];
	
	initial
		$readmemh("riscv_prog.txt", mem);

	assign rd = mem[a];

endmodule
