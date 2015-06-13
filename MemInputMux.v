module  MemInputMux(input [1:0]flag, input [31:0]option1, input [31:0]option2, input [31:0]option3, output [31:0] out);


assign out = (flag==2'b00) ? option1 : 
             (flag==2'b01) ? option2 : option3;

endmodule

