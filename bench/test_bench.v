// Module     : test_bench                                                            
// Description: Test syntax
// Brian Tremaine 
// May 10, 2016
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`include "..\include\timescale.v"
`include "..\include\defines.v"
//-----------------------------------------------------------------------
module  test_bench;

reg [12:0] count;
reg [12:0] count2;
reg rstn;
reg clk_in;
reg [12:0] m;

wire out;
wire out2;

assign out = (count<500)? 1'b1 : 1'b0;
assign out2 = (count2<500)? 1'b1 : 1'b0;

always begin
     #10 clk_in = !clk_in;     	// ~50.0MHz
end

always @ (posedge clk_in, posedge rstn) begin
   if(~rstn)
      count <= 0;
   else  begin
	if (count != 0)
	   count <= count -1;
      else
	   count <= 1000;
   end
end

always @ (posedge clk_in, posedge rstn) begin
   if(~rstn)
      count2 <= 0;
   else  begin
	if (count2 != 0)
	   count2 <= count2 -1;
      else
	   count2 <= 1000 + m;
   end
end


	

initial begin

       `ifdef Veritak
        $dumpvars;
       `endif

#0   rstn = 0;
#25 clk_in = 0;
#50 m = 0;
#50 rstn = 1;

#114_000 m= 400;
#160_000 m=0;


#1000_000 $finish;
end

endmodule