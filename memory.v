module memory (clock, ReadAddress1, ReadAddress2, ReadBus1, ReadBus2, WE, WriteReq, WriteBus, Rowread1, Rowread2, Rowread3, Rowread4, vop1, vop2, vop3, vop4, we1, we2, we3, we4, write_addr1, write_addr2, write_addr3, write_addr4, op_reg, addressI, outI);

//----------- VSram Connection ------------//
input clock;


input [8:0] Rowread1;
input [8:0] Rowread2;
input [8:0] Rowread3;
input [8:0] Rowread4;
input       we1, we2, we3, we4;
input [8:0] write_addr1;
input [8:0] write_addr2;
input [8:0] write_addr3;
input [8:0] write_addr4;
input [47:0] op_reg;

output [47:0] vop1;
output [47:0] vop2;
output [47:0] vop3;
output [47:0] vop4;
//----------------------------------------//

input [10:0] ReadAddress1;
input [10:0] ReadAddress2;
input [10:0] WriteReq;
input        WE;

output [255:0] ReadBus1;
output [255:0] ReadBus2;
wire [255:0] ReadBus1;
wire [255:0] ReadBus2;
input [255:0] WriteBus;
//--------------------------------------------//

//-------------------------------------------//
output  [191:0] outI;
input [7:0] addressI;
//-------------------------------------------//

//---------------- Wires --------------------//
wire [47:0] vop1;
wire [47:0] vop2;
wire [47:0] vop3;
wire [47:0] vop4;
//wire [255:0] ReadBus1;
//wire [255:0] ReadBus2;
wire [255:0] WriteBus;
wire  [191:0] outI;
//-------------------------------------------//

y_sram u2  (.clock(clock), .ReadAddress1(ReadAddress1), .ReadAddress2(ReadAddress2), .ReadBus1(ReadBus1), .ReadBus2(ReadBus2), .WE(WE), .WriteAddress(WriteReq), .WriteBus(WriteBus));
 v_sram_op1 a6 (.clock(clock), .ReadAddress1(Rowread1), .ReadBus1(vop1),.WE(we1),.WriteAddress1(write_addr1),.WriteBus1(op_reg));
 v_sram_op2 a7 (.clock(clock), .ReadAddress1(Rowread2), .ReadBus1(vop2),.WE(we2),.WriteAddress1(write_addr2),.WriteBus1(op_reg));
 v_sram_op3 a8 (.clock(clock), .ReadAddress1(Rowread3), .ReadBus1(vop3),.WE(we3),.WriteAddress1(write_addr3),.WriteBus1(op_reg));
 v_sram_op4 a9 (.clock(clock), .ReadAddress1(Rowread4), .ReadBus1(vop4),.WE(we4),.WriteAddress1(write_addr4),.WriteBus1(op_reg));
 i_sram a18(.clock(clock), .ReadAddress1(addressI),.ReadBus1(outI));

endmodule
