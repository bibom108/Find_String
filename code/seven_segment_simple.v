module seven_segment_simple(BCD, clk, led);
input [3:0]BCD;
input clk;

output reg[6:0]led;



//CC - common cathode (1 to shine)
//CA - common anode	 (0 to shine) 
parameter COMMON_CATHODE = 1'b1;
parameter COMMON_ANODE = 1'b0;
parameter CC_CA = COMMON_ANODE;

parameter ZERO = {~CC_CA,CC_CA,CC_CA,CC_CA,CC_CA,CC_CA,CC_CA};
parameter ONE = {~CC_CA,~CC_CA,~CC_CA,~CC_CA,CC_CA,CC_CA,~CC_CA};
parameter TWO = {CC_CA,~CC_CA,CC_CA,CC_CA,~CC_CA,CC_CA,CC_CA};
parameter THREE = {CC_CA,~CC_CA,~CC_CA,CC_CA,CC_CA,CC_CA,CC_CA};
parameter FOUR = {CC_CA,CC_CA,~CC_CA,~CC_CA,CC_CA,CC_CA,~CC_CA};
parameter FIVE = {CC_CA,CC_CA,~CC_CA,CC_CA,CC_CA,~CC_CA,CC_CA};
parameter SIX = {CC_CA,CC_CA,CC_CA,CC_CA,CC_CA,~CC_CA,CC_CA};
parameter SEVEN = {~CC_CA,~CC_CA,~CC_CA,~CC_CA,CC_CA,CC_CA,CC_CA};
parameter EIGHT = {CC_CA,CC_CA,CC_CA,CC_CA,CC_CA,CC_CA,CC_CA};
parameter NINE = {CC_CA,CC_CA,~CC_CA,CC_CA,CC_CA,CC_CA,CC_CA};
parameter NONE = {~CC_CA,~CC_CA,~CC_CA,~CC_CA,~CC_CA,~CC_CA,~CC_CA};


always @(negedge clk) begin: BCD_to_led
			case (BCD)
						4'd0: led <= ZERO;
						4'd1: led <= ONE;
						4'd2: led <= TWO;
						4'd3: led <= THREE;
						4'd4: led <= FOUR;
						4'd5: led <= FIVE;
						4'd6: led <= SIX;
						4'd7: led <= SEVEN;
						4'd8: led <= EIGHT;
						4'd9: led <= NINE;
						default led <= NONE;
			endcase 
end
			
		
	




endmodule
