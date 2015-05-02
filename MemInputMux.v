module  MemInputMux(input flag, input [31:0]option1, input [31:0]option2, output [31:0] out);


assign out = (flag==1'b0) ? option1 : option2;

endmodule

