module Clock_Module(out);
output out;
reg    out;
                        
initial begin
        out = 1'b1;
end

always
begin
        out = #10 ~out;
end
endmodule


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

//module Control_Memory(address,IorD,memRd,memWr,irWr,aluSrcA,aluSrcB,alu_ctrl,hiSel,loSel,hiWr,loWr,mALUOp,memToReg,regDst,regWr,PCWr,PCWrCond,PCSrc,addr_ctrl,cw,clk);
module Control_Memory(address,cw,state);

//input clk;
input [4:0] address;

output [4:0] state;
reg [4:0] state;

//Sequence of signals

// output IorD;
// output memRd;
// output memWr;
// output irWr;
// output [1:0] aluSrcA;
// output [2:0] aluSrcB;
// output [2:0] alu_ctrl;
// output hiSel;
// output loSel;
// output hiWr;
// output loWr;
// output mALUOp;
// output [2:0] memToReg;
// output [1:0] regDst;
// output regWr;
// output PCWr;
// output PCWrCond;
// output [1:0] PCSrc;
// output [2:0] addr_ctrl;
output [35:0] cw;

reg [35:0] cw;



reg [35:0] control_word[31:0];

//2,3,4,5,6,7,8,9,10,11,12,14,15,16,18,19,20 eligible for overflow



initial begin

	control_word[0]=36'bx00010100000000xxxx00xxxxxx010000001;//SEQ	 //IF36'b0 1 0 1 00 000 000 xx xx 0 0 x xxx xx 0 1 0 00 001;
	control_word[1]=36'bx00x00000010000xxxx00xxxxxx000xxx010;//DT1	 //ID
	control_word[2]=36'bx00x000xxxxxxxxxxxx00x10000100xxx000;//IF	 //ex mfhi
	control_word[3]=36'bx00x000xxxxxxxxxxxx00x10100100xxx000;//IF	 //ex mthi
	control_word[4]=36'bx00x000xxxxxxxx01xx10xxxxxx000xxx000;//IF	 //ex mflo
	control_word[5]=36'bx00x000xxxxxxxxxx0101xxxxxx000xxx000;//IF	 //ex mtlo
	control_word[6]=36'bx00x000xxxxxxxxxxxx00x01100100xxx000;//IF	 //ex lui
	control_word[7]=36'bx00x00001001001xxxx00xxxxxx001001000;//IF	 //ex beq
	control_word[8]=36'bx00x000xxxxxxxxxxxx00xxxxxx010010000;//IF	 //ex j
	control_word[9]=36'bx00x000xxxxxxxxxxxx00x01010110010000;//IF	 //ex jal
	control_word[10]=36'bx00x000xxxxxxxxxxxx00xxxxxx010011000;//IF	 //ex jr
	control_word[11]=36'bx00x000xxxxxxxxxxxx00x01000110011000;//IF	 //ex jalr
	control_word[12]=36'bx00x00001001000xxxx00xxxxxx000xxx001;//seq  //ex add
	control_word[13]=36'bx00x000xxxxxxxxxxxx00x00000100xxx000;//IF	 //wb add					//19th
	control_word[14]=36'bx00x00001001010xxxx00xxxxxx000xxx101;//HC	 //ex sll					//13th
	control_word[15]=36'bx00x00001001010xxxx00xxxxxx000xxx101;//HC	 //ex sllv					//14th
	control_word[16]=36'bx00x00001001011xxxx00xxxxxx000xxx001;//SEQ	 //ex div					//15th
	control_word[17]=36'bx00x000xxxxxxxxxxxx00x00000100xxx000;//IF	 //ex wb div wb mul			//20th
	control_word[18]=36'bx00x00001001100xxxx00xxxxxx000xxx011;//DT2	 //ex mult madd msub		//16th
	control_word[19]=36'bx00x00001011000xxxx00xxxxxx000xxx100;//DT3	 //ex addi lw sw			//17th
	control_word[20]=36'bx00x00001100101xxxx00xxxxxx000xxx001;//SEQ	 //ex ori					//18th
	control_word[21]=36'bx00x000xxxxxxxxxxxx00x00001100xxx000;//IF	 //wb ori					//25
	control_word[22]=36'bx00x000xxxxxxxx1010110xxxxx000xxx000;//IF	 //wb madd					//21maluop->add->0
	control_word[23]=36'bx00x000xxxxxxxx1010111xxxxx000xxx000;//IF	 //wb msub					//22maluop->sub->1
	control_word[24]=36'bx001100xxxxxxxxxxxx00xxxxxx000xxx001;//SEQ	 //mem lw					//23
	control_word[25]=36'bx00x000xxxxxxxxxxxx00x00101100xxx000;//IF	 //wb lw					//26
	control_word[26]=36'bx001010xxxxxxxxxxxx00xxxxxx000xxx000;//IF	 //mem sw					//24
	
	
	control_word[30]=36'b111010100000001xxxx00xxxxxx010100000;//replicate of add with of=1;
	control_word[31]=36'b011010100000001xxxx00xxxxxx010100000;//INVALID
	
	
	
	
