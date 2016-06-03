// Module     : frac_divide_bench                                                            
// Description: This is the top level stimulus module for testing 
// the module frac_divide.v
// Brian Tremaine 
// May 23, 2016
//
// target hardware:
// Dev board: Aruba PSU ORT FPGA board Spartan 3AN
// Fosc = 50.0MHz
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`include "..\include\timescale.v"
`include "..\include\defines.v"
//-----------------------------------------------------------------------
module  frac_divide_bench;

// IO Ports
// --------------------------------------------------------------------------------------------------------
reg clk_in;
reg rstn;
reg [16:0] N;
reg [16:0] mf;
wire [16:0] count;

// --------------------------------------------------------------------------------------------------------
// Instantiate top level 

	frac_divider frac_divider1 (
	// inputs
	.sys_clk		(clk_in),
	.clk_in			(clk_in),
	.sync_rst_n		(rstn),			// active low reset
	.N					(N),				// integer divider
	.mf				(mf),				// fractional divide ...yyyyy.xxxx
	// outputs
	.count			(count),			// instantanious count
	.q_out			(q_out)			// output clock
	);
// ========================================================


reg sys_clk;
integer i;  

always begin
     #5 sys_clk = !sys_clk;     	// ~100.0MHz
end

always begin
     #10 clk_in = !clk_in;     	// ~50.0MHz
end


initial begin
       `ifdef Veritak
        $dumpvars;
       `endif
// bench test divide 50MHz by (68750 + 5/16) 

#0   	rstn = 0;
#50	rstn = 1;
#50 	sys_clk = 0;
#10   clk_in = 0;
#50   N= 68750;

#50 mf = -5;
for (i=0; i<20;i=i+1) begin 
#24_000_000;
#20 mf= mf + 1;
end

#200_000_000 $finish ;
end

endmodule