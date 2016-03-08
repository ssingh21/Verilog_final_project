module mult_compute (clock, element1, element2,new1);

input         clock;
input [24:0]  element1;
input [23:0]  element2;

output [24:0] new1;

wire [24:0] new1;
//output [47:0] new2;

wire [23:0] buf1;
wire [23:0] buf4;
wire [23:0] buf7;
wire [23:0] buf10;
wire [23:0] buf13;
wire [23:0] buf16;

reg [23:0] buf2;
reg [23:0] buf3;
reg [23:0] buf5;
reg [23:0] buf6;
reg [23:0] buf8;
reg [23:0] buf9;
reg [23:0] buf11;
reg [23:0] buf12;
reg [23:0] buf14;
reg [23:0] buf15;
reg [23:0] buf17;
reg [23:0] buf18;


reg [23:0] s1;
reg [23:0] r1;
reg [23:0] s2;
reg [23:0] r2;
reg [23:0] s3;
reg [23:0] r3;
reg [23:0] s4;
reg [23:0] r4;

reg dirtybuff1, dirtybuff2, dirtybuff3, dirtybuff4; 

always @(posedge clock)
begin
	s3 <= element1[23:0];
	r3 <= element2[23:0];
	dirtybuff1 <= element1[24];	
	

	buf8 <= buf7;
	buf9 <= buf8;
	buf18 <= buf9;
	dirtybuff2 <= dirtybuff1;
	dirtybuff3 <= dirtybuff2;
	dirtybuff4 <= dirtybuff3;
end	
	addsub u3 (.clock(clock), .inst_a(s3), .inst_b(r3), .inst_rnd(3'b000), .inst_op(1'b0), .z_inst(buf7)); // 

assign new1[24] = dirtybuff4;
assign new1[23:0] = buf18;

endmodule

