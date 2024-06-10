module fetch_unit (
    input logic clk,
    input logic rst,
    input logic start,
    input logic [7:0] start_address,
    input logic branch,
    input logic [7:0] branch_address,
    output logic [7:0] pc,
    output logic [8:0] instruction
);

logic [9:0] instruction_memory [1023:0]; // 1024 entries, each 9 bits wide

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        pc <= start_address;
    end else if (branch) begin
        pc <= branch_address;
    end else begin
        pc <= pc + 1;
    end
end

assign instruction = instruction_memory[pc];

endmodule
