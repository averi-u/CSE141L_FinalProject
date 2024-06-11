module JLUT(
  input [2:0] Jptr,
  output logic [5:0] Jump
);

always_comb begin
  case(Jptr)
    3'b000: Jump = 6'd5; 
    3'b001: Jump = 6'd3;
    3'b010: Jump = 6'd6;
    3'b011: Jump = 6'd8;
    // Add more cases if necessary based on your instruction set requirements
    default: Jump = 6'd0; // Default case
  endcase
end

endmodule