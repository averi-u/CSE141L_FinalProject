//control unit to interpret insns and generate signals
module Ctrl (
    input [2:0] opcode,
    output reg regWrite,
    output reg memRead,
    output reg memWrite,
    output reg aluSrc,
    output reg branch,
    output reg jump
);

always @(*) begin
	// Default values
	regWrite = 0;
	memRead = 0;
	memWrite = 0;
	aluSrc = 0;
	branch = 0;
	jump = 0;

	case (opcode)
		3'b000: regWrite = 1; // AND
		3'b001: regWrite = 1; // ADDI
		3'b010: regWrite = 1; // XOR
		3'b011: begin          // LOAD
			memRead = 1;
			regWrite = 1;
		end
		3'b100: memWrite = 1;  // STORE
		3'b101: jump = 1;      // JUMP
		3'b110: regWrite = 1;  // SUB
		3'b111: regWrite = 1;  // SHF
	endcase
end
endmodule



// module Ctrl(
//   input        [8:0] mach_code,
//   output logic [1:0] Aluop,
//                      Jptr,
//   output logic [1:0] Ra,
// 			         Rb,
// 			         Wd,
//   output logic       WenR,
// 					 WenD,
// 					 Ldr,
// 					 Str
// );

//   always_comb begin
// 	Aluop = mach_code[1:0];		// ALU
// 	Jptr  = mach_code[3:2];		// jump pointer
// 	Ra	  = mach_code[5:4];		// reg file addr A
// 	Rb    = 2'b0;		    
// 	Wd    = mach_code[5:4];
// 	WenR  = mach_code[6];		// reg file write enable
// 	WenD  = !mach_code[6];		// data mem write enable
// 	Ldr   =	mach_code[7];		// load
//     Str	  = !mach_code[6];		// store
// //    case(mach_code)

// //	endcase
//   end

// endmodule