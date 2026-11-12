`timescale 1ns/1ps

module controller_test();

    logic [22:0] test_vectors[20:0];
    logic [9:0] dexpected;
    logic [31:0] i;

    logic clk, reset;

    logic [6:0] op;
    logic func7,
    zero;
    logic [2:0] func3;

    logic PCSrc,
    resultSrc,
    memWrite,
    ALUSrc,
    regWrite;
    logic [1:0] immSrc;
    logic [2:0] ALUControl;

    controller dut(
        .op         (op         ),
        .func7      (func7      ),
        .zero       (zero       ),
        .func3      (func3      ),
        .PCSrc      (PCSrc      ),
        .resultSrc  (resultSrc  ),
        .memWrite   (memWrite   ),
        .ALUSrc     (ALUSrc     ),
        .regWrite   (regWrite   ),
        .immSrc     (immSrc     ),
        .ALUControl (ALUControl )
    );

    always begin
        clk = 1'b1;
        #5;
        clk = 1'b0;
        #5;
    end

    initial begin
        op = 0; func7 = 0; zero = 0; func3 = 0;
        $readmemb("controller_test_vectors.txt", test_vectors);
        reset = 1'b1; i = 0;
        #100 reset = 1'b0;
    end

    always @(posedge clk)
        if(!reset) { op, func7, zero, func3, dexpected } = test_vectors[i];
    
    always @(negedge clk) begin
        if(!reset) begin
            if ({ PCSrc, resultSrc, memWrite, ALUSrc, regWrite, immSrc, ALUControl } !== dexpected) begin
                $display("%t Error: op = %b, func7 = %b, zero = %b, func3 = %b", $time, op, func7, zero, func3);
                $display("%t Expected %b, received %b", $time, dexpected, { PCSrc, resultSrc, memWrite, ALUSrc, regWrite, immSrc, ALUControl });
            end else
                $display("%t Success: op = %b", $time, op);
            i = i + 1;
            //If there are no additional tests, stop the testing
            if(test_vectors[i] === 23'bx) begin
                $display("%t Tests completed", $time);
                $stop;
            end
        end
    end
    

endmodule