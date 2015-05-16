module RegistersFile(input clock, input [31:0]writevalue, output [31:0]readvalue1, output[31:0]readvalue2, input [4:0]pos, input[4:0]pos1, input[4:0]pos2);

reg [31:0]Regs[0:31];
reg [5:0] i;
assign readvalue1 = (pos1 == 5'b0)? 32'h0: 
                    (pos1 == pos) ? writevalue : Regs[pos1];
assign readvalue2 = (pos2 == 5'b0)? 32'h0: 
                    (pos2 == pos) ? writevalue : Regs[pos2];

initial begin
    Regs[0] = 0;
    Regs[1] = 100;
	for (i = 2; i<32; i=i+1) begin
		Regs[i] = 10*i;
	end
	//Regs[5] = 54;
	//Regs[6] = 56;
end


always @ (posedge clock) begin
    //$display("Write:",pos, " :",writevalue, "READ1: ", pos1, " :", Regs[pos1], "READ2: ",pos2," :",Regs[pos2]);
    Regs[pos] <= writevalue; 
end

endmodule
