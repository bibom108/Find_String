module Binary_to_BCD_2(Binary, BCD);

parameter Binary_length = 8;
parameter BCD_number = 2;

input [Binary_length-1:0]Binary;


output [BCD_number*4-1:0]BCD;



reg [Binary_length*2-1:0]temp_shifter;			//1 cai vecto rong gap doi, ta chi quan tam toi hang don vi o day
reg [7:0] i;


always @(Binary) begin:shifter
	
	temp_shifter = Binary;
	for (i = 3'b000; i < Binary_length; i = i + 1'b1)								//** TUYET DOI KHONG DUOC temp_shifter[3:0] = Binary
			begin
			if (temp_shifter[Binary_length+4-1:Binary_length] > 4)									//chi xet hang don vi.
			temp_shifter[Binary_length+4-1:Binary_length] = temp_shifter[Binary_length+4-1:Binary_length] + 4'b0011;
			else 
			temp_shifter[Binary_length+4-1:Binary_length] = temp_shifter[Binary_length+4-1:Binary_length];
			
			temp_shifter = temp_shifter << 1;					//**
			
			end
	
end


assign BCD = temp_shifter[Binary_length*2-1:Binary_length];


function integer log2;
	input integer value;
	begin
		value = value - 1;
		for (log2 = 0; value > 0; log2 = log2 + 1)
			value = value >> 1;
	end
endfunction

endmodule


