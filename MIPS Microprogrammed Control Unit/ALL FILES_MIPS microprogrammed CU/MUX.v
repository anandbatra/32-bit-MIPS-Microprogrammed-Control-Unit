
module MUX(input0,input1,input2,input3,input4,input5,input6,input7,select,op);

//input clk;

input [4:0] input0;
input [4:0] input1;
input [4:0] input2;
input [4:0] input3;

input [4:0] input4;
input [4:0] input5;
input [4:0] input6;
input [4:0] input7;

input [2:0] select;

output [4:0] op;
reg [4:0] op;

always @(select)
begin

	// if(select == 3'hx)
	// begin
		// op[4:0] = 3'bx;
	// end

	if(select==3'b000)
	begin
		op[4:0]=input0[4:0];
	end

	if(select==3'b001)
	begin
		op[4:0]=input1[4:0] + 5'd1;
	end

	
	if(select==3'b010)
	begin
		op[4:0]=input2[4:0];
	end

	if(select==3'b011)
	begin
		op[4:0]=input3[4:0];
	end

	
	if(select==3'b100)
	begin
		op[4:0]=input4[4:0];
	end

	if(select==3'b101)
	begin
		op[4:0]=input5[4:0];
	end

	
	if(select==3'b110)
	begin
		op[4:0]=input6[4:0];
	end

	if(select==3'b111)
	begin
		op[4:0]=input7[4:0];
	end


end
endmodule
