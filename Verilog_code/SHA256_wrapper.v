module SHA256_wrapper(
	input	iClk,
	input	iReset,
	input	iChipselect_n,
	input	iWrite_n,
	input	iRead_n,
	input	[4:0]	iAddress,
	input	[31:0]	iData,
	output	reg	[31:0]	oData
);
reg[511:0] input_reg;
reg[255:0] output_reg;
reg status;
wire[255:0] out_256;
reg[6:0] counter;
reg input_valid;
wire iReset_n_w;
assign iReset_n_w = ~iReset;

always@(posedge iClk,negedge iReset_n_w)
begin
	if(~iReset_n_w) 
	begin
		counter<=0;
		input_valid<=0;
	end
	else if(status) counter <= counter+1;
	if(counter==1'd1) input_valid<=1; 
	else input_valid<=0;
end
always@(posedge iClk,negedge iReset_n_w)
begin
	if(~iReset_n_w)
	begin
		input_reg <= 512'b0;
		oData <= 32'b0;
		status<=0;
	end
	else if(~iChipselect_n)
	begin
		if(~iWrite_n)
		begin
			case(iAddress)
				5'h0: input_reg[511:480] <= iData;
				5'h1: input_reg[479:448] <= iData;
				5'h2: input_reg[447:416] <= iData;
				5'h3: input_reg[415:384] <= iData;
				5'h4: input_reg[383:352] <= iData;
				5'h5: input_reg[351:320] <= iData;
				5'h6: input_reg[319:288] <= iData;
				5'h7: input_reg[287:256] <= iData;
				5'h8: input_reg[255:224] <= iData;
				5'h9: input_reg[223:192] <= iData;
				5'ha: input_reg[191:160] <= iData;
				5'hb: input_reg[159:128] <= iData;
				5'hc: input_reg[127:96] <= iData;
				5'hd: input_reg[95:64] <= iData;
				5'he: input_reg[63:32] <= iData;
				5'hf: input_reg[31:0] <= iData;
				5'h10: status <=iData[0];
				default: input_reg<=0;
			endcase
		end
		else if(~iRead_n)
		begin
			case(iAddress)
				5'h0: oData <=  output_reg[255:224]; 
				5'h1: oData <=  output_reg[223:192]	;
				5'h2: oData <=  output_reg[191:160]	;
				5'h3: oData <=  output_reg[159:128];
				5'h4: oData <=  output_reg[127:96]	;
				5'h5: oData <=  output_reg[95:64]	;
				5'h6: oData <=  output_reg[63:32]	;
				5'h7: oData <=  output_reg[31:0]	;
				default: oData <=0;
			endcase
		end
	end
	else if(counter==7'd66) status<=0;
end
always@(negedge status,negedge iReset_n_w)
	if(~iReset_n_w) output_reg<=0;
	else output_reg <=out_256;

	sha256_block DUT1(
		.clk(iClk),
		.rst(iReset_n_w),
		.M_in(input_reg),
		.input_valid(input_valid),
		.H_out(out_256)
	);
endmodule // sha256_wrapper

//CUNG CAP HANG SO TRON
module sha256_K_machine (
    input clk,
    input rst,
    output [31:0] K
    );
reg [2047:0] rom_q;
wire [2047:0] rom_d = { rom_q[2015:0], rom_q[2047:2016] };
assign K = rom_q[2047:2016];

always @(posedge clk)
begin
    if (rst) begin
        rom_q <= {
            32'h428a2f98, 32'h71374491, 32'hb5c0fbcf, 32'he9b5dba5,
            32'h3956c25b, 32'h59f111f1, 32'h923f82a4, 32'hab1c5ed5,
            32'hd807aa98, 32'h12835b01, 32'h243185be, 32'h550c7dc3,
            32'h72be5d74, 32'h80deb1fe, 32'h9bdc06a7, 32'hc19bf174,
            32'he49b69c1, 32'hefbe4786, 32'h0fc19dc6, 32'h240ca1cc,
            32'h2de92c6f, 32'h4a7484aa, 32'h5cb0a9dc, 32'h76f988da,
            32'h983e5152, 32'ha831c66d, 32'hb00327c8, 32'hbf597fc7,
            32'hc6e00bf3, 32'hd5a79147, 32'h06ca6351, 32'h14292967,
            32'h27b70a85, 32'h2e1b2138, 32'h4d2c6dfc, 32'h53380d13,
            32'h650a7354, 32'h766a0abb, 32'h81c2c92e, 32'h92722c85,
            32'ha2bfe8a1, 32'ha81a664b, 32'hc24b8b70, 32'hc76c51a3,
            32'hd192e819, 32'hd6990624, 32'hf40e3585, 32'h106aa070,
            32'h19a4c116, 32'h1e376c08, 32'h2748774c, 32'h34b0bcb5,
            32'h391c0cb3, 32'h4ed8aa4a, 32'h5b9cca4f, 32'h682e6ff3,
            32'h748f82ee, 32'h78a5636f, 32'h84c87814, 32'h8cc70208,
            32'h90befffa, 32'ha4506ceb, 32'hbef9a3f7, 32'hc67178f2
        };
    end else begin
        rom_q <= rom_d;
    end
end
endmodule

// Ch(x,y,z)
module Ch #(parameter WORDSIZE=0) (
    input wire [WORDSIZE-1:0] x, y, z,
    output wire [WORDSIZE-1:0] Ch
    );

assign Ch = ((x & y) ^ (~x & z));
endmodule

// Maj(x,y,z)
module Maj #(parameter WORDSIZE=0) (
    input wire [WORDSIZE-1:0] x, y, z,
    output wire [WORDSIZE-1:0] Maj
    );

