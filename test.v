module test(result);

reg [0:5] yo;
output [5:0] result;

integer count;

always @(*) begin
	count = 1;
	yo[count -: 2] = 2'b11;
	#5;
	count = 3;
	yo[count -:2] = 2'b10;
	#5;
	count = 5;
	yo[count -:2] = 2'b01;
	#5;
	//$stop;
end

assign result = yo;

	
endmodule



