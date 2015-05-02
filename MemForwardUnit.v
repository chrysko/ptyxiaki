module  MemForwardUnit(input [5:0]op, input [4:0]exmemrd, input [4:0]memwbrd, output memout);

wire hazardWB = (op==mips.SW && exmemrd==memwbrd);


assign memout = (hazardWB)? 1 : 0;


endmodule

