module control_decoder (
    input logic [2:0] opcode,
    output logic reg_write,
    output logic alu_src,
    output logic mem_read,
    output logic mem_write,
    output logic branch
);

always_comb begin
    // Default values
    reg_write = 0;
    alu_src = 0;
    mem_read = 0;
    mem_write = 0;
    branch = 0;
    
    case (opcode)
        3'b000: reg_write = 1;  // ADD
        3'b001: reg_write = 1;  // ADDI
        3'b010: reg_write = 1;  // XOR
        3'b011: mem_read = 1;   // LOAD
        3'b100: mem_write = 1;  // STORE
        3'b101: branch = 1;     // JUMP
        3'b110: reg_write = 1;  // CMP
        3'b111: reg_write = 1;  // SHF
    endcase
end

endmodule
