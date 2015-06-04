module testmips;
    reg clk;
    integer cnt;
    mips core(.clock(clk));
  
    initial begin
        clk = 0;
        cnt = 0;
	end
	
    always
    begin
        if (cnt <320) 
	       #50 clk <= ~clk;
	    else begin
	       $display("Finalize");
	       $finish;
	    end
	    cnt = cnt + 1;
    end

endmodule
