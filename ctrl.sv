module ctrl(/*AUTOARG*/
   // Outputs
   memtoreg, memwrt, regdst, regwrt, alusrc, pcsrc, jmp, aluctrl,
   // Inputs
   zero, op, funct
   );
   // outputs
   output  memtoreg;      // Memory to Register
   output  memwrt;        // Memory write control 
   output  regdst;        // Register destination 
   output  regwrt;        // Register write control  
   output  alusrc;        // ALU source control
   output  pcsrc;         // PC source
   output  jmp;           // Jump instruction
   output  [2:0] aluctrl; // ALU control 
  
   // inputs
   input 	      zero;    // ALU 
   input [5:0] 	      op;      // opcode
   input [5:0] 	      funct;   // funct
   
   //logic [2:0] 	      aluop;   // ALU operation for ALU decoder

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [2:0]		aluctrl;
   reg			alusrc;
   reg			jmp;
   reg			memtoreg;
   reg			memwrt;
   reg			regdst;
   reg			regwrt;
   // End of automatics
   
   /*AUTOWIRE*/

   logic [1:0] 	      aluop;   // ALU operation for ALU decoder
   logic 	      branchs;
 
   // main decoder
   always@(/*AUTOSENSE*/op)begin
      casez(op)
	6'b000000: {regwrt, regdst, alusrc, branchs, memwrt, memtoreg, aluop, jmp} = 9'b110000100;  // R-TYPE
	6'b100011: {regwrt, regdst, alusrc, branchs, memwrt, memtoreg, aluop, jmp} = 9'b101001000;  // LOAD
	6'b101011: {regwrt, regdst, alusrc, branchs, memwrt, memtoreg, aluop, jmp} = 9'b0x101x000;  // STORE
	6'b000100: {regwrt, regdst, alusrc, branchs, memwrt, memtoreg, aluop, jmp} = 9'b0x010x010;  // BEQ
	6'b001000: {regwrt, regdst, alusrc, branchs, memwrt, memtoreg, aluop, jmp} = 9'b101000000;  // ADDi
	6'b000010: {regwrt, regdst, alusrc, branchs, memwrt, memtoreg, aluop, jmp} = 9'b0xxx0xxx1;  // JUMP 
	default  : {regwrt, regdst, alusrc, branchs, memwrt, memtoreg, aluop, jmp} = 9'bxxxxxxxxx;  // ???
      endcase // case (op)
   end // always_comb
   


   // alu decoder
   always@(/*AUTOSENSE*/aluop or funct)begin
      case(aluop)
	2'b00: aluctrl = 3'b010; // ADD
	2'b01: aluctrl = 3'b110; // SUB
	default: casez(funct)
		   6'b100000: aluctrl = 3'b010; // ADD
		   6'b100010: aluctrl = 3'b110; // SUB
		   6'b100100: aluctrl = 3'b000; // AND
		   6'b100101: aluctrl = 3'b001; // OR
		   6'b101010: aluctrl = 3'b111; // SLT
		   default  : aluctrl = 3'bxxx; // ???
		 endcase // casez (funct)
      endcase // case (aluop)
   end // always_comb

   assign pcsrc = branchs & zero;
   
endmodule // ctrl
// Local Variables:
// verilog-library-directories:("~/Projects/fpgaProjects/MIPS_Single_Cycle/*") 
// End:
