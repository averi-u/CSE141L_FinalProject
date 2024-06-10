//insns memory
module InstROM (
    input [5:0] address,
    output reg [8:0] instruction
);

    reg [8:0] memory [0:63]; 

    initial begin
        $readmemb("mach_code.txt", memory);
    end

    always @(*) begin
        instruction <= memory[address];
    end
endmodule



// module InstROM(
//   input[5:0] PC,
//   output logic[8:0] mach_code);

//   logic[8:0] Core[64];

//   initial 
// 	$readmemb("mach_code.txt",Core);

//   always_comb mach_code = Core[PC];

// endmodule