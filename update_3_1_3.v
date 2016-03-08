module update_3_1 (reset, clock, X, Y, NewRowX, NewRowY, Element, PosRowX, PosRowY, PosDX, PosDY, FoundX, FoundY, Row_noX, Row_noY, DiagonalDoneX, DiagonalDoneY, EnableChange, WireX, WireY);// Finding XY in row X and YX in row Y

input       EnableChange;
input       clock;
input [15:0]   X;
input [15:0]   Y;
input [255:0] NewRowX;
input [255:0] NewRowY;
input [12:0]   PosDX;
input [12:0]   PosDY;
input [10:0]  Row_noX;
input [10:0]  Row_noY;
input         reset;
input         DiagonalDoneX;
input         DiagonalDoneY;

output [47:0] Element;
output [12:0]  PosRowX;
output [12:0]  PosRowY;
output [1:0]   FoundX;
output [1:0]   FoundY;
output         WireX;
output         WireY;
//output        ChangeOccured;

reg [47:0] Element;
reg [12:0]  PosRowX;
reg [12:0]  PosRowY;
//reg        //NewRowFetchX;
//reg        //NewRowFetchY;
reg [1:0]  FoundX;
reg [1:0]  FoundY;
reg        WireX;
reg        WireY;
//reg        ChangeOccured;

reg PosX1, PosX2, PosX3, PosX4;
reg PosY1, PosY2, PosY3, PosY4;

