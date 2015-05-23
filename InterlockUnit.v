module InterlockUnit(input [5:0]op, input [5:0]ifop, input [4:0] ifidrs, 
    input [4:0] ifidrt, input [4:0]idexrt, input[4:0] exmemrt, output stallout);

//maybe not fully implemented
assign notstall = (ifop==mips.ADD_IMM || ifop==mips.Jop || ifop==mips.JALop);

assign stallout = ((op == mips.LW) && (idexrt==ifidrs || idexrt==ifidrt)) ||
                  ((ifop == mips.BEQ)&& (idexrt ==ifidrs || idexrt ==ifidrt)) ||
                  ((ifop == mips.BEQ)&& mips.EXMEMop==mips.LW && (exmemrt==ifidrs || exmemrt==ifidrt)) ;



always @ (posedge mips.clock) begin 
  // $display("0. ",op," |1. ",mips.EXMEMIR[20:16], " |2. ",ifidrs, " 3.",ifidrt);
end

endmodule
