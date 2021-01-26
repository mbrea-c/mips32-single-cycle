module counter(
	input clk,
	input rst,
	input up,
	input two,
	input enable,
	output reg [11:0] counter_r,
	output reg overflow_r
);

reg [11:0] counter_next;
reg overflow_next;

always @*
begin : next_state_PROC
case ({up, two})
	2'b00: counter_next = counter_r - 12'd1;
	2'b01: counter_next = counter_r - 12'd2;
	2'b10: counter_next = counter_r + 12'd1;
	2'b11: counter_next = counter_r + 12'd2;
endcase

overflow_next = up ? (!counter_next[11] & counter_r[11]) : (counter_next[11] & !counter_r[11]);
end

always @(posedge clk or posedge rst)
begin : register_PROC
	if (rst == 1'b1)
	begin
		counter_r <= 12'd0;
		overflow_r <= 1'b0;
	end
	else if (enable == 1'b1)
	begin
		counter_r <= counter_next;
		overflow_r <= overflow_next;
	end
end
endmodule
