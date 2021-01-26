module alu_control(
	input [1:0] alu_op,
	input [5:0] funct,
	output reg [3:0] op
);

always @*
begin
	casez ({alu_op, funct})
		8'b00_??????: op = 4'b0010; // LW or SW, add
		8'b?1_??????: op = 4'b0110; // beq, subtract
		8'b1?_??0000: op = 4'b0010; // r-type, add
		8'b1?_??0010: op = 4'b0110; // r-type, subtract
		8'b1?_??0100: op = 4'b0000; // r-type, AND
		8'b1?_??0101: op = 4'b0001; // r-type, OR
		8'b1?_??1010: op = 4'b0111; // r-type, set on less than
	endcase
end
endmodule
