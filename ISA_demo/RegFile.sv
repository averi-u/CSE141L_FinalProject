module RegFile (
    input logic clk,
    input logic regWrite,
    input logic [2:0] reg1,
    input logic [2:0] reg2,
    input logic [2:0] writeReg,
    input logic [7:0] writeData,
    output logic [7:0] reg1Data,
    output logic [7:0] reg2Data
);

    // Initialize registers
    logic [7:0] registers [0:7] = '{8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0};

    // Assign outputs from registers
    always_comb begin
        reg1Data = registers[reg1];
        reg2Data = registers[reg2];
    end

    always_ff @(posedge clk) begin
        if (regWrite) begin
            registers[writeReg] <= writeData;
            $display("Time: %0t | Writing %0h to register %0d", $time, writeData, writeReg);
        end
    end

    // Debug: Monitor register reads
    always @(reg1 or reg2) begin
        $display("Time: %0t | Reading reg1: %0d (%0h), reg2: %0d (%0h)", $time, reg1, registers[reg1], reg2, registers[reg2]);
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