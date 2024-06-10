module ALU (
    input [2:0] opcode,       // 3-bit opcode
    input [7:0] operand1,     // 8-bit operand 1
    input [7:0] operand2,     // 8-bit operand 2
    input [2:0] imm,          // 3-bit immediate value
    output reg [7:0] result,  // 8-bit result
    output reg zero           // Zero flag for comparison
);

    // Opcodes
    localparam AND_OP = 3'b000;
    localparam ADD_OP = 3'b001;
    localparam XOR_OP = 3'b010;
    localparam SUB_OP = 3'b110;
    localparam SHF_OP = 3'b111;

    always @(*) begin
        case (opcode)
            AND_OP: begin
                result = operand1 & operand2;
                zero = (result == 8'b0);
            end
            ADD_OP: begin
                result = operand1 + imm;
                zero = (result == 8'b0);
            end
            XOR_OP: begin
                result = operand1 ^ operand2;
                zero = (result == 8'b0);
            end
            SUB_OP: begin
                result = operand1 - operand2;
                zero = (result == 8'b0);
            end
            SHF_OP: begin
                if (imm[2]) // If imm[2] is 1, shift right
                    result = operand1 >> imm[1:0];
                else        // Else, shift left
                    result = operand1 << imm[1:0];
                zero = (result == 8'b0);
            end
            default: begin
                result = 8'b0;
                zero = 1'b1;
            end
        endcase
    end
endmodule


// module ALU(
//   input [1:0] Aluop,
//   input [7:0] DatA,
//               DatB,
//   output logic[7:0] Rslt,
//   output logic      Zero,
//                     Par,
// 			        SCo);

// always_comb begin
//   Rslt = 8'b0;
//   SCo  = 8'b0;
//   case(Aluop)
//     2'b00: {SCo,Rslt} = DatA + DatB;   // add
//     2'b01: {SCo,Rslt} = DatA<<1'b1;    // left shift
// 	2'b10: Rslt       = DatA & DatB;   // bitwise AND
// 	2'b11: Rslt       = DatA ^ DatB;   // bitwise XOR
//   endcase
// end

//   assign Zero = !Rslt;
//   assign Par  = ^Rslt;

// endmodule