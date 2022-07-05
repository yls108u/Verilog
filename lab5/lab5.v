module lab5_birth(	
		input [2:0] cnt,
		output [3:0] birth_num,
		output reg [6:0] seg_data
	);

//**CODE_CONVERTER**//
//always @(*) begin
	//case(rst)
	//1'b0: birth_num <= {1'b0,cnt}
	//1'b1: 
	//begin
		assign birth_num[0] = cnt[0] & cnt[1] | cnt[0] & cnt[2] | cnt[1] & cnt[2];
		assign birth_num[1] = !cnt[0] & !cnt[1] & !cnt[2] | cnt[0] & cnt[1] & cnt[2];
		assign birth_num[2] = cnt[0] & !cnt[1] & cnt[2];
		assign birth_num[3] = 1'b0;
	//end
	//endcase
//end

//**BCD_to_7SEG**//
always@(*) begin
	seg_data[6] = (!birth_num[3] & !birth_num[2] & !birth_num[1]) | (!birth_num[3] & birth_num[2] & birth_num[1] & birth_num[0]);
	seg_data[5] = (!birth_num[3] & !birth_num[2] & birth_num[0]) | (!birth_num[3] & !birth_num[2] & birth_num[1]);
	seg_data[4] = (!birth_num[3] & birth_num[2] & !birth_num[1]) | (!birth_num[2] & !birth_num[1] & birth_num[0]) | (!birth_num[3] & birth_num[2] & birth_num[0]) |  (!birth_num[3] & birth_num[1] & birth_num[0]);
	seg_data[3] = (!birth_num[3] & birth_num[2] & !birth_num[1] & !birth_num[0]) |  (!birth_num[3] & !birth_num[2] & !birth_num[1] & birth_num[0]) |  (!birth_num[3] & birth_num[2] & birth_num[1] & birth_num[0]);
	seg_data[2] = (!birth_num[3] & !birth_num[2] & birth_num[1] & !birth_num[0]);
	seg_data[1] = (!birth_num[3] & birth_num[2] & !birth_num[1] & birth_num[0]) |  (!birth_num[3] & birth_num[2] & birth_num[1] & !birth_num[0]);
	seg_data[0] = (!birth_num[3] & birth_num[2] & !birth_num[1] & !birth_num[0]) |  (!birth_num[3] & !birth_num[2] & !birth_num[1] & birth_num[0]);
end
	
endmodule