module muxInB(input [5:0]op, input [5:0]aop, output [31:0]out);


wire test1 = (op==mips.LW) | (op==mips.SW) | (op == mips.ADD_IMM);
wire test2 = (op==mips.Jop);
wire test3 = (op==mips.JALop);
wire test4 = (op==mips.ALUop );

wire [31:0]case1 = (test1) ? {{16{mips.IDEXIR[15]}}, mips.IDEXIR[15:0]} : 0;
wire [31:0]case2 = (test2) ? 0 : 0;
wire [31:0]case3 = (test3) ? 0 : 0;
wire [31:0]case4 = (test4) ? mips.Bin : 0;
wire [31:0]defcase = (test1==0 && test2==0 && test3==0 && test4==0) ? 0 : 0;

assign out = case1 | case2 | case3 | case4 | defcase; 

endmodule