end


always @(address)
begin
	 cw[35:0] = control_word[address];
	 state=address;
end

endmodule

module Control_Unit(opcode,funct,cw,clk,of,IorD,memRd,memWr,irWr,aluSrcA,aluSrcB,alu_ctrl,hiSel,loSel,hiWr,loWr,mALUOp,memToReg,regDst,regWr,PCWr,PCWrCond,PCSrc,current_state,int_cause,cause_write,EPC,address_control);

input [5:0] opcode;
input [5:0] funct;
input clk;
input of;

reg chk;

output [35:0] cw;
wire [35:0] cw;

wire [4:0] dt1_addr;
wire [4:0] dt2_addr;
wire [4:0] dt3_addr;

wire [4:0] addr;


output  int_cause;
output  cause_write;
output  EPC;
output  IorD;
output  memRd;
output  memWr;
output  irWr;
output  [1:0] aluSrcA;
output  [2:0] aluSrcB;
output  [2:0] alu_ctrl;
output  [1:0] hiSel;
output  [1:0] loSel;
output  hiWr;
output  loWr;
output  mALUOp;
output  [2:0] memToReg;
output  [1:0] regDst;
output  regWr;
output  PCWr;
output  PCWrCond;
output  [2:0] PCSrc;
output  [2:0] address_control;

 
output  [4:0] current_state;
wire  [4:0] current_state;
 
 
reg [2:0] addr_ctrl;

wire [2:0] mux_op;

initial begin

	addr_ctrl = 3'd0;
	chk = 1'b1;
	
end


always @(posedge clk)
begin

	if(!chk)
	begin
	 addr_ctrl = cw[2:0];
		
		end
	else
		chk = 0;
end


assign int_cause = cw[35:35];
assign cause_write = cw[34:34];
assign EPC = cw[33:33];
assign IorD=cw[32:32];
assign memRd=cw[31:31];
assign memWr=cw[30:30];
assign irWr=cw[29:29];
assign aluSrcA=cw[28:27];
assign aluSrcB=cw[26:24];
assign alu_ctrl=cw[23:21];
assign hiSel=cw[20:19];
assign loSel=cw[18:17];
assign hiWr=cw[16:16];
assign loWr=cw[15:15];
assign mALUOp=cw[14:14];
assign memToReg=cw[13:11];
assign regDst=cw[10:9];
assign regWr=cw[8:8];
assign PCWr=cw[7:7];
assign PCWrCond=cw[6:6];
assign PCSrc=cw[5:3];
assign address_control=cw[2:0];


DT1 dt1(opcode,funct,dt1_addr);
DT2 dt2(opcode,funct,dt2_addr);
DT3 dt3(opcode,funct,dt3_addr);

