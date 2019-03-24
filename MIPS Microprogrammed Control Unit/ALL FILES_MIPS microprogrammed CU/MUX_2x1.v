module MUX_2x1(input0,input1,select,op);



input [2:0] input0;
input [2:0] input1;


input select;

output [2:0] op;
reg [2:0] op;

always @(*)
begin

	if(select==0)
	begin
		op[2:0]=input0[2:0];
	end

	if(select==1)
	begin
		op[2:0]=input1[2:0];
	end

	



end
endmodule


