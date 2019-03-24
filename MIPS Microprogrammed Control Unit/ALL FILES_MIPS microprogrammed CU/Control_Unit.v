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
