module RegFile (
    input clk,
    input regWrite,
    input [2:0] reg1,
    input [2:0] reg2,
    input [2:0] writeReg,
    input [7:0] writeData,
    output [7:0] reg1Data,
    output [7:0] reg2Data
);

    reg [7:0] registers [0:7]; // 8 registers

    assign reg1Data = registers[reg1];
    assign reg2Data = registers[reg2];

    always @(posedge clk) begin
        if (regWrite) begin
            registers[writeReg] <= writeData;
        end
    end
endmodule


// module RegFile(
//   input      Clk,	 // clock
//              Wen,    // write enable
//   input[1:0] Ra,     // read address pointer A
//              Rb,     //                      B
// 			 Wd,	 // write address pointer
//   input[7:0] Wdat,   // write data in
//   output[7:0]RdatA,	 // read data out A
//              RdatB); // read data out B

//   logic[7:0] Core[4]; // reg file itself (4*8 array)

//   always_ff @(posedge Clk)
//     if(Wen) Core[Wd] <= Wdat;

//   assign RdatA = Core[Ra];
//   assign RdatB = Core[Rb];

// endmodule