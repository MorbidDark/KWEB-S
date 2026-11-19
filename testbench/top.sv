`timescale 1ns / 1ps

module top ();

  logic clk, reset;

  logic memWrite;

  logic [31:0] readData, memAddress, memData, pc, instr;

  KWEB_S u_KWEB_S (
      .clk       (clk),
      .reset     (reset),
      .readData  (readData),
      .instr     (instr),
      .memWrite  (memWrite),
      .memAddress(memAddress),
      .memData   (memData),
      .pc        (pc)
  );

  imem instr_mem (
      .a (pc),
      .rd(instr)
  );

  dmem data_mem (
      .a  (memAddress),
      .we (memWrite),
      .clk(clk),
      .wd (memData),
      .rd (readData)
  );

  always begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
  end

  initial begin
    reset = 1'b1;
    #22 reset = 1'b0;
    #300
    if (data_mem.mem[100] === 25) $display($time, " Simulation Succeeded!");
    else begin
      $display($time, " Simulation failed! Expected 25, read %d", data_mem.mem[100]);
    end
    $stop;
  end

  always_ff @(negedge clk) begin
    if (instr !== 32'bx) begin  
        $display("\n%0t pc = %h, instr loaded: %h", $time, pc, instr);
        if(memWrite) begin
            $display ($time, " memAddress = %h, memdata = %d", memAddress, memData);
            $display ($time, " ALUSrc A = %h, ALUSrc B = %h", u_KWEB_S.dp.rfd1, u_KWEB_S.dp.ALUSrcB);
        end
        if(u_KWEB_S.regWrite)
            $display ($time, " reg = 0x%d, value = %d", instr[11:7], u_KWEB_S.dp.result);
    end
  end

endmodule
