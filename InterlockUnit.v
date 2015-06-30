module InterlockUnit(input [5:0]op, input [5:0]ifop, input [4:0] ifidrs, 
    input [4:0] ifidrt, input [4:0]idexrt, input[4:0] exmemrt, output stallout);

//maybe not fully implemented
assign notstall = (ifop==mips.ADD_IMM || ifop==mips.Jop || ifop==mips.JALop);

assign stallout = ((op == mips.LW) && (idexrt==ifidrs || idexrt==ifidrt)) ||
                  //((ifop == mips.BEQ) && mips.EXMEMop==mips.LW && (idexrt ==ifidrs || idexrt ==ifidrt)) ||
                  ((ifop == mips.BEQ) && op==mips.ALUop && (mips.IDEXIR[15:11]!=0) && (mips.IDEXIR[15:11] ==ifidrs || mips.IDEXIR[15:11] ==ifidrt)) ||
                  ((ifop == mips.BEQ) && op==mips.ADD_IMM && (mips.IDEXIR[20:16]!=0) && (mips.IDEXIR[20:16] ==ifidrs || mips.IDEXIR[20:16] ==ifidrt)) ||
                  ((ifop == mips.BEQ) && mips.EXMEMop==mips.LW && (exmemrt==ifidrs || exmemrt==ifidrt)) ;



always @ (posedge mips.clock) begin 
   //$display("ifop: ",ifop,"|0. ",op," |1. ",exmemrt, " |2. ",ifidrs, " 3.",ifidrt, "4. ",idexrt);
end

endmodule
