module Binary_to_2_led(Binary,clk,real_led);

parameter Binary_length = 8;
parameter BCD_number = 2;

parameter COMMON_CATHODE = 1'b1;
parameter COMMON_ANODE = 1'b0;
parameter CC_CA = COMMON_ANODE;





input [Binary_length-1:0]Binary;
wire [BCD_number*4-1:0]BCD;

input clk;

wire[BCD_number*7-1:0]led;

output reg [BCD_number*7-1:0]real_led;


Binary_to_BCD_2 #(.Binary_length(Binary_length),.BCD_number(BCD_number)) only4bitbinary (.Binary(Binary), 
																														.BCD(BCD));



seven_segment_simple	#(COMMON_ANODE)	only2led	[BCD_number-1:0](.BCD(BCD), 
																						.clk(clk), 
																						.led(led));
	

always @(*)					//xu ly leading zero bang mach to hop
begin: no_leading_zero
	if (Binary < 10) begin
	real_led[13:7] = {7{1'b1}};
	real_led[6:0] = led[6:0];
	end
	else real_led = led;
end
endmodule
