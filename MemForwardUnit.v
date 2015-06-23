module  MemForwardUnit(input [5:0]op, input [4:0]exmemrd, input [4:0]memwbrd, input[4:0] after, output [1:0]memout);

wire hazardWB = (op==mips.SW && exmemrd==memwbrd);
wire hazardafter = (op==mips.SW && exmemrd==after);


assign memout = (hazardWB)? 1 : 
                (hazardafter)? 2 : 0;

always @ (posedge mips.clock) begin 
    if(op==mips.SW || op==mips.LW) begin    
        //$display("OP:", op, "Test: ",exmemrd, " TEST2: ", memwbrd, " AFTER: ",after);
    end
end

endmodule

