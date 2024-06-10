module JLUT (
    input [5:0] address,
    output reg [5:0] jumpAddress
);

    reg [5:0] jumpTable [0:63]; // 64 x 6-bit jump address table

    initial begin
        // Initialize the jump table
        $readmemb("jump_table.txt", jumpTable);
    end

    always @(*) begin
        jumpAddress <= jumpTable[address];
    end
endmodule


// module JLUT(
//   input[1:0] Jptr,
//   output logic[5:0] Jump);

//   always_comb case(Jptr)
// 	0: Jump = 5; 
// 	1: Jump = 3;
// 	2: Jump = 6;
// 	3: Jump = 8;
//   endcase

// endmodule