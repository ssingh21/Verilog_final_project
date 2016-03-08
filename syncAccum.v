module syncAccum (clock, mult_output, accum_input, accum_output, accum_output25);

input        clock;
input [24:0] mult_output;
input [23:0] accum_output;

output [23:0] accum_input;
output [24:0] accum_output25;

wire [23:0] accum_input;
wire [24:0] accum_output25;

reg dirtybuff1, dirtybuff2, dirtybuff3, dirtybuff4;

assign accum_input = mult_output[23:0];

always@(posedge clock)
begin

	dirtybuff1 <= mult_output[24];
	dirtybuff2 <= dirtybuff1;
	dirtybuff3 <= dirtybuff2;
	dirtybuff4 <= dirtybuff3;
end

assign accum_output25[24] = dirtybuff4;
assign accum_output25[23:0] = accum_output;

endmodule

