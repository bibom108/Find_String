module t_Memory ();
		

parameter DEPTH = 64;
parameter LENGTH = 8;

reg	[LENGTH-1:0]datain;

reg clk;
reg [6-1:0]write_addr;
wire [LENGTH-1:0]dataout;

reg [6-1:0] read_addr;



Memory_with_read_addr #(.DEPTH(DEPTH), .LENGTH(LENGTH))yey (.datain(datain),
																				.write_addr(write_addr),
																				.read_addr(read_addr),
																				.dataout(dataout),
																				.clk(clk));	
									
									
initial clk = 1;
always #1 clk = ~clk;

initial begin
	read_addr = 0;
	write_addr = 0;
	datain = 2;
	#5;
	write_addr = 1;
	datain = 3;
	#5;
	write_addr = 2;
	datain = 4;
	#5;
	write_addr = 3;
	datain = 8;
	#5;
	write_addr = 4;
	datain = 23;
	#5;
	write_addr = 5;
	datain = 10;
	#5;
	write_addr = 6;
	datain = 11;
	#5;
	write_addr = 7;
	datain = 12;
	#5;
	write_addr = 8;
	datain = 24;
	#5;
	read_addr = 1;
	#5;
	read_addr = 2;
	#5;
	read_addr = 3;
	#5;
	read_addr = 4;
	#5;
	read_addr = 5;
	#5;
	read_addr = 6;
	#5;
	read_addr = 7;
	#5;
	read_addr = 8;
	#5;
	$stop;
	
end

endmodule
