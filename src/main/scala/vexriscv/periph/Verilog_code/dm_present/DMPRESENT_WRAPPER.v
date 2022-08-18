module DMPRESENT_WRAPPER(           
		input		 		clk,
		input 		  		iReset,  
        input  		  		iChipselect_n,    
        input        		iWrite_n,   
        input         		iRead_n,    
		input  [2:0]		iAddress,
		input  [31:0] 		idat, 
		output reg [31:0] 	odat
);

/*Address:
	0000:	load
	00xx:	iKey: 0x1
	010x:	iDat: 0x4
	011x:	oData:0x6
*/
wire	[63:0]	odreg;
reg		reset_n;
reg	[63:0] data;
reg	[79:0]	iKey;
reg		load;
wire		done;


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
				case(iAddress[2:0])
					//load
					3'd0:	load <= idat[0];
					//key
					3'd3:	iKey[79:48] <= idat;
					3'd2:	iKey[47:16]	<= idat;
					3'd1:	iKey[15:0]	<= idat[15:0];
					//iData
					3'd5:	data[63:32] <= idat;
					3'd4:	data[31:0]	<= idat;
                    default: 
                    begin
                    end
				endcase
			end
			else
			begin
				load <= 1'b0;
				if(~iRead_n)
					case(iAddress[2:0])
						3'd7:	odat <= odreg[63:32];
						3'd6:	odat <= odreg[31:0];
                    default: 
                    begin
                    end
					endcase	
			end	
		end
	end
end

DMPRESENT dut(.odat(odreg),.iReset_n(reset_n),.idat(data),.key(iKey),.load(load),.clk(clk),.done(done));

endmodule
