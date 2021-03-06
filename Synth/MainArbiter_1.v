module MainArbiter_1 (reset, clock, EnableChange, Update_1Req1, Update_1Req2, Update_2Req1, Update_2Req2, Row1, Row2, OutputReq1, OutputReq2, Output_1Row1, Output_1Row2, Output_2Row1, Output_2Row2, FlagX, FlagY, DiagonalDoneX, DiagonalDoneY, WE, PosDX, PaddedRow, WriteReq, WriteBus, NewDiagonalX, NewDiagonalY, NewElement, ArbiterElement, ArbiterPos, OutputPaddedRow, PosDY, PosRowX, PosRowY, ComputeReq, OutputCompute, CompStart,EOC_Flag);

input         reset;
input         clock;
input         EnableChange;
input [10:0]  Update_1Req1;
input [10:0]  Update_1Req2;
input [10:0]  Update_2Req1;
input [10:0]  Update_2Req2;
input [10:0]  ComputeReq;
input [255:0] Row1;
input [255:0] Row2;
input [255:0] PaddedRow;
input [12:0]  PosDX;
input [12:0]  PosDY;
input [12:0]  PosRowX;
input [12:0]  PosRowY;
input [47:0]  NewDiagonalX;
input [47:0]  NewDiagonalY;
input [47:0]  NewElement;
input         DiagonalDoneX;
input         DiagonalDoneY;
input 	      EOC_Flag;

output [10:0] OutputReq1;
output [10:0] OutputReq2;
output [10:0] WriteReq;
output [255:0] WriteBus;
output [255:0] Output_1Row1;
output [255:0] Output_1Row2;
output [255:0] Output_2Row1;
output [255:0] Output_2Row2;
output [255:0] OutputPaddedRow;
output [255:0] OutputCompute;
output [47:0]  ArbiterElement;
output [12:0]  ArbiterPos;
output         FlagX;
output         FlagY;
output         WE;
output         CompStart;

reg    [10:0]  OutputReq1;
reg    [10:0]  OutputReq2;
reg    [10:0]  WriteReq;
reg    [255:0] WriteBus;
reg    [255:0] Output_1Row1;
reg    [255:0] Output_1Row2;
reg    [255:0] Output_2Row1;
reg    [255:0] Output_2Row2;
reg    [255:0] OutputPaddedRow;
reg    [255:0] OutputCompute;
reg    [47:0]  ArbiterElement;
reg    [12:0]  ArbiterPos;
reg            FlagX;
reg            FlagY;
reg            WE;
reg            CompStart;

parameter [3:0] S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010,
		S3 = 4'b0011, S4 = 4'b0100, S5 = 4'b0101,
		S6 = 4'b0110, S7 = 4'b0111, S8 = 4'b1000,
		S9 = 4'b1001;

reg    [3:0] current_state, next_state;

always@(posedge clock)
begin
	if (reset)
		current_state <= S0;
	else
		current_state <= next_state;
end

always@(*)
begin
	OutputReq1 = 11'bxx;
	OutputReq2 = 11'bxx;
	Output_1Row1 = 256'hxx;
	Output_1Row2 = 256'hxx;
	Output_2Row1 = 256'hxx;
	Output_2Row2 = 256'hxx;
	OutputCompute = 256'hxx;
	FlagX = 1'b0;
	FlagY = 1'b0;
	ArbiterElement = 48'hxx;
	ArbiterPos = 19'hxx;
	OutputPaddedRow = 256'hxx;
	WE = 1'b0;
	WriteReq = 19'hxx;
	WriteBus = 256'hxx;
	CompStart = 1'bx;
	//Output_4XRow1 = 255'hxx;
	//Output_4XRow2 = 255'hxx;
	//Output_4YRow1 = 255'hxx;
	//Output_4YRow2 = 255'hxx;
	

	next_state = S0;

	case (current_state)
	S0: begin
		OutputReq1 = 11'bxx;
		OutputReq2 = 11'bxx;
		Output_1Row1 = 256'hxx;
		Output_1Row2 = 256'hxx;
		Output_2Row1 = 256'hxx;
		Output_2Row2 = 256'hxx;
		FlagX = 1'b0;
		FlagY = 1'b0;	
		if (EnableChange == 1'b0)
			next_state = S0;
		else
			next_state = S1;
	    end

	S1: begin
		OutputReq1 = Update_1Req1;
		OutputReq2 = Update_1Req2;
		Output_1Row1 = Row1;
		Output_1Row2 = Row2;
		Output_2Row1 = 256'hxx;
		Output_2Row2 = 256'hxx;	
		FlagX = 1'b1;
		FlagY = 1'b1;
		next_state = S2;
	    end

	S2: begin
		OutputReq1 = Update_2Req1;
		OutputReq2 = Update_2Req2;
		Output_1Row1 = 256'hxx;
		Output_1Row2 = 256'hxx;
		Output_2Row1 = Row1;
		Output_2Row2 = Row2;
		FlagX = 1'b0;
		FlagY = 1'b0;
		if (DiagonalDoneX)			
			next_state = S3;
		else 
			next_state = S2;
	    end

	S3: begin
		OutputReq1 = PosDX[12:2];
		//OutputReq2 = Update_4YReq2;
		ArbiterElement = NewDiagonalX;
		ArbiterPos = PosDX[12:0];
		OutputPaddedRow = Row1;
		WE = 1'b1;
		WriteReq = PosDX[12:2];
		WriteBus = PaddedRow;		
		//Output_4YRow2 = Row2;
		//if (DoneY)
		//	next_state = S7;
		//else
		if (DiagonalDoneY)
			next_state = S4;
		else
			next_state = S3;
	    end
	
	S4: begin
		OutputReq1 = PosDY[12:2];
		//OutputReq2 = Update_4YReq2;
		ArbiterElement = NewDiagonalY;
		ArbiterPos = PosDY[12:0];
		OutputPaddedRow = Row1;
		WE = 1'b1;
		WriteReq = PosDY[12:2];
		WriteBus = PaddedRow;		
		//Output_4YRow2 = Row2;
		//if (DoneY)
		//	next_state = S7;
		//else
		if (PosRowX)
			next_state = S5;
		else
			next_state = S4;
	    end

	S5: begin
		OutputReq1 = PosRowX[12:2];
		//OutputReq2 = Update_4YReq2;
		ArbiterElement = NewElement;
		ArbiterPos = PosRowX[12:0];
		OutputPaddedRow = Row1;
		WE = 1'b1;
		WriteReq = PosRowX[12:2];
		WriteBus = PaddedRow;
		if (PosRowY)		
			next_state = S6;
		else
			next_state = S5;
	    end 

	S6: begin
		OutputReq1 = PosRowY[12:2];
		//OutputReq2 = Update_4YReq2;
		ArbiterElement = NewElement;
		ArbiterPos = PosRowY[12:0];
		OutputPaddedRow = Row1;
		WE = 1'b1;
		WriteReq = PosRowY[12:2];
		WriteBus = PaddedRow;
		next_state = S7;
	    end
	S7: begin
		WE = 1'b1;
		next_state = S8;
	    end

	S8: begin
		OutputReq1 = ComputeReq;
		OutputCompute = Row1;	
		CompStart = 1'b1;
		next_state = S9;
	    end

	S9: begin
		OutputReq1 = ComputeReq;
		OutputCompute = Row1;
		CompStart = 1'b0;
		if(EOC_Flag)
		begin
			next_state = S0;
		//	EnableChange = 1'b1;
		end
		else
			next_state = S9;
	    end

	endcase
end

endmodule
