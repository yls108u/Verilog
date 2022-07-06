`timescale 1ns/ 10ps
`include "mealy_hw.v"

module tb;

	reg clk, reset, x;
	wire y;
	
	mealy_hw mealy(clk, reset, x, y);
	
	initial begin
		$dumpfile("mealy_hw.fsdb");
		$dumpvars;
	end
	
	initial begin
		clk <= 1'b1;
		reset <= 1'b0;
		x <= 1'b0;
	end
	
	always #10 clk = ~clk;
	
	initial begin
		#5  reset <= 1'b1;
		#20 reset <= 1'b0;
	end
	
	
	initial begin
		repeat(3)@(posedge clk);
		x <= 1'b0;
		repeat(2)@(posedge clk);
		x <= 1'b1;
		@(posedge clk);
		x <= 1'b0;
		repeat(2)@(posedge clk);
		x <= 1'b1;
		@(posedge clk);
		x <= 1'b0;
		repeat(2)@(posedge clk);
		x <= 1'b1;
		@(posedge clk);
		x <= 1'b0;
		repeat(3)@(posedge clk);
		x <= 1'b1;
		repeat(2)@(posedge clk);
		x <= 1'b0;
		repeat(3)@(posedge clk);
		x <= 1'b1;
		repeat(2)@(posedge clk);
		x <= 1'b0;
		@(posedge clk);
		x <= 1'b1;
		@(posedge clk);
		x <= 1'b0;
		repeat(2)@(posedge clk);
		x <= 1'b1;
		@(posedge clk);
		x <= 1'b0;
		@(posedge clk);
		x <= 1'b1;
		#200 $finish;
	end
		
		
endmodule
		
		
		
		