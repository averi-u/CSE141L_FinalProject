module alu (
    input logic [7:0] operand1,
    input logic [7:0] operand2,
    input logic [2:0] operation,
    output logic [7:0] result,
    output logic zero
);

always_comb begin
    case (operation)
        3'b000: result = operand1 + operand2;  // ADD
        3'b001: result = operand1 + operand2;  // ADDI
        3'b010: result = operand1 ^ operand2;  // XOR
        3'b011: result = operand1;             // LOAD (pass-through)
        3'b100: result = operand2;             // STORE (pass-through)
        3'b101: result = operand1;             // JUMP (no operation)
        3'b110: result = (operand1 == operand2) ? 8'b0 : 8'b1;  // CMP
        3'b111: result = operand1 << operand2;  // SHF
        default: result = 8'b0;
    endcase
    
    zero = (result == 8'b0);
end

endmodule
