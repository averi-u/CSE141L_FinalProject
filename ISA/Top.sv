module Top(
  input        Clk,
               Reset,
  output logic Done
);

  wire [5:0] Jump,
             PC;
  wire [2:0] Aluop, // 3 bits
             Ra,    // 3 bits
             Rb,    // 3 bits
             Wd,    // 3 bits
             Jptr;  // 3 bits
  wire [8:0] mach_code;
  wire [7:0] DatA,     // ALU data in
             DatB,
             Rslt,     // ALU data out
             RdatA,    // RF data out
             RdatB,
             WdatR,    // RF data in
             WdatD,    // DM data in
             Rdat,     // DM data out
             Addr;     // DM address
  wire       Jen,      // PC jump enable
             Par,      // ALU parity flag
             SCo,      // ALU shift/carry out
             Zero,     // ALU zero flag
             WenR,     // RF write enable
             WenD,     // DM write enable
             Ldr,      // LOAD
             Str;      // STORE

  assign DatA = RdatA;
  assign DatB = RdatB; 
  assign WdatR = Rslt; 

  // Instantiate JLUT
  JLUT JL1(
    .Jptr(Jptr),
    .Jump(Jump)
  );

  // Instantiate Program Counter
  ProgCtr PC1(
    .Clk(Clk),
    .Reset(Reset),
    .Jen(Jen),
    .Jump(Jump),
    .PC(PC)
  );

  // Instantiate Instruction ROM
  InstROM IR1(
    .PC(PC),
    .mach_code(mach_code)
  );

  // Instantiate Control Unit
  Ctrl C1(
    .mach_code(mach_code),
    .Aluop(Aluop),
    .Jptr(Jptr),
    .Ra(Ra),
    .Rb(Rb),
    .Wd(Wd),
    .WenR(WenR),
    .WenD(WenD),
    .Ldr(Ldr),
    .Str(Str)
  );

  // Instantiate Register File
  RegFile RF1(
    .Clk(Clk),
    .Wen(WenR),
    .Ra(Ra),
    .Rb(Rb),
    .Wd(Wd),
    .Wdat(WdatR),
    .RdatA(RdatA),
    .RdatB(RdatB)
  );

  // Instantiate ALU
  ALU A1(
    .Aluop(Aluop),
    .DatA(DatA),
    .DatB(DatB),
    .Rslt(Rslt),
    .Zero(Zero),
    .Par(Par),
    .SCo(SCo)
  );

  // Instantiate Data Memory
  DMem DM1(
    .Clk(Clk),
    .Wen(WenD),
    .WDat(WdatD),
    .Addr(Addr),
    .Rdat(Rdat)
  );


endmodule
