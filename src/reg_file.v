module reg_file(
	input clk,
	input ctrl_regwrite,
	input [4:0] read1_w,
	input [4:0] read2_w,
	input [4:0] write_w,
	input [31:0] write_data_w,
	output reg [31:0] reg1_r,
	output reg [31:0] reg2_r
);

reg [31:0] registers [31:0];

always @*
begin
	reg1_r = registers[read1_w];
	reg2_r = registers[read2_w];
end

always @(posedge clk)
begin
	if (ctrl_regwrite == 1'b1)
	begin
		registers[write_w] <= write_data_w;
	end
end

endmodule
