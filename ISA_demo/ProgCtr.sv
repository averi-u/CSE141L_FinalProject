module ProgCtr (
    input clk,
    input reset,
    input [5:0] nextPC,
    input jump,
    output reg [5:0] pc
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 0;
        end else if (jump) begin
            pc <= nextPC;
        end else begin
            pc <= pc + 1;
        end
    end
endmodule


// module ProgCtr(
//   input             Clk,
//                     Reset,
// 					Jen,
//   input       [5:0] Jump,
//   output logic[5:0] PC);

//   always_ff @(posedge Clk)
//     if(Reset) PC <= 'b0;
// 	else if(Jen) PC <= Jump;
// 	else      PC <= PC + 6'd1;

// endmodule