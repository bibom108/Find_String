// 50MHz = 50M circle per second, a circle last 2*10^-8 second, which 1 last half of the circle, and 0 too.
// 1Hz = 1 circle per second, 1 last 0.5s, and 0 too.
module clock_div(clk, reset, hz_out);
input clk;
input reset;
output hz_out;

parameter FREQUENCY = 100_000_000;
parameter DIV = FREQUENCY/2;

integer counter;

always @(negedge clk) 
begin
	if (~reset) 
		begin
		counter <= 0;
		end
	else 
	begin	
		if (counter > FREQUENCY - 2) 
		begin
			counter <= 0;							//RESET BO DEM.
		end	
		else counter <= counter + 1'b1;
	end
end

assign hz_out = (counter < DIV) ? 1'b1 : 1'b0;				//NEU COUNTER < DIV THI HZ_OUT = 1, CON LAI = 0.

endmodule
