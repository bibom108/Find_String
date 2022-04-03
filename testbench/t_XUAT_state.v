module t_XUAT_state();



reg ready, roll_back, clk, reset;
reg [7:0]counter;
reg [0:39]stringo;
reg [3:0]in_comp;
wire [7:0]data_in;
wire [5:0]index_w, index_r;

wire hz_out;

wire scan_completed;



XUAT_state  yo (	.ready(ready), 
						.roll_back(roll_back), 
						.clk(clk), 
						.reset(reset), 
						.counter(counter), 
						.data_in(data_in),
						.stringo(stringo), 
						.in_comp(in_comp), 
						.scan_completed(scan_completed),
						.hz_out(hz_out),
						.index_w(index_w), 
						.index_r(index_r)
						);
						
						
initial clk = 1;
always #1 clk = ~clk;

initial begin
	ready = 0;
	roll_back = 1; 
	reset = 0;
	 #5;
	reset = 1;
	counter = 20;
	stringo[0:19] = 20'b1010_1011_0110_1111_0010;
	in_comp = 4'b1011;
	ready = 1;
	#3000;
	$stop;
end						
						
endmodule
