module Find_string(in_str, 
							in_comp, 
							clk, 
							done, 
							delete, 
							submit,
							reset, 
							roll_back, 
							led0_1, 
							led2_3, 
							led4_5
		);

parameter NHAP = 3'b001,
			 XOA = 3'b010,
			 XUAT = 3'b100;
			 
parameter FREQUENCY = 100_000_000;

input [3:0]in_str, in_comp;
input clk;
input done, delete; 
input submit,reset;
input roll_back;

output [13:0]led0_1;
output reg [13:0]led2_3;
output [13:0]led4_5;

wire [13:0]led02_03;
reg [0:39]stringo;
reg ready;

reg [7:0] counter, temp_counter;//, scan;
reg [2:0] current_state, next_state;
wire [7:0]location_NHAP;
wire scan_completed;
wire hz_out;
wire [7:0]Binary;

wire [7:0]data_in;
wire [7:0]data_out;
wire [5:0]index_w, index_r;


//------------------------------KHOI CHUYEN TRANG THAI--------------------------------------
always @(negedge clk) begin
	if (~reset) 
	begin
	current_state <= NHAP;
	end
	else current_state <= next_state;
end

always @(*) begin
	next_state = NHAP;
	case (current_state)
	NHAP:				begin
							if (~delete) next_state = XOA;
							else if (done || counter > 39) next_state = XUAT;
							else next_state = NHAP;
						end
						
	XOA:				begin
							if (delete) next_state = NHAP;
							else next_state = XOA;
						end
						
	XUAT:				begin
							next_state = XUAT;
						end
	default: next_state = NHAP;
	endcase
end
//------------------------------KHOI DIEU KHIEN COUNTER--------------------------------------------------------
always @(negedge clk) begin: control_counter
	if (~reset) 
	begin
		counter <= 8'b0;
	end
	else 
	begin
		case (current_state)
		NHAP:				begin
								if (~submit) begin
									//counter <= counter + 4;
									temp_counter <= counter;
								end
								else 													//trang thai se chuyen sang XOA, vi the
								begin														//temp_counter chi bi tru dung 1 lan
									if (counter == temp_counter) begin
										counter <= temp_counter + 3'b100;
									end
									else counter <= counter;	
								end
								
								
							end
							
							
		XOA:				begin
								//temp_counter = counter;
								if (~delete) 
								begin
									if (counter == temp_counter + 3'b100)
									begin
										counter <= counter - 3'b100;
										temp_counter <= temp_counter - 1'b1;
									end
									else 
									begin
										counter <= counter;
										temp_counter <= temp_counter;
									end
								end
								else 
								begin
									counter <= counter;
								end
							end
								
							
							
		default: counter <= counter;
		endcase
	end
end

//-----------------------------------KHOI DIEU KHIEN CHUOI LON (STRINGO)-----------------------------------------------
always @(negedge clk) begin: control_stringo

	case (current_state)
	NHAP:				begin
							if (~delete) 
								begin
									stringo[counter-1 -: 4] <= 4'b0000;
								end
							else if (~submit) 
								begin
									stringo[counter +: 4] <= in_str;	
								end
							else 
								begin
									stringo <= stringo;
								end
								
						end
						
	default: stringo <= stringo;
	endcase
end

//------------------------------KHOI XAC NHAN TRANG THAI CUOI CUNG VA XU LY----------------------------------------------
always @(*) begin: control_final_state
	ready = 1'b0;
	case (current_state)
	XUAT:				begin
							ready = 1'b1;	
						end
						
	default: ready = 1'b0;
	endcase
end

assign Binary = counter + 8'b1;
assign location_NHAP = ((current_state == NHAP) && (~submit) && (in_str == in_comp)) ? Binary : location_NHAP;

				//Led hien thi vi tri trung nhau khi str nhap vao giong voi str so sanh.
Binary_to_2_led #(.Binary_length(8),.BCD_number(2)) led_00_01 (.Binary(location_NHAP),
																					.clk(clk),
																					.real_led(led0_1));

 

//module xu ly: quet toan bo chuoi, dua cac gia tri ma tai do chuoi giong voi chuoi so sanh vao memory
//thong qua data_in va index_w
//sau do lan luot dua ra index_r de doc du lieu tu memory moi 2s
XUAT_state #(.FREQUENCY(FREQUENCY))Xuat  (.ready(ready), 
														.roll_back(roll_back), 
														.clk(clk), 
														.reset(reset), 
														.counter(counter), 
														.data_in(data_in),
														.scan_completed(scan_completed),
														.stringo(stringo), 
														.in_comp(in_comp), 
														.index_w(index_w), 
														.hz_out(hz_out),
														.index_r(index_r)
														);

//memory se doc gia tri vao va dua gia tri ra thong qua data_out va index_r 						
Memory_with_read_addr #(.DEPTH(64),.LENGTH(8)) 
										input_data_in 				(.datain(data_in),
																		//.write_en(1'b1),
																		//.read_en(1'b1),
																		.write_addr(index_w),
																		.read_addr(index_r),
																		.dataout(data_out),
																		.clk(clk));	
										

										//hien thi nhap nhay vi tri cua cac con so ma tai do 2 chuoi trung nhau, lay data_out
										//cua memory lam input cua den`
Binary_to_2_led #(.Binary_length(8),.BCD_number(2)) location_XUAT (.Binary(data_out),
																						.clk(clk),
																						.real_led(led02_03));
										
										//hien thi so luong cac chuoi trung nhau
Binary_to_2_led #(.Binary_length(6),.BCD_number(2)) total		  (.Binary(index_w),
																						.clk(clk),
																						.real_led(led4_5));										


																						
//dieu khien su nhap nhay: khi chua hoan thanh chuoi, den tat.
//khi da hoan thanh chuoi, den se sang trong 1 giay va tat trong 1 giay, sau do chuyen sang so tiep theo																						
always @(*) begin: control_final_led_toggle
	if (scan_completed) 
	begin
		if (hz_out) led2_3 = led02_03;
		else led2_3 = {14{1'b1}};
	end
	else 
	begin
		led2_3 = {14{1'b1}};
	end
end


endmodule


