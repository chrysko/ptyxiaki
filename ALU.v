module ALU(input wire [2:0]op, input wire [31:0]in1, input wire [31:0] in2, output [31:0]out);

wire [31:0]case0 = (op==0) ? mips.EXMEMALUOut: 0;
wire [31:0]case1 = (op==1) ? (in1 + in2) : 0;
wire [31:0]case2 = (op==2) ? (in1 - in2) : 0;
wire [31:0]case3 = (op==3) ? (in1 & in2) : 0;
wire [31:0]case4 = (op==4) ? (in1 | in2) : 0;
wire [31:0]case5 = (op==5) ? (in1-in2)>>32 : 0;

assign out = case0 | case1 | case2 | case3 | case4 | case5;

//always @ (posedge clock) begin
	//$display ("alu: ",op, "in1: ",in1, "in2: ",in2, "test1: ",mips.regOut1);
//end


endmodule
