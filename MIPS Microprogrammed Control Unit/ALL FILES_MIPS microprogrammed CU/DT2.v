module DT2(opcode,funct,addr);

input [5:0] opcode;
input [5:0] funct;

output [4:0] addr;
reg [4:0] addr;

always @(*) begin
	
	if(opcode==6'b000000 && funct==6'b011000)//mul
		begin
			addr=5'b10001;								//20-->17
		end
	
		if(opcode==6'b011100)//madd and msub
		begin
		
			if(funct==6'b000000)//madd
			begin

				addr=5'b10110;							//21-->22

			end
		
			if(funct==6'b000100)//msub
			begin

				addr=5'b10111;							//22-->23

			end

		end

end

endmodule

