module mux2x1(input [31:0]in1,input [31:0]in2, output [31:0] out, input choice);

assign out = (choice==1'b0)? in1 : in2;

endmodule
