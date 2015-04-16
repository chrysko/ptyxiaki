module RegistersFile(input clock, input [31:0]writevalue, output [31:0]readvalue1, output[31:0]readvalue2, input [4:0]pos, input[4:0]pos1, input[4:0]pos2);

reg [31:0]Regs[0:31];
reg [5:0] i;
assign readvalue1 = (pos1 == 5'b0)? 32'h0: Regs[pos1];
assign readvalue2 = (pos2 == 5'b0)? 32'h0: Regs[pos2];

initial begin
	for (i = 0; i<32; i=i+1) begin
		Regs[i] = 10*i; //initialize registers--just so they aren�t don�t cares
	end
end


always @ (posedge clock) begin
    Regs[pos] <= writevalue; 
end

endmodule
