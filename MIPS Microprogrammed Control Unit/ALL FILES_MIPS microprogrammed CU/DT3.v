module DT3(opcode,funct,addr);

input [5:0] opcode;
input [5:0] funct;

output [4:0] addr;
reg [4:0] addr;

always @(*) begin
	
	if(opcode==6'b100011)//lw
		begin

			addr=5'b11000;					//23-->24
		
		end

		if(opcode==6'b101011)//sw
		begin
	
			addr=5'b11010;					//24-->26
		end

		if(opcode==6'b001000)//addi	
		begin

			addr=5'b10101;					//25-->21
		end

end

endmodule


