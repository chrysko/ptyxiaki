module mux2x1_5bit(input [4:0]in1,input [4:0]in2, output [4:0] out, input [5:0]choice);
wire case1, case2, case3, case4;

//aluop kai rd
assign case1 = choice==mips.ALUop && in1!=0;
//add_imm kai rd
assign case2 = choice==mips.ADD_IMM && in1!=0;
//load kai rd
assign case3 = choice==mips.LW && in2!=0;
//JALop
assign case4 = choice==mips.JALop;

//final assign
assign out = case1 ? in1 : 
             case2 ? in1: 
             case3 ? in2: 
             case4 ? 31 : 0; 

endmodule