assign Maj = (x & y) ^ (x & z) ^ (y & z);
endmodule

module W_machine #(parameter WORDSIZE=1) (
    input clk,
    input [WORDSIZE*16-1:0] M,
    input M_valid,
    output [WORDSIZE-1:0] W_tm2, W_tm15,
    input [WORDSIZE-1:0] s1_Wtm2, s0_Wtm15,
    output [WORDSIZE-1:0] W
    );
reg [WORDSIZE*16-1:0] W_stack_q;
assign W_tm2 = W_stack_q[WORDSIZE*2-1:WORDSIZE*1];
assign W_tm15 = W_stack_q[WORDSIZE*15-1:WORDSIZE*14];
wire [WORDSIZE-1:0] W_tm7 = W_stack_q[WORDSIZE*7-1:WORDSIZE*6];
wire [WORDSIZE-1:0] W_tm16 = W_stack_q[WORDSIZE*16-1:WORDSIZE*15];
wire [WORDSIZE-1:0] Wt_next = s1_Wtm2 + W_tm7 + s0_Wtm15 + W_tm16;

wire [WORDSIZE*16-1:0] W_stack_d = {W_stack_q[WORDSIZE*15-1:0], Wt_next};
assign W = W_stack_q[WORDSIZE*16-1:WORDSIZE*15];

always @(posedge clk)
begin
    if (M_valid) begin
        W_stack_q <= M;
    end else begin
        W_stack_q <= W_stack_d;
    end
end
endmodule

//Tinh s0 (de tinh chi muc zero-ed cuoi mang W[i])
module sha256_s0 (
    input wire [31:0] x,
    output wire [31:0] s0
   );
assign s0 = ({x[6:0], x[31:7]} ^ {x[17:0], x[31:18]} ^ (x >> 3));
endmodule

//Tinh s1 (de tinh chi muc zero-ed cuoi mang W[i])
module sha256_s1 (
    input wire [31:0] x,
    output wire [31:0] s1
    );
assign s1 = ({x[16:0], x[31:17]} ^ {x[18:0], x[31:19]} ^ (x >> 10));
endmodule

