module lut (
    input logic [4:0] address,
    output logic [7:0] data
);

logic [7:0] lut [31:0]; // 32 entries, each 8 bits wide

assign data = lut[address];

endmodule
