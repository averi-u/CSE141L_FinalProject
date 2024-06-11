`timescale 1ns/1ps

module Top_tb;

  bit clk, reset;
  wire done;
  parameter D = 6, A = 2;

  Top t1(
    .Clk  (clk),
    .Reset(reset),
    .Done (done)
  );

  always begin
    #5 clk = 1;
    #5 clk = 0;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, t1); // Dump all signals of Top module
    // Initialize all 8 registers
    for (int i = 0; i < 8; i++)
      t1.RF1.Core[i] = i;
    reset = 0;
    #10 reset = 1;
    #10 reset = 0;
    #2000 $stop;
  end

endmodule