// NEN VONG
module sha2_round #(
    parameter WORDSIZE=0
) (
    input [WORDSIZE-1:0] Kj, Wj,
    input [WORDSIZE-1:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in,
    input [WORDSIZE-1:0] Ch_e_f_g, Maj_a_b_c, S0_a, S1_e,
    output [WORDSIZE-1:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out
    );

wire [WORDSIZE-1:0] T1 = h_in + S1_e + Ch_e_f_g + Kj + Wj;
wire [WORDSIZE-1:0] T2 = S0_a + Maj_a_b_c;

assign a_out = T1 + T2;
assign b_out = a_in;
assign c_out = b_in;
assign d_out = c_in;
assign e_out = d_in + T1;
assign f_out = e_in;
assign g_out = f_in;
assign h_out = g_in;
endmodule

module sha256_S0 (
    input wire [31:0] x,
    output wire [31:0] S0
    );
assign S0 = ({x[1:0], x[31:2]} ^ {x[12:0], x[31:13]} ^ {x[21:0], x[31:22]});
endmodule

module sha256_S1 (
    input wire [31:0] x,
    output wire [31:0] S1
    );
assign S1 = ({x[5:0], x[31:6]} ^ {x[10:0], x[31:11]} ^ {x[24:0], x[31:25]});
endmodule

//1 vong BAM (bam  tong cong 6 lan thi dc kq ma hoa 256 bit voi input la 512 bit )
module sha256_round (
    input [31:0] Kj, Wj,
    input [31:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in,
    output [31:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out
    );
wire [31:0] Ch_e_f_g, Maj_a_b_c, S0_a, S1_e;

Ch #(.WORDSIZE(32)) Ch (
    .x(e_in), .y(f_in), .z(g_in), .Ch(Ch_e_f_g)
);

Maj #(.WORDSIZE(32)) Maj (
    .x(a_in), .y(b_in), .z(c_in), .Maj(Maj_a_b_c)
);

sha256_S0 S0 (
    .x(a_in), .S0(S0_a)
);

sha256_S1 S1 (
    .x(e_in), .S1(S1_e)
);

sha2_round #(.WORDSIZE(32)) sha256_round_inner (
    .Kj(Kj), .Wj(Wj),
    .a_in(a_in), .b_in(b_in), .c_in(c_in), .d_in(d_in),
    .e_in(e_in), .f_in(f_in), .g_in(g_in), .h_in(h_in),
    .Ch_e_f_g(Ch_e_f_g), .Maj_a_b_c(Maj_a_b_c), .S0_a(S0_a), .S1_e(S1_e),
    .a_out(a_out), .b_out(b_out), .c_out(c_out), .d_out(d_out),
    .e_out(e_out), .f_out(f_out), .g_out(g_out), .h_out(h_out)
);
endmodule


module sha256_block (
    input clk, rst,
    input [511:0] M_in,
    input input_valid,
    output [255:0] H_out//output
    );

reg [6:0] round;
wire [31:0] a_in = 32'h6A09E667, b_in = 32'hBB67AE85, c_in = 32'h3C6EF372, d_in = 32'hA54FF53A;
wire [31:0] e_in = 32'h510E527F, f_in = 32'h9B05688C, g_in = 32'h1F83D9AB, h_in = 32'h5BE0CD19;
reg [31:0] a_q, b_q, c_q, d_q, e_q, f_q, g_q, h_q;
wire [31:0] a_d, b_d, c_d, d_d, e_d, f_d, g_d, h_d;
wire [31:0] W_tm2, W_tm15, s1_Wtm2, s0_Wtm15, Wj, Kj;
 
assign H_out = {
    a_in + a_q, b_in + b_q, c_in + c_q, d_in + d_q, e_in + e_q, f_in + f_q, g_in + g_q, h_in + h_q
};

always @(posedge clk)
begin
    if (input_valid) begin
        a_q <= a_in; b_q <= b_in; c_q <= c_in; d_q <= d_in;
        e_q <= e_in; f_q <= f_in; g_q <= g_in; h_q <= h_in;
        round <= 0;
    end else begin
        a_q <= a_d; b_q <= b_d; c_q <= c_d; d_q <= d_d;
        e_q <= e_d; f_q <= f_d; g_q <= g_d; h_q <= h_d;
        round <= round + 1;
    end
end

sha256_round sha256_round (
    .Kj(Kj), .Wj(Wj),
    .a_in(a_q), .b_in(b_q), .c_in(c_q), .d_in(d_q),
    .e_in(e_q), .f_in(f_q), .g_in(g_q), .h_in(h_q),
    .a_out(a_d), .b_out(b_d), .c_out(c_d), .d_out(d_d),
    .e_out(e_d), .f_out(f_d), .g_out(g_d), .h_out(h_d)
);

sha256_s0 sha256_s0 (.x(W_tm15), .s0(s0_Wtm15));
sha256_s1 sha256_s1 (.x(W_tm2), .s1(s1_Wtm2));

W_machine #(.WORDSIZE(32)) W_machine (
    .clk(clk),
    .M(M_in), .M_valid(input_valid),
    .W_tm2(W_tm2), .W_tm15(W_tm15),
    .s1_Wtm2(s1_Wtm2), .s0_Wtm15(s0_Wtm15),
    .W(Wj)
);

sha256_K_machine sha256_K_machine (
    .clk(clk), .rst(input_valid), .K(Kj)
);
endmodule
