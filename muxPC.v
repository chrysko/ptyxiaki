module muxPC(input [25:0]in1, input[25:0]in2, input [31:0]in3, input [31:0]in4, input [5:0]op, output[31:0]out);

wire [31:0]case1 = (op==mips.Jop) ? in1<<2 : 0;
wire [31:0]case2 = (op==mips.JALop) ? in2<<2: 0;
wire [31:0]case3 = (op==mips.ALUop && mips.IDEXIR[5:0]==8) ? in3 : 0;
wire [31:0]case4 = (op!=mips.Jop && op!=mips.JALop && (op!=mips.ALUop || mips.IDEXIR[5:0]!=8)) ? in4 +4 : 0;

assign out = case1 | case2 | case3 | case4;

endmodule
