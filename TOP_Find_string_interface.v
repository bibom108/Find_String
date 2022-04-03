module TOP_Find_string_interface(
	input [8:0]SW,
	input CLOCK_50,
	input [3:0]KEY,
	output [6:0]HEX0, HEX1, HEX4, HEX5, HEX6, HEX7

);

Find_string  BTL    (.in_str(SW[3:0]), 
							.in_comp(SW[7:4]), 
							.clk(CLOCK_50), 
							.done(SW[8]), 
							.delete(KEY[2]), 
							.submit(KEY[3]),
							.reset(KEY[0]), 
							.roll_back(KEY[1]), 
							.led0_1({HEX7,HEX6}), 
							.led2_3({HEX1,HEX0}), 
							.led4_5({HEX5,HEX4})
		);
endmodule