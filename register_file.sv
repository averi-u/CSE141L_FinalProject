module register_file (
    input logic clk,
    input logic rst,
    input logic write_enable,
    input logic [2:0] read_addr1,
    input logic [2:0] read_addr2,
    input logic [2:0] write_addr,
    input logic [7:0] write_data,
    output logic [7:0] read_data1,
    output logic [7:0] read_data2
);

logic [7:0] registers [7:0]; // 8 registers, each 8 bits wide

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        for (int i = 0; i < 8; i++) begin
            registers[i] <= 8'b0;
        end
    end else if (write_enable) begin
        registers[write_addr] <= write_data;
    end
end

assign read_data1 = registers[read_addr1];
assign read_data2 = registers[read_addr2];

endmodule
