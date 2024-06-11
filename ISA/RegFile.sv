module RegFile(
  input      Clk,    // clock
             Wen,    // write enable
  input[2:0] Ra,     // read address pointer A (3 bits)
             Rb,     // read address pointer B (3 bits)
             Wd,     // write address pointer (3 bits)
  input[7:0] Wdat,   // write data in
  output[7:0] RdatA, // read data out A
             RdatB   // read data out B
);

  logic[7:0] Core[8]; // reg file itself (8*8 array)

  always_ff @(posedge Clk) begin
    if(Wen) begin
      Core[Wd] <= Wdat;
      $display("Time: %0t | Write to Register: %0d | Data: %0d", $time, Wd, Wdat);
    end
  end

  assign RdatA = Core[Ra];
  assign RdatB = Core[Rb];

  // Debug: Monitor read signals
  always_ff @(posedge Clk) begin
    $display("Time: %0t | Read Register A: %0d | Data: %0d", $time, Ra, RdatA);
    $display("Time: %0t | Read Register B: %0d | Data: %0d", $time, Rb, RdatB);
  end

endmodule
