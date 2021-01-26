module alu(
	input [3:0] ctrl, 
	input [31:0] a, 
	input [31:0] b, 
	output reg [31:0] out,
	output zero
);

assign zero = (out == 0);

always @*
	case (ctrl)
		0: out <= a & b;
		1: out <= a | b;
		2: out <= a + b;
		6: out <= a - b;
		7: out <= a < b ? 1 : 0;
		12: out <= ~(a | b);
		default: out <= 0;
	endcase
endmodule
