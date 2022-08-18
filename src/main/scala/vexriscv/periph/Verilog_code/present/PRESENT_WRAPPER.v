
module PRESENT_WRAPPER(
        output	reg	[31:0]	odat,   
		input				clk,
		input				iReset,
        input		[31:0]	idat,   
        input				iChipselect_n,    
        input				iWrite_n,   
        input				iRead_n,    
		input		[3:0]	iAddress
);

/*Address:
	0000:	load: 0x0
	1000:	control: 0x8
	00xx:	iKey:0x1[79:48];0x2[47:16];0x3[15:0];
	010x:	iDat: 0x4;0x5
	001x:	oData:0x6;0x7
*/
wire	[63:0]	odreg;
reg				reset_n;
reg		[63:0]	data;
reg		[79:0]	iKey;
reg				load;
reg				control;
wire			done;

always@(posedge clk or posedge iReset)
begin
	if(iReset)
	begin
		odat <=32'b0;
		reset_n <= ~iReset;
	end
	else
	begin
		if(~iChipselect_n)
		begin
			reset_n <=1'b1;
		//input
			if(~iWrite_n)
			begin
				odat <=32'b0;
				case(iAddress[3:0])
				//load
					4'd0:	load <=idat[0];
				//KEY
					4'd3:	iKey[79:48] <= idat;
					4'd2:	iKey[47:16]	<= idat;
					4'd1:	iKey[15:0]	<= idat[15:0];
				//iData
					4'd5:	data[63:32] <= idat;
					4'd4:	data[31:0]	<= idat;
				//control encrypt or decrypt
					4'd8:	control <= idat[0];
					default:
					begin
					end
				endcase
			end
			else
		//ouput
			begin
				load <= 1'b0;
				if(~iRead_n)
					case(iAddress[3:0])
						4'd7:	odat <= odreg[63:32];
						4'd6:	odat <= odreg[31:0];
						default:
						begin
						end
					endcase	
				else
					odat <= odat;
			end	
		end
		else
			odat <=odat;
	end
end

PRESENT_CORE dut(.odat(odreg),.iReset_n(reset_n),.idat(data),.key(iKey),.load(load),.clk(clk),.control(control),.done(done));
endmodule
