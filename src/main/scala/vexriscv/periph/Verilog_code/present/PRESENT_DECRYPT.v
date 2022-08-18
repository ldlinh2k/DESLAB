module PRESENT_DECRYPT (
        output	reg	[63:0]	odat,   
        input		[63:0]	idat,   
        input		[79:0]	key,    
        input				load,  
        input				clk, 
		input				chip_enable,
		output				reg	done
);

//---------wires, registers----------
reg  [79:0] kreg,ikreg;			// key/invKey registers              
reg  [63:0] dreg;               // data registers
reg  [4:0]  round;              // round counter
reg			Dprocess,loadD;		// control decrypt process	
wire [63:0] dat1,dat2,dat3;		// intermediate data  
wire [79:0] kdat1,kdat2;		// intermediate subkey data      
wire [79:0] ikdat1,ikdat2;		// intermediate subinvkey data

// invKey generation
assign ikdat1 = {ikreg[79:20],ikreg[19:15] ^ (5'd32-round),ikreg[14:0]}; // xor key[19:15] round
assign ikdat2[14:0] = ikdat1[75:61];  
assign ikdat2[79:19] = ikdat1[60:0 ];
INV_SBOX sBoxInvKey ( .odat(ikdat2[18:15]), .idat(ikdat1[79:76]) );

// key generation
assign kdat1        = {kreg[18:0], kreg[79:19]}; // rotate key 61 bits to the left
assign kdat2[14:0 ] = kdat1[14:0 ];
assign kdat2[19:15] = kdat1[19:15] ^ round;  // xor key[19:15] data and round counter
assign kdat2[75:20] = kdat1[75:20];
SBOX sBoxKey ( .odat(kdat2[79:76]), .idat(kdat1[79:76]) );

// add round key
assign dat1 = dreg^ikreg[79:16] ; 

//invPboxLayer
INV_PBOX pBox    ( .odat(dat2), .idat(dat1) );
// invSboxLayer
genvar i;
generate
    for (i=0; i<64; i=i+4) begin: sbox_loop
       INV_SBOX sBox( .odat(dat3[i+3:i]), .idat(dat2[i+3:i]) );
    end
endgenerate


always @(posedge clk )
begin
	if (chip_enable)
	begin
	// load/update data
		if (load)
		begin
			dreg <= idat;
			odat <= 64'h0;
		end
		else
		begin
			if (Dprocess & ~loadD)
					dreg <= dat3;	
			else 
				dreg <= dreg;
		end	
	// load/update KEY in creating invKey process
		if (load)
		    kreg <= key; 
	    else
		begin
			if (~Dprocess & ~(round==0))	
				kreg <= kdat2;
			else
				kreg <=kreg;
		end
	// load/update invKEY
		if (Dprocess)
		begin 
		   if (loadD)
			  ikreg[79:0] <= kreg[79:0];
		   else 
			  ikreg <= ikdat2;
		end
		else
			ikreg <= 80'b0;
		
	// set control variables to start decrypting process 
		if (round == 31)
		begin
			Dprocess <= ~Dprocess;
			loadD <= 1'b1;
		end
		else 
			loadD <= 1'b0;	
	// creat the control variables of decrypting process	
		if (load)
		begin
			round <= 5'd1;
			Dprocess <=1'b0;
			loadD <= 1'b0;
		end
		else 
			round <= round + 1;	
	// output 
		if (round==0 & ~Dprocess)
		begin
			odat <= dat1;
			done = 1'b1;
		end
		else
			done = 1'b0;	
	end
	else
	begin
		done = 1'b0;	
		odat <= 64'h0;
	end
end
endmodule
