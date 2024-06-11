module Ctrl(
    input        [8:0] mach_code,
    output logic [2:0] Aluop, // Expanded to 3 bits
                       Jptr,
    output logic [2:0] Ra,
                       Rb,
                       Wd,
    output logic       WenR,
                       WenD,
                       Ldr,
                       Str
);

always_comb begin
    // Default signal assignments to handle unused signals in some instructions
    Ra    = mach_code[6:4];
    Rb    = mach_code[3:1];
    Wd    = mach_code[6:4];
    WenR  = 0;
    WenD  = 0;
    Ldr   = 0;
    Str   = 0;
    Jptr  = 0;
    Aluop = mach_code[8:6]; // Updated to use 3 bits for Aluop

    case (mach_code[8:6])
        3'b000: begin // AND
            WenR = 1;
        end
        3'b010: begin // XOR
            WenR = 1;
        end
        3'b110: begin // SUB
            WenR = 1;
        end
        3'b001: begin // ADD IMMEDIATE
            Rb = 3'b000; // Use immediate value
            WenR = 1;
        end
        3'b011: begin // LOAD
            Ldr  = 1;
            Rb   = 3'b000; // Use immediate value for address
            WenR = 1;
        end
        3'b100: begin // STORE
            Str  = 1;
            Rb   = 3'b000; // Use immediate value for address
        end
        3'b101: begin // JUMP
            Jptr = mach_code[5:4];
        end
        3'b111: begin // SHIFT
            Rb   = 3'b000; // Shift operation might use an immediate value
            WenR = 1;
        end
        default: begin
            // Default case to handle unexpected opcodes
            WenR = 0;
            WenD = 0;
            Ldr  = 0;
            Str  = 0;
            Jptr = 0;
            Aluop = 3'b000;
        end
    endcase
end
endmodule


/*module Ctrl(
  input        [8:0] mach_code,
  output logic [1:0] Aluop,
                     Jptr,
  output logic [1:0] Ra,
			         Rb,
			         Wd,
  output logic       WenR,
					 WenD,
					 Ldr,
					 Str
);

  always_comb begin
	Aluop = mach_code[1:0];		// ALU
	Jptr  = mach_code[3:2];		// jump pointer
	Ra	  = mach_code[5:4];		// reg file addr A
	Rb    = 2'b0;		    
	Wd    = mach_code[5:4];
	WenR  = mach_code[6];		// reg file write enable
	WenD  = !mach_code[6];		// data mem write enable
	Ldr   =	mach_code[7];		// load
    Str	  = !mach_code[6];		// store
//    case(mach_code)

//	endcase
  end

endmodule*/

