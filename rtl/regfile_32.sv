module regfile_32
	(input logic clk, we3,
	input logic [4:0] a1, a2, a3,
	input logic [31:0] wd3,
	output logic [31:0] rd1, rd2);

	logic [31:0] rf [31:0];
	
	assign rf[0] = 0;

	assign rd1 = rf[a1];
	assign rd2 = rf[a2];

	always @(negedge clk)
		if(we3 && a3 != 0) rf[a3] <= wd3;

endmodule
