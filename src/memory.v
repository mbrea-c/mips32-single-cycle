module memory(
	input [31:0] addr,
	input [31:0] write_data,
	input ctrl_mem_write,
	input ctrl_mem_read,
	input clk,
	output reg [31:0] read_data
);

reg [31:0] memory_array [1023:0];

always @*
begin
	$display("READ: attempted [rw %b]", {ctrl_mem_read, ctrl_mem_write});
	case ({ctrl_mem_read, ctrl_mem_write})
		2'b10: read_data = memory_array[addr];
		default:;
	endcase
end

always @(posedge clk)
begin
	$display("WRITE: attempted [rw %b]", {ctrl_mem_read, ctrl_mem_write});
	case ({ctrl_mem_read, ctrl_mem_write})
		2'b01: memory_array[addr] = write_data;
		default: ;
	endcase
end
endmodule
