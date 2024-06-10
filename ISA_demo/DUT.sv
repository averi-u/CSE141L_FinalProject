module DUT (
    input clk,
    input reset
);

    wire [2:0] opcode;
    wire [7:0] operand1, operand2, aluResult;
    wire [5:0] pc, nextPC;
    wire [8:0] instruction;
    wire regWrite, memRead, memWrite, aluSrc, branch, jump;
    wire [7:0] readData, writeData;

    // Program Counter
    ProgCtr prog_ctr (
        .clk(clk),
        .reset(reset),
        .nextPC(nextPC),
        .jump(jump),
        .pc(pc)
    );

    // Instruction Memory
    InstROM inst_rom (
        .address(pc),
        .instruction(instruction)
    );

    // Control Unit
    Ctrl ctrl (
        .opcode(instruction[8:6]),
        .regWrite(regWrite),
        .memRead(memRead),
        .memWrite(memWrite),
        .aluSrc(aluSrc),
        .branch(branch),
        .jump(jump)
    );

    // Register File
    RegFile reg_file (
        .clk(clk),
        .regWrite(regWrite),
        .reg1(instruction[5:3]),
        .reg2(instruction[2:0]),
        .writeReg(instruction[5:3]),
        .writeData(aluResult),
        .reg1Data(operand1),
        .reg2Data(operand2)
    );

    // ALU
    ALU alu (
        .opcode(instruction[8:6]),
        .operand1(operand1),
        .operand2(aluSrc ? instruction[2:0] : operand2),
        .imm(instruction[2:0]),
        .result(aluResult),
        .zero()
    );

    // Data Memory
    DMem data_mem (
        .clk(clk),
        .memRead(memRead),
        .memWrite(memWrite),
        .address(aluResult),
        .writeData(operand2),
        .readData(readData)
    );

    assign nextPC = jump ? instruction[5:0] : (pc + 1);

    // Logic to set done signal (customize this as per your design needs)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
        end else if (/* some condition indicating program end */) begin
            done <= 1;
        end
    end

endmodule
