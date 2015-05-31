module  MemForwardUnit(input [5:0]op, input [4:0]exmemrd, input [4:0]memwbrd, output memout);

wire hazardWB = (op==mips.SW && exmemrd==memwbrd);


assign memout = (hazardWB)? 1 : 0;

always @ (posedge mips.clock) begin 
    $display("OP:", op, "Test: ",exmemrd, " TEST2: ", memwbrd);
end

endmodule

