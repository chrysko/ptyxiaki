module mips ( input clock);
parameter LW  = 6'b100011, SW = 6'b101011, BEQ = 6'b000100, ADD_IMM = 6'b001000, noop = 32'b0000000_0000000_0000000_0000000, ALUop = 6'b0;
parameter Jop = 6'b000010, JALop = 6'b000011;

integer out;
 reg [31:0] PC, IMemory[0:1023], // separate memories
             IFIDIR, IDEXA, IDEXB, IDEXIR, EXMEMIR, EXMEMB, // pipeline registers
             EXMEMALUOut, MEMWBValue, MEMWBIR; // pipeline registers
 reg [31:0] MEMWBValueAfter;
 wire [4:0]  IDEXrs, IDEXrt, EXMEMrd, MEMWBrd; //hold register ? elds
 wire [5:0]  EXMEMop, MEMWBop, IDEXop; // Hold opcodes
 wire [31:0] Ain, Bin;
 wire [31:0] FA, FB;
 wire [31:0] MEMStageOut;
 wire [31:0] regOut1;
 wire [31:0] regOut2;
 wire [31:0] EXMEMOut;
 reg [4:0]  MEMWBOut;
 reg [4:0] MEMWBOutAFTER;
 wire [4:0] muxREGout;
 wire [31:0] ALUOut;
 wire [31:0] muxaluout;
 wire [31:0] muxpcout;
 wire [2:0] ctrlout;
 wire [1:0] faout, fbout, bfaout, bfbout, flagmem;
 wire [31:0]finalmemOut;
 wire takebranch, stall; 

 assign IDEXrs = IDEXIR[25:21];
 assign IDEXrt = IDEXIR[20:16];
 assign EXMEMrd = EXMEMIR[15:11]; 
 assign MEMWBrd = MEMWBIR[15:11];
 assign IFIDop = IFIDIR[31:26];
 assign EXMEMop = EXMEMIR[31:26]; 
 assign MEMWBop = MEMWBIR[31:26];
 assign IDEXop = IDEXIR[31:26];

 assign MEMStageFlag = (EXMEMop==LW || EXMEMop==SW)? 0 : 1;

//Interlock 
InterlockUnit myinterlock(IDEXIR[31:26], IFIDIR[31:26], IFIDIR[25:21], IFIDIR[20:16], IDEXrt,mips.EXMEMIR[20:16], stall);

//Forward - Decode
BranchForwardUnit mybrancForwardUnit(IFIDIR[31:26], IFIDIR[25:21], IFIDIR[20:16],muxREGout,MEMWBOut, bfaout, bfbout); 
BranchPrediction mybranchdec(IFIDIR[31:26],bfaout,bfbout,takebranch); 

//gia thn ALU
//Forward - Execute
forwardUnit myforwardUnit(IDEXop, IDEXrs,IDEXrt,muxREGout,MEMWBOut,faout,fbout);
Alucontroller myaluctrl(IDEXop,IDEXIR[5:0],ctrlout);
muxInA myinA(IDEXop,faout, FA);
muxInB myinB(IDEXop,fbout, FB);

ALU myalu(clock,ctrlout,FA,FB,ALUOut);
muxPC  mypcmux( IDEXIR[25:0], FA<<2, PC, IDEXop, muxpcout);

//MemStage 
//Forward - Memory
MemForwardUnit mymemforwardunit(EXMEMop,EXMEMIR[20:16],MEMWBOut,MEMWBOutAFTER,flagmem);
DMem Memory(clock, EXMEMop, EXMEMALUOut,finalmemOut, MEMStageOut);
MemInputMux mymemmux(flagmem, EXMEMB, MEMWBValue,MEMWBValueAfter, finalmemOut);
mux2x1 testmux(MEMStageOut, EXMEMALUOut,EXMEMOut, MEMStageFlag);
 
 //Write Back stage
RegistersFile myregs(clock, MEMWBValue, regOut1, regOut2, MEMWBOut,IFIDIR[25:21],IFIDIR[20:16]);
mux2x1_5bit wbmux(EXMEMrd, EXMEMIR[20:16], muxREGout,EXMEMop);
 
initial begin 
    $readmemh("imem_testinterlock_book.v", IMemory);
    PC = 0; 
    IFIDIR = noop;
	IDEXIR = noop;
	EXMEMIR = noop;
	MEMWBIR = noop; // put no_ops in pipeline registers
 end
 
always @ (posedge clock) begin 
  //$display("PC:",PC);
  if (~stall) begin // the ? rst three pipeline stages stall if there is a load hazard
     if (~takebranch) begin // ? rst instruction in the pipeline is being fetched normally
         IFIDIR <= IMemory[PC>>2];
         PC <= muxpcout; //PC + 4;
     end else begin // a taken branch is in ID; instruction in IF is wrong; insert a no-op and reset the PC
         IFIDIR <= noop; 
         PC <= PC + ({{16{IFIDIR[15]}}, IFIDIR[15:0]}<<2); 
     end 
     // second instruction is in register fetch 
	 IDEXA <= regOut1;
	 IDEXB <= regOut2;
     
	  // third instruction is doing address calculation or ALU operation
	 //$display( faout, fbout);
     IDEXIR <= IFIDIR; //pass along IR
     if (IDEXop==Jop) begin
     	IFIDIR <=noop;
        IDEXIR <=noop;
     end else if (IDEXop==JALop) begin
     	IFIDIR <=noop;
        IDEXIR <=noop;
     end else if (IDEXop==ALUop) begin
        case (IDEXIR[5:0]) 
           8:  begin 
           		IFIDIR <=noop;
           		IDEXIR <=noop;
           	   end
       endcase
     end 
	 EXMEMALUOut <= ALUOut; //pairnei thn timi apo ton kataxwriti
     EXMEMIR <= IDEXIR;
     EXMEMB  <= IDEXB; //pass along the IR & B register
  end else begin
     //$display("INTERLOCK ");
     //EXMEMIR <= noop; //Freeze ? rst three stages of pipeline; inject a nop into the EX output
     IFIDIR<=noop;
     PC <=PC-4;
     //IDEXIR<=noop;
  end 
   
 end
 
//Mem Stage
always @ (posedge clock) begin
	if (EXMEMop==ALUop | EXMEMop == ADD_IMM) begin
		//$display(EXMEMALUOut);
	end else begin
	    //$display("xxx: ", EXMEMALUOut);
	end
	MEMWBValue <= EXMEMOut;
    MEMWBOut <= muxREGout;
end

//Write Back Stage
always @(posedge clock) begin 
    MEMWBIR <= EXMEMIR; //pass along IR
    MEMWBOutAFTER <=MEMWBOut;
    MEMWBValueAfter <= MEMWBValue;
end
 
endmodule

