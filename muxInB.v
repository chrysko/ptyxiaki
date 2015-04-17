module muxInB(input [5:0]op, input [5:0]aop, input [1:0]fb,  output [31:0]out);


wire test1 = (op==mips.LW) | (op==mips.SW) | (op == mips.ADD_IMM);
wire test2 = (op==mips.Jop);
wire test3 = (op==mips.JALop);
wire test41 = (op==mips.ALUop && fb==2'b00);
wire test42 = (op==mips.ALUop && fb==2'b01);
wire test43 = (op==mips.ALUop && fb==2'b10);

wire [31:0]case1 = (test1) ? {{16{mips.IDEXIR[15]}}, mips.IDEXIR[15:0]} : 0;
wire [31:0]case2 = (test2) ? 0 : 0;
wire [31:0]case3 = (test3) ? 0 : 0;
wire [31:0]case41 = (test41) ? mips.IDEXB : 0;
wire [31:0]case42 = (test42) ? mips.MEMWBValue : 0;
wire [31:0]case43 = (test43) ? mips.EXMEMALUOut : 0;

wire [31:0]defcase = (test1==0 && test2==0 && test3==0 && test41==0 && test42==0 && test43==0) ? 0 : 0;

assign out = case1 | case2 | case3 | case41| case42| case43 | defcase; 

endmodule
