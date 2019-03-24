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









