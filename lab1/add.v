module add(a, b, c, d, res);

	input [3:0] a, b, c, d;	
	output [5:0] res;	
	output overflow;	//溢位
	assign {overflow,res} = a + b + c + d;	//當sum加到溢位時會放在overflow內(proc a.)

endmodule

