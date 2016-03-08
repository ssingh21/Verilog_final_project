`timescale 1ns/100ps
module test_sram;


wire EOC_Flag;
//-------------------------Update Wires--------------------------//
reg       clock;
reg	  EnableChange;
reg [15:0] X;
reg [15:0] Y;
reg        reset;
reg [47:0] NewElement;

wire [10:0] ReadAddress1;
wire [10:0] ReadAddress2;
wire [10:0] WriteReq;
wire        WE;

wire [255:0] ReadBus1;
wire [255:0] ReadBus2;
wire [255:0] WriteBus;

wire [23:0] SubOutput;
wire [23:0] AddOutput;
wire [23:0] AddInput1;
wire [23:0] AddInput2;
wire [23:0] SubInput1;
wire [23:0] SubInput2;
//----------------------------------------------------------------//

//------------------------- Computation Wires ---------------------//
//----------- VSram Connection ------------//
wire [47:0] vop1;
wire [47:0] vop2;
wire [47:0] vop3;
wire [47:0] vop4;
wire [8:0] Rowread1;
wire [8:0] Rowread2;
wire [8:0] Rowread3;
wire [8:0] Rowread4;
wire       we1, we2, we3, we4;
wire [8:0] write_addr1;
wire [8:0] write_addr2;
wire [8:0] write_addr3;
wire [8:0] write_addr4;
wire [47:0] op_reg;
//-----------------------------------------//

//----------- YSram Connection ------------//
wire  [191:0] outI;
wire [7:0] addressI;
//-----------------------------------------//

//----------- Mult Connection ------------//
wire  [47:0] multinput;
wire  [47:0] op_final;
wire [47:0] SyncMultY;
wire [47:0] SyncV;
wire [47:0] op1;
wire [47:0] subOut;
wire [47:0] Mul_In;
//-----------------------------------------//

//----------- Sub Connection ------------//
wire [47:0] dataI;
wire [47:0] delay1; 
//-----------------------------------------//

//----------- Accumulator Connection ------------//
wire [23:0] adder_out1;
wire [23:0] adder_out2;
wire [23:0] adder_out3;
wire [23:0] adder_out4;
wire [23:0] adder_out5;
wire [23:0] adder_out6;
wire [23:0] adder_out7;
wire [23:0] adder_out1_imag;
wire [23:0] adder_out2_imag;
wire [23:0] adder_out3_imag;
wire [23:0] adder_out4_imag;
wire [23:0] adder_out5_imag;
wire [23:0] adder_out6_imag;
wire [23:0] adder_out7_imag;
wire [23:0] accum_output;
wire [23:0] accum_input;
wire [23:0] adder_input;
wire [23:0] accum_output_imag;
wire [23:0] accum_input_imag;
wire [23:0] adder_input_imag;
//-----------------------------------------//

//----------- Div Connection ------------//
wire [47:0] div_output;
wire [23:0] diagonalC;
wire [23:0] diagonalD;
wire [47:0] outA; 
wire [47:0] diagOut;

//-----------------------------------------//


integer fd,sf,n1,n2,n3,n4,i,I,v_write_pointer;
reg [128*8:1] str;
reg [47:0] mask;
reg [47:0] check;
reg [15:0] XC,YC;
reg [23:0] MEM [39:0]; 
reg [47:0] vtest [999:0];

reg FLAG;
wire EOF;


//reg [255:0] ReadBus1;
//reg [255:0] ReadBus2;

initial
	begin
		v_write_pointer = $fopen("test_786.txt","w");
		fd = $fopen("change_data_secret.txt","r");
		$readmemh("change_data_secret.txt",MEM);
		n1 = 0;
		while($fgets(str,fd)) begin
			n1 = n1+1;
		end
		n1 = n1-1;
		n4 = 0;
		$fclose(fd);
		i = 0;
		reset = 1'b1;
		clock = 1'b0;
		#10 reset = 1'b0;
		
		FLAG = 1'b0;
		EnableChange = 1'b1;
		X = MEM[i];
		Y = MEM[i+1];
		NewElement[47:24] = MEM[i+2];
		NewElement[23:0] = MEM[i+3];
		i= i+4;

		
		#10 EnableChange = 1'b0;
	
		
	     /*   #1000 FLAG = 1'b1;
		#10 FLAG = 1'b0; 
	        #1000 FLAG = 1'b1;
		#10 FLAG = 1'b0;
	        #1000 FLAG = 1'b1;
		#10 FLAG = 1'b0;		
	        #1000 FLAG = 1'b1;
		#10 FLAG = 1'b0;		
	        #1000 FLAG = 1'b1;
		#10 FLAG = 1'b0;*/
		//$fclose(v_write_pointer);
	end

	always@(posedge clock)
	begin
		
	  if(n4 < n1 && EOC_Flag == 1'b1)
	  begin	
		EnableChange = 1'b1;	
		X = MEM[i];
		Y = MEM[i+1];
		NewElement[47:24] = MEM[i+2];
		NewElement[23:0] = MEM[i+3];
		i = i+4;
		n4 = n4 + 1;
	 end			
	 else if(EOC_Flag == 1'b0)
	 begin
		EnableChange = 1'b0;	
	 end	
	end
	
always@(EOC_Flag)

	begin
		if(EOC_Flag)
		begin
			//$writememh("v1.txt", a6.Register);
			//FLAG = 1'b1;
			//$writememh("v2.txt", a7.Register);
			//$writememh("v3.txt", a8.Register);
			//$writememh("v4.txt", a9.Register);		
		end
	end	
	
	always@(EOC_Flag)
        begin
   	 if(EOC_Flag)
      begin
	  $display("Writing in V%d", n4);
         for(I = 0; I < 250; I = I + 1)
           begin
	
          $fwrite(v_write_pointer, "%x",a6.Register[I]);
          $fwrite(v_write_pointer, "%x",a7.Register[I]);
          $fwrite(v_write_pointer, "%x",a8.Register[I]);
          $fwrite(v_write_pointer, "%x",a9.Register[I]);
          $fwrite(v_write_pointer, "\n");
           end
      	end
     end 



	always #5 clock = ~clock;

top_4 u1 (.clock(clock), .X(X), .Y(Y), .EnableChange(EnableChange), .reset(reset), .NewElement(NewElement), .ReadAddress1(ReadAddress1), .ReadAddress2(ReadAddress2), .WE(WE), .WriteReq(WriteReq), .WriteBus(WriteBus), .ReadBus1(ReadBus1), .ReadBus2(ReadBus2), .SubOutput(SubOutput), .AddOutput(AddOutput), .AddInput1(AddInput1), .AddInput2(AddInput2), .SubInput1(SubInput1), .SubInput2(SubInput2), .vop1(vop1), .vop2(vop2), .vop3(vop3), .vop4(vop4), .Rowread1(Rowread1), .Rowread2(Rowread2), .Rowread3(Rowread3), .Rowread4(Rowread4), .we1(we1), .we2(we2), .we3(we3), .we4(we4), .write_addr1(write_addr1), .write_addr2(write_addr2), .write_addr3(write_addr3), .write_addr4(write_addr4), .op_reg(op_reg), .outI(outI), .addressI(addressI), .SyncMultY(SyncMultY), .SyncV(SyncV), .multinput(multinput), .op1(op1), .subOut(subOut), .op_final(op_final), .dataI(dataI), .delay1(delay1), .adder_out7(adder_out7), .adder_out7_imag(adder_out7_imag), .adder_out1(adder_out1), .adder_out2(adder_out2), .adder_out1_imag(adder_out1_imag), .adder_out2_imag(adder_out2_imag),  .accum_output(accum_output), .accum_input(accum_input), .adder_input(adder_input), .accum_output_imag(accum_output_imag), .accum_input_imag(accum_input_imag), .adder_input_imag(adder_input_imag), .div_output(div_output), .diagonalC(diagonalC), .diagonalD(diagonalD), .adder_out3(adder_out3), .adder_out4(adder_out4), .adder_out3_imag(adder_out3_imag), .adder_out4_imag(adder_out4_imag),.EOC_Flag(EOC_Flag),.sig_OP(EOF),.diagOut(diagOut), .Mul_In(Mul_In));


//arith u9 (.clock(clock), .inst_a(SubInput1), .inst_b(SubInput2), .inst_rnd(3'b000), .inst_op(1'b1), .z_inst(SubOutput)); // Subtraction to get the difference

//arith u10 (.clock(clock), .inst_a(AddInput1), .inst_b(AddInput2), .inst_rnd(3'b000), .inst_op(1'b0), .z_inst(AddOutput));

/*******************************----------------------------------- Computation ---------------------------**************************************/
//---------------------------------------------------------- Memory -----------------------------------------------------------//
y_sram u2  (.clock(clock), .ReadAddress1(ReadAddress1), .ReadAddress2(ReadAddress2), .ReadBus1(ReadBus1), .ReadBus2(ReadBus2), .WE(WE), .WriteAddress(WriteReq), .WriteBus(WriteBus));
 v_sram_op1 a6 (.clock(clock), .ReadAddress1(Rowread1), .ReadBus1(vop1),.WE(we1),.WriteAddress1(write_addr1),.WriteBus1(op_reg));
 v_sram_op2 a7 (.clock(clock), .ReadAddress1(Rowread2), .ReadBus1(vop2),.WE(we2),.WriteAddress1(write_addr2),.WriteBus1(op_reg));
 v_sram_op3 a8 (.clock(clock), .ReadAddress1(Rowread3), .ReadBus1(vop3),.WE(we3),.WriteAddress1(write_addr3),.WriteBus1(op_reg));
 v_sram_op4 a9 (.clock(clock), .ReadAddress1(Rowread4), .ReadBus1(vop4),.WE(we4),.WriteAddress1(write_addr4),.WriteBus1(op_reg));
 i_sram a18(.clock(clock), .ReadAddress1(addressI),.ReadBus1(outI));
//------------------------------------------------------------------------------------------------------------------------------//

//----------------------------------------------------DesignVision (Mult)------------------------------------------------------//
 multiply2 a11(.clock(clock), .element1(SyncMultY), .element2(SyncV), .new1(multinput));
 multiply2 a23(.clock(clock), .element1(op1), .element2(Mul_In),.new1(op_final));
//----------------------------------------------------------------------------------------------------------------------------//

//----------------------------------------------------DesignVision (Sub)------------------------------------------------------//
 sub2 a19(.clock(clock), .element1(dataI), .element2(delay1),.new1(subOut));
 arith u9 (.clock(clock), .inst_a(SubInput1), .inst_b(SubInput2), .inst_rnd(3'b000), .inst_op(1'b1), .z_inst(SubOutput)); // Subtraction to get the difference

 arith u10 (.clock(clock), .inst_a(AddInput1), .inst_b(AddInput2), .inst_rnd(3'b000), .inst_op(1'b0), .z_inst(AddOutput));
//----------------------------------------------------------------------------------------------------------------------------//

//---------------------------------------------------------- Accumulator---------------------------------------------------------//
 mult_compute_1 a14 (.clock(clock), .element1(adder_out1), .element2(adder_out2),.new1(adder_out5));
 mult_compute_1 a15 (.clock(clock), .element1(adder_out3), .element2(adder_out4),.new1(adder_out6));
 mult_compute_1 a16 (.clock(clock), .element1(adder_out5), .element2(adder_out6),.new1(adder_out7));
 mult_compute_1 a28 (.clock(clock), .element1(adder_out1_imag), .element2(adder_out2_imag),.new1(adder_out5_imag));
 mult_compute_1 a29 (.clock(clock), .element1(adder_out3_imag), .element2(adder_out4_imag),.new1(adder_out6_imag));
 mult_compute_1 a30 (.clock(clock), .element1(adder_out5_imag), .element2(adder_out6_imag),.new1(adder_out7_imag));
 mult_compute_1 a32 (.clock(clock), .element1(accum_input), .element2(adder_input), .new1(accum_output));
 mult_compute_1 a13 (.clock(clock), .element1(accum_input_imag), .element2(adder_input_imag), .new1(accum_output_imag));
//------------------------------------------------------------------------------------------------------------------------------//

//----------------------------------------------------DesignVision (Div)------------------------------------------------------//
 div_compute a20 (.clock(clock), .input_buf1(diagonalC), .input_buf2(diagonalD), .element1(diagOut), .new1(div_output));
//----------------------------------------------------------------------------------------------------------------------------//
//*********************************--------------------------------------------------------------------********************************************//

endmodule
