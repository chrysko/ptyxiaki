module Alucontroller(input [5:0]op, input [5:0]aop, output [2:0]out);

//0: error
//1: prosthesi
//2: afairesh
//3: & 
//4: |
//5: slt (tha doume mipws ginetai alliws)
wire [2:0] case1 = ((op==mips.LW) | (op==mips.SW) | (op == mips.ADD_IMM)) ? 1 : 0;
//wire [2:0] case2 = (op==mips.ALUop && aop == 32) ? 1: 0;
//wire [2:0] case3 = (op==mips.ALUop && aop == 34) ? 2: 0;
//wire [2:0] case4 = (op==mips.ALUop && aop == 36) ? 3: 0;
//wire [2:0] case5 = (op==mips.ALUop && aop == 37) ? 4: 0;
//wire [2:0] case6 = (op==mips.ALUop && aop == 42) ? 5: 0;
wire [2:0] case2 = (op!=mips.ALUop) ? 0 :
                    (aop==32) ? 1 : 
                    (aop==34) ? 2 :
                    (aop==36) ? 3 :
                    (aop==37) ? 4 :
                    (aop==42) ? 5 : 0;
wire [2:0] case7 = (op==mips.Jop) ? 1: 0;
wire [2:0] case8 = (op==mips.JALop) ? 1 : 0; 

assign out = case1 | case2 | case7 | case8;

endmodule
