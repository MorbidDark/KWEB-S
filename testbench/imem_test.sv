module imem_test();

	//i is an iterator for which test number is currently being tested.
	logic [31:0] a, d, dexpected, i;
	logic [63:0] testvectors[18:0];
	//clock helps with automated testing, reset stops the negedge test from running
	logic clk, reset;

	//The FPGA evaluation board I will be using is the Nexys A7, which has an oboard DDR2 Memory of 128mb. This number for the depth happens to be the maximum number of 32 bit words that can fit on 128mb of memory.
	imem #(32, 33554432, 32) dut(a, d);

	//clock for testing purposes
	always begin
		clk = 1'b1;
		#5;
		clk = 1'b0;
		#5;
	end

	//read test vectors from file
	initial begin
		$readmemh("test_vectors.txt", testvectors);
		//we start by asserting reset so the posedge clk and set the first test vector before the negedge starts iterating i.
		i = 0; reset = 1;
		#22 reset = 0;
	end
	
	//apply test vectors on rising edge of clock
	always @(posedge clk)
		{ a, dexpected } <= testvectors[i];
	
	always @(negedge clk) begin
		if(!reset) begin
			if (d !== dexpected) begin
				$display("%t Error: a = %h, d = %h", $time, a, d);
				$display("%t Expected d = %h", $time, dexpected);
			end else
				$display("%t Success: a = %h, d = %h", $time, a, d);
			i = i + 1;
			//If there are no additional tests, stop the testing
			if(i > 18) begin
				$display("%t Tests completed", $time);
				$stop;
			end
		end
	end

endmodule
