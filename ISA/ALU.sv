module ALU(
    input [2:0] Aluop,      // Expanded to 3 bits to match ISA opcode directly
    input [7:0] DatA,       // Data from register A or immediate value
    input [7:0] DatB,       // Data from register B or immediate value
    output logic [7:0] Rslt, // Result of the ALU operation
    output logic Zero,       // Zero flag
    output logic Par,        // Parity flag
    output logic SCo         // Status Carry Out flag
);

always_comb begin
    SCo = 1'b0;   // Default no carry or overflow
    Rslt = 8'b0;  // Default result

    case (Aluop)
        3'b000: // AND operation
            Rslt = DatA & DatB;

        3'b001: // ADD IMMEDIATE operation (assuming immediate value is part of DatB)
            {SCo, Rslt} = DatA + DatB;

        3'b010: // XOR operation
            Rslt = DatA ^ DatB;

        3'b011: // LOAD operation, placeholder as this typically wouldn't be handled by ALU
            Rslt = DatA;  // Normally, memory handling is outside ALU

        3'b100: // STORE operation, placeholder
            Rslt = DatB;  // Normally, memory handling is outside ALU

        3'b101: // JMP operation, placeholder for simulation
            Rslt = DatB;  // JMP handling typically done by control unit

        3'b110: // SUBTRACT operation
            {SCo, Rslt} = DatA - DatB;

        3'b111: // SHIFT operation (left or right based on additional flags in DatB)
            Rslt = (DatB[0] == 1) ? (DatA >> DatB[1:0]) : (DatA << DatB[1:0]);

        default:
            Rslt = 8'b0; // Default case if an undefined opcode is encountered
    endcase

    // Set the Zero and Parity flags
    Zero = (Rslt == 0);
    Par = ^Rslt; // Parity flag: XOR of all bits in Rslt
end

endmodule


/*module ALU(
  input [1:0] Aluop,
  input [7:0] DatA,
              DatB,
  output logic[7:0] Rslt,
  output logic      Zero,
                    Par,
			        SCo);

always_comb begin
  Rslt = 8'b0;
  SCo  = 8'b0;
  case(Aluop)
    2'b00: {SCo,Rslt} = DatA + DatB;   // add
    2'b01: {SCo,Rslt} = DatA<<1'b1;    // left shift
	2'b10: Rslt       = DatA & DatB;   // bitwise AND
	2'b11: Rslt       = DatA ^ DatB;   // bitwise XOR
  endcase
end

  assign Zero = !Rslt;
  assign Par  = ^Rslt;

endmodule*/