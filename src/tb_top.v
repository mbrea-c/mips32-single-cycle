module tb_top;

reg [31:0] a;
reg [31:0] b;
reg [3:0] ctrl;
wire [31:0] aluout;
wire aluzero;

reg [4:0] read1;
reg [4:0] read2;
reg [4:0] write;
reg [31:0] write_data;
reg clk;
reg ctrl_regwrite;
wire [31:0] reg1;
wire [31:0] reg2;

// memory stuff
wire [31:0] mem_read_data;
reg [31:0] mem_write_data;
reg [31:0] mem_addr;
reg ctrl_mem_read;
reg ctrl_mem_write;

memory mem(
	.read_data (mem_read_data),
	.write_data (mem_write_data),
	.addr (mem_addr),
	.ctrl_mem_write (ctrl_mem_write),
	.ctrl_mem_read (ctrl_mem_read),
	.clk (clk)
);

alu mipsalu(
	.a (a),
	.b (b),
	.ctrl (ctrl),
	.out (aluout),
	.zero (aluzero)
);

reg_file regs(
	.read1_w (read1),
	.read2_w (read2),
	.write_w (write),
	.write_data_w (write_data),
	.clk (clk),
	.ctrl_regwrite (ctrl_regwrite),
	.reg1_r (reg1),
	.reg2_r (reg2)
);

// Test
initial
begin
	clk = 1'b0;
	ctrl_mem_read = 1'b1;
	ctrl_mem_write = 1'b0;
	a = 32'd29;
	b = 32'd7;
	ctrl = 4'd2;
	$display("step1");

	#10 b = 32'd11;

	#100 ctrl_regwrite = 1'b1;
	#100 read1 = 4'd2;
	#100 read2 = 4'd3;
	#100 write = 4'd2;
	#100 write_data = 32'd15;
	#500 ctrl_regwrite = 1'b0;
	#100 write = 4'd3;
	#100 write_data = 32'd10;
	#100 ctrl_regwrite = 1'b1;
	$display("step2");

	mem_write_data = 32'd1337;
	mem_addr = 32'd4 * 5;
	{ctrl_mem_read, ctrl_mem_write} = 2'b01;
	$display("step3");
	#100 {ctrl_mem_read, ctrl_mem_write} = 2'b10;

	#800 $finish;
end

// Monitoring
initial 
begin
	//$monitor("ALU: a:%d b:%d out:%d", a, b, aluout);
	//$monitor("REG: read1: %d read2: %d write: %d data: %d regwrite: %b, r1:%d r2:%d", read1, read2, write, write_data, ctrl_regwrite, reg1, reg2);
	$monitor("MEMORY: read_data: %d", mem_read_data);
end

always #10
	clk = ~clk;

endmodule