MUX_2x1 mux_2x1(addr_ctrl,3'b110,of,mux_op);

MUX mux(5'd0,addr,dt1_addr,dt2_addr,dt3_addr,5'b01101,5'b11110,5'd0,mux_op,addr);

Control_Memory cm(addr,cw,current_state);

endmodule

module cu_tb();

wire clk;
	
reg [5:0] opcode,funct;
reg of;
wire [35:0] cw;

wire  [4:0] current_state;
wire  [2:0] address_control;
wire int_cause;
wire cause_write;
wire EPC;
wire IorD;
wire  memRd;
wire  memWr;
wire  irWr;
wire  [1:0] aluSrcA;
wire  [2:0] aluSrcB;
wire  [2:0] alu_ctrl;
wire  [1:0] hiSel;
wire  [1:0] loSel;
wire  hiWr;
wire  loWr;
wire  mALUOp;
wire  [2:0] memToReg;
wire  [1:0] regDst;
wire  regWr;
wire  PCWr;
wire  PCWrCond;
wire  [2:0] PCSrc;


Clock_Module CLK(clk);

Control_Unit CU(
.opcode(opcode),
.funct(funct),
.cw(cw),
.clk(clk),
.of(of),
.IorD(IorD),
.memRd(memRd),
.memWr(memWr),
.irWr(irWr),
.aluSrcA(aluSrcA),
.aluSrcB(aluSrcB),
.alu_ctrl(alu_ctrl),
.hiSel(hiSel),
.loSel(loSel),
.hiWr(hiWr),
.loWr(loWr),
.mALUOp(mALUOp),
.memToReg(memToReg),
.regDst(regDst),
.regWr(regWr),
.PCWr(PCWr),
.PCWrCond(PCWrCond),
.PCSrc(PCSrc),
.current_state(current_state),
.int_cause(int_cause),
.cause_write(cause_write),
.EPC(EPC),
.address_control(address_control));

initial begin

	opcode = 6'd0;  funct = 6'd32; 		of = 0;//add
#80 opcode = 6'd0;  funct = 6'd24; 		of = 0;//mult
#80 opcode = 6'd0;  funct = 6'd26; 		of = 0;//div
#80 opcode = 6'd28; funct = 6'd0; 		of = 0;//madd
#80 opcode = 6'd28; funct = 6'd4; 		of = 0;//msub
#80 opcode = 6'd0;  funct = 6'd0; 		of = 0;//sll
#80 opcode = 6'd0;  funct = 6'd4; 		of = 0;//sllv

#80 opcode = 6'd0;  funct = 6'd16; 		of = 0;//mfhi

#60  opcode = 6'd0;  funct = 6'd18; 	of = 0;//mflo
#60  opcode = 6'd0;  funct = 6'd17; 	of = 0;//mthi
#60  opcode = 6'd0;  funct = 6'd19; 	of = 0;//mtlo
#60  opcode = 6'd8;  					of = 0;//addi 
#80 opcode = 6'd9;   					of = 0;//ori 
#80 opcode = 6'd15;  					of = 0;//lui 
#60  opcode = 6'd4;   					of = 0;//beq
#60  opcode = 6'd35;  					of = 0;//lw
#100 opcode = 6'd43;  					of = 0;//sw
#80 opcode = 6'd2;   					of = 0;//j
#60  opcode = 6'd3;   					of = 0;//jal
#60  opcode = 6'd0;  funct = 6'd8; 		of = 0;//jr
#60  opcode = 6'd0;  funct = 6'd9; 		of = 0;//jalr

#60 opcode = 6'd31; funct = 6'd31;		of = 0;//invalid

#60  opcode = 6'd0;  funct = 6'd32;  	of = 0;
#60  opcode = 6'd0;  funct = 6'd32;  	of = 1;//add with overflow
#20  								 	of = 0;

#20 $stop;

end

endmodule












