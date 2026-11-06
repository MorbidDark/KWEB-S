module mux_test();
	logic [31:0] d0, d1, d2, y, y0;
	logic s;
	logic [1:0] s0;

	mux_2 #(32) mux2(d0, d1, s, y);
	mux_3 #(32) mux3(d0, d1, d2, s0, y0);

	initial begin
		d0 = 32'd69; d1 = 32'd6969; d2 = 32'd696969;
		s = 1'b0;
		$display("%t d0 = %b, d1 = %b, d2 = %b", $time, d0, d1, d2);
		#10 $display("%t s = %b, y = %b", $time, s, y);
		s = 1'b1;
		#10 $display ("%t s = %b, y = %b", $time, s, y);
		s0 = 2'b00;
		#10 $display ("%t, s0 = %b, y0 = %b", $time, s0, y0);
		s0 = 2'b01;	
		#10 $display ("%t, s0 = %b, y0 = %b", $time, s0, y0);
		s0 = 2'b10;
		#10 $display ("%t, s0 = %b, y0 = %b", $time, s0, y0);
		s0 = 2'b11;
		#10 $display ("%t, s0 = %b, y0 = %b", $time, s0, y0);
	end

endmodule
