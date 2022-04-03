module t_Find_string();



parameter NHAP = 3'b001,
			 XOA = 3'b010,
			 XUAT = 3'b100;

reg [3:0]in_str, in_comp;
reg clk;
reg done, delete;
reg submit,reset;
reg roll_back;

wire [13:0]led0_1;
wire [13:0]led2_3;
wire [13:0]led4_5;

		Find_string #(.FREQUENCY(100)) U (.in_str(in_str), 
							.in_comp(in_comp), 
							.clk(clk), 
							.done(done), 
							.delete(delete), 
							.submit(submit),
							.reset(reset), 
							.roll_back(roll_back), 
							.led0_1(led0_1), 
							.led2_3(led2_3), 
							.led4_5(led4_5)
		);

		
initial clk = 0;
always #1 clk = ~clk;

initial begin
	//Lan nhap thu nhat: ---------------------------Chuoi so sanh: 0110
	//khoi dong--------------------------------------------------------
	in_comp = 4'b0110;
	done = 0;
	delete = 1;
	submit = 1;
	reset = 0;
	roll_back = 1;
	 #5;
	reset = 1 ;
	//-------------------------Chuoi: 0011
	in_str = 4'b0011;
	submit = 0;
	#2;
	submit = 1;
	#2;
	//-------------------------Chuoi: 0011_0001
	in_str = 4'b0001;
	submit = 0;
	#2;
	submit = 1;
	#2;
	//-------------------------Chuoi: 0011_0001_0110
	 
	in_str = 4'b0110;
	submit = 0;
	#2;
	submit = 1;
	#2;
	//---------------------Xoa chuoi vua nhap: 0011_0001_0000
	delete = 0;
	#10;
	delete = 1;
	#4;
	//---------------------Nhap moi: 0011_0001_1011
	in_str = 4'b1011;
	submit = 0;
	#2;
	submit = 1;
	#2;
	 //-------------------------Chuoi: 0011_0001_1011_1101
	in_str = 4'b1101;
	submit = 0;
	#2;
	submit = 1;
	#2;
	 //-------------------------Chuoi: 0011_0001_1011_1101_1000
	in_str = 4'b1000;
	submit = 0;
	#2;
	submit = 1;
	#2;
	#10;
	//----------------------Bat tin hieu done de ket thuc nhap chuoi khi chua nhap du 40 ki tu.
	//----------------------Chuoi nay se trung tai 3 vi tri: 2, 7 va 15. co tong cong 3 chuoi trung
	done = 1;
	#2000;
	in_comp = 4'b1111;
	//----------------------roll back de quet lai toan bo chuoi voi chuoi so sanh moi.
	roll_back = 0;
	#4;
	roll_back = 1;
	#1000;
	//----------------------Thuc hien reset de nhap lai chuoi moi.
	//----------------------Chuoi so sanh moi: 1010
	in_comp = 4'b1010;
	done = 0;
	delete = 1;
	submit = 1;
	reset = 0;
	roll_back = 1;
	#5;
	reset = 1;
	//khoi dong
	//-----------------------Chuoi: 1010
	in_str = 4'b1010;
	submit = 0;
	#2;
	submit = 1;
	#2;
	//-----------------------Chuoi: 1010_1001
	in_str = 4'b1001;
	submit = 0;
	#2;
	submit = 1;
	#2;
	//-----------------------Chuoi: 1010_1001_0101
	in_str = 4'b0101;
	submit = 0;
	#2;
	submit = 1;
	#2;
	//xoa chuoi
	//-----------------------Chuoi: 1010_1001_0000
	delete = 0;
	#10;
	delete = 1;
	#2;
	#2;
	//-----------------------Chuoi: 1010_1001_0000
	in_str = 4'b0000;
	submit = 0;
	#2;
	submit = 1;
	#2;
	//-----------------------Chuoi: 1010_1001_0000_1101
	in_str = 4'b1101;
	submit = 0;
	#2;
	submit = 1;
	#2;
	//-----------------------Chuoi: 1010_1001_0000_1101_1111
	in_str = 4'b1111;
	submit = 0;
	#2;
	submit = 1;
	#2;
	//-----------------------Chuoi: 1010_1001_0000_1101_1111_0111
	in_str = 4'b0111;
	submit = 0;
	#2;
	submit = 1;
	#2;
	//-----------------------Chuoi: 1010_1001_0000_1101_1111_0111_1100
	in_str = 4'b1100;
	submit = 0;
	#2;
	submit = 1;
	#2;
	//-----------------------Chuoi: 1010_1001_0000_1101_1111_0111_1100_1101
	in_str = 4'b1101;
	submit = 0;
	#2;
	submit = 1;
	#2;
	//-----------------------Chuoi: 1010_1001_0000_1101_1111_0111_1100_1101_1001
	in_str = 4'b1001;
	submit = 0;
	#2;
	submit = 1;
	#2;
	//-----------------------Chuoi: 1010_1001_0000_1101_1111_0111_1100_1101_1001_0100
	in_str = 4'b0100;
	submit = 0;
	#2;
	submit = 1;
	#2;
	//Khi nay da nhap du 40 ki tu, chuong trinh tu dong do soat het toan bo chuoi de tim chuoi trung
	//va dua ra ket qua. Co tat ca 3 chuoi trung, tai vi tri 1, 3 va 36.
	#2000;
	in_comp = 4'b1111;
	roll_back = 0;
	#4;
	roll_back = 1;
	#1000;
end

endmodule
