module BranchPrediction(input [5:0]op, input [1:0]fa, input [1:0]fb, output takebranch);

assign test1 = (fa==2'b00)? mips.regOut1:
                (fa==2'b01)?  mips.MEMWBValue:
                (fa==2'b10)?  mips.EXMEMALUOut : 0;

assign test2 = (fb==2'b00)? mips.regOut2:
                (fb==2'b01)?  mips.MEMWBValue:
                (fb==2'b10)?  mips.EXMEMALUOut : 1;


assign takebranch = (op==mips.BEQ && test1==test2);


endmodule
