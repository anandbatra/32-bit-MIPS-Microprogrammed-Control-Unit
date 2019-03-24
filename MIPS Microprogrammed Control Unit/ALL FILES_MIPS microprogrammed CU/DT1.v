module DT1(opcode,funct,addr);

input [5:0] opcode;
input [5:0] funct;
//input [2:0] of;

output [4:0] addr;
reg [4:0] addr;

always @(*) begin

if(opcode==6'b000000)	
		begin
		
			if(funct==6'b010000)//mfhi
			begin
				
				addr=5'b00010;

			end	
			else if(funct==6'b010010)//mflo
			begin

				addr=5'b00011;
				

			end	
			else if(funct==6'b010001)//mthi
			begin

				addr=5'b00100;//4

			end	
			else if(funct==6'b010011)//mtlo
			begin
				
				addr=5'b00101;//5
				
			end	
			else if(funct==6'b001000)//jr
			begin
		
		
				addr=5'b01010;//10
		
			end
			else if(funct==6'b001001)//jalr
			begin
		
				addr=5'b01011;//11
			
		
			end
			else if(funct==6'b100000)//Add
			begin

				// if(of==3'b001)
					// addr=5'b11110;
				// else
					addr=5'b01100;//12
			end
			else if(funct==6'b000000)//sll
			begin
				
				addr=5'b01110;					//13-->14

			end		
			else if(funct==6'b000100)//sllv
			begin
			
				addr=5'b01111;					//14-->15

			end	
			else if(funct==6'b011010)//Div
			begin

				addr=5'b10000;					//15-->16
			
			end
			else if(funct==6'b011000)//Mul
			begin
               
				addr=5'b10010;					//16-->18
			

			end
			

		end
		else if(opcode==6'b001111)//lui
		begin
		
			addr=5'b00110;//6
		
		end	
		else if(opcode==6'b000100)//beq
		begin
			addr=5'b00111;//7
		end
		else if(opcode==6'b000010)//j
		begin
		
			addr=5'b01000;//8
	
		end
		else if(opcode==6'b000011)//jal
		begin
		
			addr=5'b01001;//9
		
		end
		else if(opcode==6'b011100)//madd and msub
		begin
		
			if(funct==6'b000000 || funct==6'b000100)
			begin

				addr=5'b10010;					//16-->18

			end
		
		end
		else if(opcode==6'b001000)//addi	
		begin

			addr=5'b10011;						//17-->19
		end
		else if(opcode==6'b100011)//lw
		begin

			addr=5'b10011;						//17-->19
		
		end
		else if(opcode==6'b101011)//sw
		begin
	
			addr=5'b10011;						//17-->19
		end
		else if(opcode==6'b001001)//ori	
		begin
			addr=5'b10100;						//18--20
		end	
		else
		begin
			addr=5'b11111;
		end

end

endmodule
