module Control_Unit(opcode,funct,cw,clk,of);

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

reg [2:0] addr_ctrl;
//reg [2:0] addr_ctrl;


wire [2:0] mux_op;

initial begin
	addr_ctrl = 3'd0;
	//of=0;
	chk = 1'b1;
	
end


always @(posedge clk)
begin
	if(!chk)
		addr_ctrl = cw[2:0];
		//of=cw[3:3];
	else
		chk = 0;
end


DT1 dt1(opcode,funct,dt1_addr);
DT2 dt2(opcode,funct,dt2_addr);
DT3 dt3(opcode,funct,dt3_addr);



//addr_ctrl = (dt1_addr==5'bxxxxx && dt2_addr==5'bxxxxx && dt3_addr==5'bxxxxx) ? 3'b110 : addr_ctrl ;
MUX_2x1 mux_2x1(addr_ctrl,5'b110,of,mux_op);


MUX mux(0,addr,dt1_addr,dt2_addr,dt3_addr,5'b01101,5'b11110,0,mux_op,addr);

Control_Memory cm(addr,cw);

endmodule

module cu_tb();

wire clk;
	
reg [5:0] opcode,funct;
reg of;
wire [31:0] cw;




Clock_Module CLK(clk);

Control_Unit CU(
.opcode(opcode),
.funct(funct),
.cw(cw),
.clk(clk),
.of(of));



initial begin


  //opcode = 6'd0;  funct = 6'd8; 		of = 0;//jr

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

#60  opcode = 6'd31; funct = 6'd31;		of = 0;//invalid

#60  opcode = 6'd0;  funct = 6'd32;  	of = 0;
#60  opcode = 6'd0;  funct = 6'd32;  	of = 1;//add with overflow
#20  								 	of = 0;

#10 $stop;

end

endmodule
