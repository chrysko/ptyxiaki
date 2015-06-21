module forwardUnit(input [5:0]op, input [4:0]idexrs, input [4:0]idexrt, input [4:0]exmemrd, input [4:0]memwbrd, output [1:0]faout, output [1:0]fbout);

wire hazardexA = (exmemrd!=0 &&  exmemrd==idexrs);
wire hazardmemA = (memwbrd!=0 && memwbrd==idexrs);

assign faout = hazardexA ? 2'b10 :
            (hazardmemA)? 2'b01 : 00;

//o B mporei na kanei forward mono gia tis alu entoles (R-type)
//wire hazardexB =  (op==mips.ALUop && exmemrd!=0 &&  exmemrd==idexrt);
wire hazardexB =  (exmemrd!=0 &&  exmemrd==idexrt);
//wire hazardmemB = (op==mips.ALUop && memwbrd!=0 && memwbrd==idexrt);
wire hazardmemB = (memwbrd!=0 && memwbrd==idexrt);

assign fbout = hazardexB ? 2'b10 :
            (hazardmemB)? 2'b01 : 00;

always @ (posedge mips.clock) begin 
    if(faout>0 || fbout>0) begin
       //$display("OP :", op, " FA: ",faout, "  FB: ",fbout, "A: ",idexrs);
    end
end
endmodule
