module  BranchForwardUnit(input [5:0]op, input [4:0]idexrs, input [4:0]idexrt, input [4:0]exmemrd, input [4:0]memwbrd, output [1:0]branchaout, output [1:0]branchbout);

wire hazardexA = (exmemrd!=0  &&  exmemrd==idexrs);
wire hazardmemA = (memwbrd!=0 && memwbrd==idexrs);

assign branchaout = hazardexA ? 2'b10 :
            (hazardmemA)? 2'b01 : 00;

wire hazardexB = (exmemrd!=0  &&  exmemrd==idexrt);
wire hazardmemB = (memwbrd!=0 && memwbrd==idexrt);

assign branchbout = hazardexB ? 2'b10 :
            (hazardmemB)? 2'b01 : 00;

always @ (posedge mips.clock) begin 
    //$display("OP:", op,  "Test: ",exmemrd, " TEST2: ", memwbrd, "A: ",idexrs, "B: ",idexrt);
    if(branchaout>0 || branchbout>0) begin
       //$display("OP :", op, " FA: ",branchaout, "  FB: ",branchbout, "A: ",idexrs);
    end
end

endmodule

