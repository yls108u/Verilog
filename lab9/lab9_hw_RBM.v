//以前者(1ns)為單位，以後者(1ps)的時間，查看一次電路的行為
`timescale 1ns/1ps

//宣告module名稱,輸出入名稱
module lab9_hw_RBM(
	CLK, 
	RST, 
	in_a, 
	in_b, 
	Product, 
	Product_Valid
);
// in_a * in_b = Product
// in_a is Multiplicand , in_b is Multiplier
					
//定義port, 包含input, output
input 		CLK, RST;
input 	[7:0]	in_a;			// Multiplicand
input 	[7:0]	in_b;			// Multiplier
output 	[15:0]  Product;
output  	Product_Valid;

reg 	[7:0]	Mplicand;		//被乘數
reg 	[7:0]	Mplier;			//乘數
reg 	[17:0]	MU_Product;
reg 		Product_Valid;
reg 	[5:0]	Counter ;
reg		sign;			//正負號判斷 (signed)
reg	[8:0]	tmp;

assign Product = MU_Product[16:1];

//Counter
always @(posedge CLK or posedge RST)
begin
	if(RST)
		Counter <= 6'b0;
	else
		Counter <= Counter + 6'b1;

end

//Product
always @(posedge CLK or posedge RST)
begin
	//初始化數值
	if(RST) begin
		MU_Product  <= 18'b0;
		Mplicand <= 8'b0;
		Mplier   <= 8'b0;		
	end 
	//輸入乘數與被乘數
	else if(Counter == 6'd0) begin
		MU_Product	 	<= {9'b0,in_b,1'b0};
		Mplicand 	<= in_a;
		Mplier	 	<= in_b;		
	end 
	//乘法與數值移位
	else if(Counter <=6'd4) begin

	if(MU_Product[2:0] == 3'b001 || MU_Product[2:0] == 3'b010) begin
		MU_Product = MU_Product + {Mplicand,9'b0};
	end
        else if(MU_Product[2:0] == 3'b101 || MU_Product[2:0] == 3'b110) begin
		MU_Product = MU_Product - {Mplicand,9'b0};
	end
        else if(MU_Product[2:0] == 3'b011) begin
		tmp[8:0] = 2*Mplicand[7:0];
            	MU_Product = MU_Product + {tmp,9'b0};
        end
        else if(MU_Product[2:0] == 3'b100) begin
		tmp[8:0] = 2*Mplicand[7:0];
            	MU_Product = MU_Product - {tmp,9'b0};
        end

        //$display ("Product1 = %b_%b",MU_Product[16:9],MU_Product[8:0]);
	if(MU_Product[17] == 1'b1) begin
            MU_Product = {2'b0,MU_Product[17:2]};
            MU_Product[17:15] = 3'b111;
        end
	else 
	    MU_Product = {2'b0,MU_Product[17:2]};
	//$display ("Product2 = %b_%b",MU_Product[16:9],MU_Product[8:0]);
        //$display ("in_a = %b ; in_b = %b",in_a,in_b);
		
	end 
	else begin
		MU_Product 	<= MU_Product;
		Mplicand	<= Mplicand;
		Mplier 		<= Mplier;
	end
end

//Product_Valid
always @(posedge CLK or posedge RST)
begin
	if(RST)
		Product_Valid <=1'b0;
	else if(Counter==6'd9)
		Product_Valid <=1'b1;
	else
		Product_Valid <=1'b0;
end

endmodule