always@(posedge clock)
begin
	if (reset || EnableChange)
	begin
		FoundX <= 2'b00;
		FoundY <= 2'b00;
		Element <= 48'hx;
	end

	if (DiagonalDoneX == 1'b1 && FoundX == 2'b00)
	begin
		//ChangeOccured = 1'b1;
		//PosX1 = 1'b0; PosX2 = 1'b0; PosX3 = 1'b0; PosX4 = 1'b0;
		FoundX <= 2'b01;
		if (PosDX[1:0] == 2'b00)
		begin
			if (NewRowX[191:176] == Y)
			begin
				Element <= NewRowX[175:128];
				PosRowX[12:2] <= Row_noX;
				PosRowX[1:0] <= 2'b01; 
				FoundX <= 2'b10;
			end
			if (NewRowX[127:112] == Y)
			begin
				Element <= NewRowX[111:64];
				PosRowX[12:2] <= Row_noX;				
				PosRowX[1:0] <= 2'b10;
				FoundX <= 2'b10;
			end
			if (NewRowX[63:48] == Y)
			begin
				Element <= NewRowX[47:0];
				PosRowX[12:2] <= Row_noX;
				PosRowX[1:0] <= 2'b11;
				FoundX <= 2'b10;
			end
		end

		if (PosDX[1:0] == 2'b01)
		begin
			if (NewRowX[127:112] == Y)
			begin
				Element <= NewRowX[111:64];
				PosRowX[12:2] <= Row_noX;				
				PosRowX[1:0] <= 2'b10;
				FoundX <= 2'b10;
			end
			if (NewRowX[63:48] == Y)
			begin
				Element <= NewRowX[47:0];
				PosRowX[12:2] <= Row_noX;
				PosRowX[1:0] <= 2'b11;
				FoundX <= 2'b10;
			end
		end

		if (PosDX[1:0] == 2'b10)
		begin
			if (NewRowX[63:48] == Y)
			begin
				Element <= NewRowX[47:0];
				PosRowX[12:2] <= Row_noX;
				PosRowX[1:0] <= 2'b11;
				FoundX <= 2'b10;
			end
		end
	end

	if (DiagonalDoneX == 1'b1 && FoundX == 2'b01)
	begin
		//PosX1 = 1'b0; PosX2 = 1'b0; PosX3 = 1'b0; PosX4 = 1'b0;
		if (NewRowX[255:240] == Y)
		begin
			Element <= NewRowX[239:192];
			PosRowX[12:2] <= Row_noX;
			PosRowX[1:0] <= 2'b00;
			FoundX <= 2'b10;
		end
		if (NewRowX[191:176] == Y)
		begin
			Element <= NewRowX[175:128];
			PosRowX[12:2] <= Row_noX;
			PosRowX[1:0] <= 2'b01; 
			FoundX <= 2'b10;
		end
		if (NewRowX[127:112] == Y)
		begin
			Element <= NewRowX[111:64];
			PosRowX[12:2] <= Row_noX;				
			PosRowX[1:0] <= 2'b10;
			FoundX <= 2'b10;
		end
		if (NewRowX[63:48] == Y)
		begin
			Element <= NewRowX[47:0];
			PosRowX[12:2] <= Row_noX;
			PosRowX[1:0] <= 2'b11;
			FoundX <= 2'b10;
		end

	end
//--------------------------------------------------------------------------------------------------------------------------------//

	if (DiagonalDoneY == 1'b1 && FoundY == 2'b00)
	begin
		//ChangeOccured = 1'b1;
		//PosY1 = 1'b0; PosY2 = 1'b0; PosY3 = 1'b0; PosY4 = 1'b0;
		FoundY <= 2'b01;
		if (PosDY[1:0] == 2'b00)
		begin
			if (NewRowY[191:176] == X)
			begin
				Element <= NewRowY[175:128];
				PosRowY[12:2] <= Row_noY;
				PosRowY[1:0] <= 2'b01; 
				FoundY <= 2'b10;
			end
			if (NewRowY[127:112] == X)
			begin
				Element <= NewRowY[111:64];
				PosRowY[12:2] <= Row_noY;				
				PosRowY[1:0] <= 2'b10;
				FoundY <= 2'b10;
			end
			if (NewRowY[63:48] == X)
			begin
				Element <= NewRowY[47:0];
				PosRowY[12:2] <= Row_noY;
				PosRowY[1:0] <= 2'b11;
				FoundY <= 2'b10;
			end
		end

		if (PosDY[1:0] == 2'b01)
		begin
			if (NewRowY[127:112] == X)
			begin
				Element <= NewRowY[111:64];
				PosRowY[12:2] <= Row_noY;				
				PosRowY[1:0] <= 2'b10;
				FoundY <= 2'b10;
			end
			if (NewRowY[63:48] == X)
			begin
				Element <= NewRowY[47:0];
				PosRowY[12:2] <= Row_noY;
				PosRowY[1:0] <= 2'b11;
				FoundY <= 2'b10;
			end
		end

		if (PosDY[1:0] == 2'b10)
		begin
			if (NewRowY[63:48] == X)
			begin
				Element <= NewRowY[47:0];
				PosRowY[12:2] <= Row_noY;
				PosRowY[1:0] <= 2'b11;
				FoundY <= 2'b10;
			end
		end
	end

	if (DiagonalDoneY == 1'b1 && FoundY == 2'b01)
	begin
		//PosY1 = 1'b0; PosY2 = 1'b0; PosY3 = 1'b0; PosY4 = 1'b0;
		if (NewRowY[255:240] == X)
		begin
			Element <= NewRowY[239:192];
			PosRowY[12:2] <= Row_noY;
			PosRowY[1:0] <= 2'b00;
			FoundY <= 2'b10;
		end
		if (NewRowY[191:176] == X)
		begin
			Element <= NewRowY[175:128];
			PosRowY[12:2] <= Row_noY;
			PosRowY[1:0] <= 2'b01; 
			FoundY <= 2'b10;
		end
		if (NewRowY[127:112] == X)
		begin
			Element <= NewRowY[111:64];
			PosRowY[12:2] <= Row_noY;				
			PosRowY[1:0] <= 2'b10;
			FoundY <= 2'b10;
		end
		if (NewRowY[63:48] == X)
		begin
			Element <= NewRowY[47:0];
			PosRowY[12:2] <= Row_noY;
			PosRowY[1:0] <= 2'b11;
			FoundY <= 2'b10;
		end

	end
end
always@(*)
begin
	WireX = 1'b0;
	WireY = 1'b0;
	if (DiagonalDoneX == 1'b1 && FoundX == 2'b00)
		WireX = 1'b1;
	else if (FoundX == 2'b01 || FoundX == 2'b10)
		WireX = 1'b0;
	if (DiagonalDoneY == 1'b1 && FoundY == 2'b00)
		WireY = 1'b1;
	else if (FoundY == 2'b01 || FoundY == 2'b10)
		WireY = 1'b0;
		
end


/*
always@(*)
begin
	FoundX = 1'bx;
	FoundY = 1'bx;
	if (EnableColX == 1'b1 && NewRowFetchX == 1'b0)
	begin
		//ChangeOccured = 1'b1;
		//PosX1 = 1'b0; PosX2 = 1'b0; PosX3 = 1'b0; PosX4 = 1'b0;
		if (PosDX == 2'b00)
		begin
			if (NewRowX[191:176] == Y)
			begin
				FoundX = 1'b1;
			end
			else if (NewRowX[127:112] == Y)
			begin
				FoundX = 1'b1;
			end
			else if (NewRowX[63:48] == Y)
			begin
				FoundX = 1'b1;
			end
			else
				FoundX = 1'b0;
		end

		else if (PosDX == 2'b01)
		begin
			if (NewRowX[127:112] == Y)
			begin
				FoundX = 1'b1;
			end
			else if (NewRowX[63:48] == Y)
			begin
				FoundX = 1'b1;
			end
			else
				FoundX = 1'b0;
		end

		else if (PosDX == 2'b10)
		begin
			if (NewRowX[63:48] == Y)
			begin
				FoundX = 1'b1;
			end
			else
				FoundX = 1'b0;
		end
	end

	else if (EnableColX == 1'b1 && NewRowFetchX == 1'b1 )
	begin
		//PosX1 = 1'b0; PosX2 = 1'b0; PosX3 = 1'b0; PosX4 = 1'b0;
		if (NewRowX[255:240] == Y)
		begin
				FoundX = 1'b1;
		end
		else if (NewRowX[191:176] == Y)
		begin
				FoundX = 1'b1; 
		end
		else if (NewRowX[127:112] == Y)
		begin
				FoundX = 1'b1;
		end
		else if (NewRowX[63:48] == Y)
		begin
				FoundX = 1'b1;
		end
		else
				FoundX = 1'b0;

	end

	if (EnableColY == 1'b1 && NewRowFetchY == 1'b0)
	begin
		//ChangeOccured = 1'b1;
		//PosY1 = 1'b0; PosY2 = 1'b0; PosY3 = 1'b0; PosY4 = 1'b0;
		if (PosDY == 2'b00)
		begin
			if (NewRowY[191:176] == X)
			begin
				FoundY = 1'b1;
			end
			if (NewRowY[127:112] == X)
			begin
				FoundY = 1'b1;
			end
			if (NewRowY[63:48] == X)
			begin
				FoundY = 1'b1;
			end
			else
				FoundY = 1'b0;
		end

		if (PosDY == 2'b01)
		begin
			if (NewRowY[127:112] == X)
			begin
				FoundY = 1'b1;
			end
			if (NewRowY[63:48] == X)
			begin
				FoundY = 1'b1;
			end
			else
				FoundY = 1'b0;
		end

		if (PosDY == 2'b10)
		begin
			if (NewRowY[63:48] == X)
			begin
				FoundY = 1'b1;
			end
			else
				FoundY = 1'b0;
		end
	end

	if (EnableColY == 1'b1 && NewRowFetchY == 1'b1 )
	begin
		//PosY1 = 1'b0; PosY2 = 1'b0; PosY3 = 1'b0; PosY4 = 1'b0;
		if (NewRowY[255:240] == X)
		begin
				FoundY = 1'b1;
		end
		if (NewRowY[191:176] == X)
		begin
				FoundY = 1'b1; 
		end
		if (NewRowY[127:112] == X)
		begin
				FoundY = 1'b1;
		end
		if (NewRowY[63:48] == X)
		begin
				FoundY = 1'b1;
		end
		else
				FoundY = 1'b0;

	end
end*/
/*
always@(posedge clock)
begin
	if (EnableColX == 1'b1)
	begin



		case ({PosX1, PosX2, PosX3, PosX4})
		4'b0000: begin
				////NewRowFetchX = 1'b1;
				//FoundX <= 1'b0;
			 end
		4'b1000: begin
				////NewRowFetchX = 1'b0;
				//FoundX <= 1'b1;
				Element <= NewRowX[239:192];
				PosRowX[18:8] <= Row_noX;
				PosRowX[7:0] <= 8'd239;
			 end
		4'b0100: begin
				////NewRowFetchX = 1'b0;
				//FoundX <= 1'b1;
				Element <= NewRowX[175:128];
				PosRowX[18:8] <= Row_noX;
				PosRowX[7:0] <= 8'd175; 
			 end
		4'b0010: begin
				////NewRowFetchX = 1'b0;
				//FoundX <= 1'b1;
				Element <= NewRowX[111:64];
				PosRowX[18:8] <= Row_noX;				
				PosRowX[7:0] <= 8'd111;
			 end
		4'b0001: begin
				//NewRowFetchX = 1'b0;
				//FoundX <= 1'b1;
				Element <= NewRowX[47:0];
				PosRowX[18:8] <= Row_noX;
				PosRowX[7:0] <= 8'd47;
			 end
		endcase
	end

	if (EnableColY == 1'b1)
	begin



		case ({PosY1, PosY2, PosY3, PosY4})
		4'b0000: begin
				////NewRowFetchY = 1'b1;
				//FoundY <= 1'b0;
			 end
		4'b1000: begin
				////NewRowFetchY = 1'b0;
				//FoundY <= 1'b1;
				Element <= NewRowY[239:192];
				PosRowY[18:8] <= Row_noY;
				PosRowY[7:0] <= 8'd239;
			 end
		4'b0100: begin
				////NewRowFetchY = 1'b0;
				//FoundY <= 1'b1;
				Element <= NewRowY[175:128];
				PosRowY[18:8] <= Row_noY;
				PosRowY[7:0] <= 8'd175; 
			 end
		4'b0010: begin
				////NewRowFetchY = 1'b0;
				//FoundY <= 1'b1;
				Element <= NewRowY[111:64];
				PosRowY[18:8] <= Row_noY;				
				PosRowY[7:0] <= 8'd111;
			 end
		4'b0001: begin
				//NewRowFetchY = 1'b0;
				//FoundY <= 1'b1;
				Element <= NewRowY[47:0];
				PosRowY[18:8] <= Row_noY;
				PosRowY[7:0] <= 8'd47;
			 end
		endcase
	end
end*/

endmodule

