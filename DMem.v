module DMem(input clock, input wire [5:0]op, input [31:0]address, input [31:0]writevalue, output [31:0]readvalue);
reg DMemory[0:1023];

assign readvalue = DMemory[address>>2];

always @ (posedge clock) begin 
	if (op == mips.SW) begin
  		DMemory[address>>2] <= writevalue;
  	end
end

endmodule
