module update_2 (X, Y, RowX, RowY, Y_ramX, Y_ramY, Row_noX, Row_noY, clock, EnableChange, FoundX, FoundY, FlagX, FlagY, DiagonalDoneX, DiagonalDoneY, WireX, WireY);

input          clock;
input          EnableChange;
input [255:0]  RowX;
input [255:0]  RowY;
input [15:0]   X;
input [15:0]   Y;
input [10:0]   Y_ramX;
input [10:0]   Y_ramY;
input [1:0]    FoundX;
input [1:0]    FoundY;
input          FlagX;
input          FlagY;
input          DiagonalDoneX;
input          DiagonalDoneY;
input          WireX;
input          WireY;

output [10:0]  Row_noX;
output [10:0]  Row_noY;

wire [3:0]  remX;
wire [3:0]  remY;
reg [10:0] Row_noX;
reg [10:0] Row_noY;
reg        NewRowX;
reg        NewRowY;

assign remX = X[3:0];
assign remY = Y[3:0];

always@(posedge clock)
begin

	//NewRowX <= 1'b0;
	//NewRowY <= 1'b0;

	if (DiagonalDoneX == 1'b0 && FlagX)
	begin
		case (remX)
			4'b0000: Row_noX <= RowX[250:240];
			4'b0001: Row_noX <= RowX[234:224];
			4'b0010: Row_noX <= RowX[218:208];
			4'b0011: Row_noX <= RowX[202:192];
			4'b0100: Row_noX <= RowX[186:176];
			4'b0101: Row_noX <= RowX[170:160];
			4'b0110: Row_noX <= RowX[154:144];
			4'b0111: Row_noX <= RowX[138:128];
			4'b1000: Row_noX <= RowX[122:112];
			4'b1001: Row_noX <= RowX[106:96];
			4'b1010: Row_noX <= RowX[90:80];
			4'b1011: Row_noX <= RowX[74:64];
			4'b1100: Row_noX <= RowX[58:48];
			4'b1101: Row_noX <= RowX[42:32];
			4'b1110: Row_noX <= RowX[26:16];
			4'b1111: Row_noX <= RowX[10:0];
		endcase
	end
	
	if (DiagonalDoneY == 1'b0 && FlagY)
	begin
		case (remY)
			4'b0000: Row_noY <= RowY[250:240];
			4'b0001: Row_noY <= RowY[234:224];
			4'b0010: Row_noY <= RowY[218:208];
			4'b0011: Row_noY <= RowY[202:192];
			4'b0100: Row_noY <= RowY[186:176];
			4'b0101: Row_noY <= RowY[170:160];
			4'b0110: Row_noY <= RowY[154:144];
			4'b0111: Row_noY <= RowY[138:128];
			4'b1000: Row_noY <= RowY[122:112];
			4'b1001: Row_noY <= RowY[106:96];
			4'b1010: Row_noY <= RowY[90:80];
			4'b1011: Row_noY <= RowY[74:64];
			4'b1100: Row_noY <= RowY[58:48];
			4'b1101: Row_noY <= RowY[42:32];
			4'b1110: Row_noY <= RowY[26:16];
			4'b1111: Row_noY <= RowY[10:0];
		endcase

		//EnableChange <= 1'b0;
	end

	
	if (DiagonalDoneX == 1'b1 && (FoundX == 2'b01 || WireX))
		Row_noX <= Row_noX + 1'b1;

	//	else if (FoundX == 1'b1)
	//		Row_noX <= Row_noX;
/******************************************************************/
		if (DiagonalDoneY == 1'b1 && FoundY == 2'b01 || WireY)
			Row_noY <= Row_noY + 1'b1;

		//if (FoundY == 1'b1)
		//	Row_noY <= Row_noY;
		//if (NewRowFetchY == 1'b1)
		//	Row_noY <= Row_noY + 1'b1; 
	//end
end
endmodule
