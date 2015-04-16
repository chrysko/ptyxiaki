module muxAlu(input [31:0]in1, input [31:0]in2, input [31:0]in3, input [31:0]in4, input [5:0]op, output [31:0]out);

wire [31:0]case1 = ((op==mips.LW) | (op==mips.SW) | (op == mips.ADD_IMM)) ? in1 : 0;
wire [31:0]case2 = (op==mips.Jop) ? in2: 0;
wire [31:0]case3 = (op==mips.JALop) ? in3 : 0;
wire [31:0]case4 = (op==mips.ALUop ) ? in4 : 0;
wire [31:0]defcase = ((case1==0 && case2==0 && case3==0 && case4==0)) ? in2 : 0; 

assign out = case1 | case2 | case3 | case4 | defcase;


endmodule



