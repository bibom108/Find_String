module Memory_with_read_addr(datain,write_addr,read_addr,dataout,clk);			
								//memory ngon lanh canh dao anh em eiiiii
parameter DEPTH = 16;
parameter LENGTH = 11;

input	[LENGTH-1:0]datain;
//input write_en, read_en,clk;
input clk;
input [log2(DEPTH)-1:0]write_addr;
output [LENGTH-1:0]dataout;

reg [LENGTH-1:0]temp_mem;

input [log2(DEPTH)-1:0] read_addr;

reg [LENGTH-1:0]mem[DEPTH-1:0];

always @(negedge clk)
begin: Write
		
			
				begin
					mem[write_addr] <= datain;
				end

end

always @(negedge clk)
begin: read
		
			 
				begin
					temp_mem <= mem[read_addr];
				end

end


//Khi co tin hieu << write_en >>, co truong hop vua doc vua ghi, thi khi do ta moi xet read_after_write, con khong
//thi cu doc du lieu dua tren read_addr nhu thuong.
//neu muon doc du lieu binh thuong, nhat thiet phai tat write_en.
//do ta su dung cung 1 input cho ca write_addr va read_addr


//assign dataout = ((write_en) && (write_addr == read_addr)) ? datain : temp_mem;		//output chuan	


											//output = nguyen cai vector luon!
											//xu ly read after write. Neu write_addr giong voi read_addr, thi theo 
											//<= (non-blocking) thuc hien song song, dataout se dua ra gia tri mem[read_addr]
											//cu~ thay vi gia tri moi duoc gan vao mem[write_addr]
											
											//NEN, minh xet neu write_addr = read_addr, ngoai viec luu vao memory, minh xuat 
											//du lieu ra ngoai luon.


//assign dataout = ((write_en) && (write_addr == read_addr) && (read_en)) ? datain : temp_mem; 
																					//output khi muon nap xuong bo
																					
assign dataout = temp_mem;

function integer log2;
	input integer value;
	begin
		value = value - 1;
		for (log2 = 0; value > 0; log2 = log2 + 1)			//log2 da duoc khoi tri = 0
			value = value >> 1;
	end
endfunction

endmodule



