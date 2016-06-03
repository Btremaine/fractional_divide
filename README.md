# README #

Shown here is the derivation of the equation for a fractional divider (FD) and the verilog code implementation. This code has been tested to work on a Spartan 3AN.

The purpose of this FD is to give higher resolution in a digital PLL without increasing the clock frequency. A common divider will have an output frequency of fref= fosc/N. The small signal gain using this as a VCO is df/dN = -fosc/N^2 = -fref/N.

The basis of this derivation comes from a TI Technical Brief SWRA029. The basic principal is to count N+1 counts for m cycles and N counts for M-m cycles. The total number of counts is the sum {(N+1)*m + N*(M-m)} and the total cycles are m + (M-m) = M. From this simple equation the average counts per cycle is Nbar = N + m/M.

Now the output frequency is fref = fosc/Nbar = fosc/(N +m/M) = (fosc/N)*1/(1 + m/(N*M)). Because the term m/(N*M) is much smaller than 1 this can be approximated as fref = (fosc/N)*(1 - m/(N*M)). Remember 1/(1+x) ~= (1-x) for x<< 1.

Now the samll signal gain of the VCO is df/dm = -(fosc/N)/(N*M) = -fref/(N*M). We have increased the resolution by a factor of M.

In the verilog code this is parameterized by the constant fsze. Using fsze= 3 (bits) we have M=8. In effect we are using the input divided as a integer with fractional bits, yyyy.xxx.

The verilog implementation is to have two counters. The main counter is dividing by the integer count N. A second counter is down counting from M-1 and rolling over at 0. When the main counter down counts to zero it is loaded with N or N-1 depending on whether m is larger or smaller the the count in the M counter.

This code has been tested with fosc=50MHz N=68750 and fsze= 3 & 4 in a digital PLL.The code was simulated using Veritakwin and synthesized using Xilinx Project Navigator 14.7.

### Files
frac_divider.v is the primary verilog file.
Other files are for the test bench, Top_Frac_Divide.v used to test using Veritakwin simulator.

### Who do I talk to? ###

* Repo owner or admin: Brian Tremaine, Tremaine Consulting Group
* 