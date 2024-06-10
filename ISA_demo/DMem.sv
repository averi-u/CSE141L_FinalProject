module DMem (
    input clk,
    input memRead,
    input memWrite,
    input [7:0] address,
    input [7:0] writeData,
    output reg [7:0] readData
);

reg [7:0] memory [0:255]; // 256 x 8-bit memory

always @(posedge clk) begin
    if (memWrite) begin
        memory[address] <= writeData;
    end
    if (memRead) begin
        readData <= memory[address];
    end
end
endmodule



// module DMem(
//   input Clk,
//         Wen,
//   input[7:0] WDat,
//              Addr,
//   output logic[7:0] Rdat);

//   logic[7:0] Core[256];

//   always_ff @(posedge Clk)
//     if(Wen) Core[Addr] <= WDat;

//   assign Rdat = Core[Addr];

// endmodule





