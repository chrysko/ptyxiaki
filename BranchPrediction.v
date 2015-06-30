module BranchPrediction(input [5:0]op, input [1:0]fa, input [1:0]fb, output takebranch);


wire [31:0]test1, test2;
assign test1 = (fa==2'b00)? mips.regOut1:
                (fa==2'b01)?  mips.MEMWBValue: mips.EXMEMALUOut;
//                (fa==2'b10)?  mips.EXMEMALUOut : 0;

assign test2 = (fb==2'b00)? mips.regOut2:
                (fb==2'b01)?  mips.MEMWBValue: mips.EXMEMALUOut;
//                (fb==2'b10)?  mips.EXMEMALUOut : 1;


assign takebranch = (op==mips.BEQ && test1==test2);

always @ (posedge mips.clock) begin 
  // $display("OP:", op, " Test1: ", test1, " TEST2: ",test2, "BR: ",takebranch, " FA ", fa, " FB ",fb);
end
endmodule
