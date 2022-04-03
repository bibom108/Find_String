module XUAT_state(ready, 
						roll_back, 
						clk, 
						reset, 
						counter, 
						data_in,
						stringo, 
						in_comp, 
						scan_completed,
						hz_out,
						index_w, 
						index_r
						);

parameter FREQUENCY = 100_000_000;
parameter DIV = FREQUENCY/2;
						
						
input ready, roll_back, clk, reset;
input [7:0]counter;
input [0:39]stringo;
input [3:0]in_comp;
output reg [7:0]data_in;
output reg [5:0]index_w, index_r;

output hz_out;
wire temp_hz_out;
output reg scan_completed;
reg [7:0] scan;
integer counterr;

clock_div #(.FREQUENCY(FREQUENCY)) control_led 				(.clk(clk), 
																	.reset(reset), 
																	.hz_out(hz_out) 
																);	
//
//
//always @(negedge clk) 
//begin
//	if (~reset) 
//		begin
//		counterr <= 0;
//		end
//	else 
//	begin	
//		if (counterr > FREQUENCY - 2) 
//		begin
//			counterr <= 0;							//RESET BO DEM.
//		end	
//		else counterr <= counterr + 1'b1;
//	end
//end
//
//assign hz_out = (counterr < DIV) ? 1'b1 : 1'b0;


always @(negedge clk) begin: input_data_to_memory
	if (~ready || ~roll_back) 
	begin
		scan_completed <= 1'b0;
		scan <= 0;
		index_w <= 0;
		data_in <= 0;
	end
	else 
	begin
		if (scan > counter - 4) 
		begin
			scan_completed <= 1'b1;
			scan <= scan;
		end
		else 
		begin
				if (stringo[scan +: 4] == in_comp) 
				begin
					data_in <= scan + 1'b1;
					index_w <= index_w + 6'b1;
				end
				else 
				begin
					data_in <= data_in;
					index_w <= index_w;
				end
			scan <= scan + 1'b1;
		end
	end
end



always @(negedge hz_out, negedge reset) begin			//nen co tin hieu reset, 1 "reset_able" FF
	if (~reset) begin
		index_r <= 0;
	end
	else if (scan_completed) 
	begin
		if (index_w == 0)
		begin
			index_r <= 0;
		end
		else
		if ((index_r > index_w - 1)) 
		begin
			index_r <= 1;
		end
		else 
		begin
			index_r <= index_r + 6'd1;
		end
	end
	else 
	begin
		index_r <= 0;
	end
end

//ban dau, toi chi khai bao la :

//always @(negedge hz_out) begin
//	if (scan_complete) 
//	...... index_r = index_r + 1;
//	else index_r <= 0;

//nhung, hz_out co chu ki kha cham, con scan_complete lai co chu ki ngan hon. 
//ta can "vao luc co hz_out, va scan_complete = 0 thi index_r = 0" NHUNG, scan_complete co chu ki ngan hon
//nen len 1 nhanh hon so voi hz_out, vi vay, khi hz_out xuat hien, 
//scan_complete da~ = 1, index = index + 1, ma index luc nay chua xac dinh
//gay ra index toan xxxxx. Ghi nhu tren, voi tin hieu reset bat dong bo se an toan hon.

endmodule
