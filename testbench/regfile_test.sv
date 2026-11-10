module regfile_test ();

	logic we3, clk;
	logic [4:0] a1, a2, a3;
	logic [31:0] wd3, rd1, rd2;

	regfile_32 dut(clk, we3, a1, a2, a3, wd3, rd1, rd2);

	always begin
		clk = 1'b0;
		#5;
		clk = 1'b1;
		#5;
	end

	initial begin
		we3 = 1'b0; wd3 = 32'h0;
		a1 = 5'b0; a2 = 5'b0; a3 = 5'b0;
		#20 $display ($time, " a1 = %b, a2 = %b, a3 = %b, wd3 = %h --- rd1 = %h, rd2 = %h", a1, a2, a3, wd3, rd1, rd2);	
		we3 = 1'b1; wd3 = 32'h69;
		a1 = 5'b0; a2 = 5'b0; a3 = 5'b0;
		#20 $display ($time, " a1 = %b, a2 = %b, a3 = %b, wd3 = %h --- rd1 = %h, rd2 = %h", a1, a2, a3, wd3, rd1, rd2);
		we3 = 1'b1; wd3 = 32'h6969;
		a1 = 5'b0; a2 = 5'b0; a3 = 5'b1;
		#20 $display ($time, " a1 = %b, a2 = %b, a3 = %b, wd3 = %h --- rd1 = %h, rd2 = %h", a1, a2, a3, wd3, rd1, rd2);
		we3 = 1'b1; wd3 = 32'h696969;
		a1 = 5'b0; a2 = 5'b0; a3 = 5'b10;
		#20 $display ($time, " a1 = %b, a2 = %b, a3 = %b, wd3 = %h --- rd1 = %h, rd2 = %h", a1, a2, a3, wd3, rd1, rd2);
		we3 = 1'b0; wd3 = 32'h0;
		a1 = 5'b0; a2 = 5'b1; a3 = 5'b0;
		#20 $display ($time, " a1 = %b, a2 = %b, a3 = %b, wd3 = %h --- rd1 = %h, rd2 = %h", a1, a2, a3, wd3, rd1, rd2);
		we3 = 1'b0; wd3 = 32'h0;
		a1 = 5'b1; a2 = 5'b10; a3 = 5'b0;
		#20 $display ($time, " a1 = %b, a2 = %b, a3 = %b, wd3 = %h --- rd1 = %h, rd2 = %h", a1, a2, a3, wd3, rd1, rd2);
		we3 = 1'b1; wd3 = 32'hffffffff;
		a1 = 5'b11111; a2 = 5'b0; a3 = 5'b11111;
		#20 $display ($time, " a1 = %b, a2 = %b, a3 = %b, wd3 = %h --- rd1 = %h, rd2 = %h", a1, a2, a3, wd3, rd1, rd2);
		$stop;
	end


endmodule
