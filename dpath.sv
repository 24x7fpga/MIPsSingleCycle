module dpath(/*AUTOARG*/
   // Outputs
   pc, wd3, op, funct, a1, a2, a3, srca, srcb,
   // Inputs
   instr, memtoreg, alusrc, regdst, pcsrc, jmp, rd1, rd2, aluresult,
   readdata, clk, rst
   );
   // Outputs
   output [31:0] pc;
   output [31:0] wd3;
   output [5:0]	 op;
   output [5:0]	 funct;
   output [4:0]	 a1;
   output [4:0]	 a2;
   output [4:0]	 a3;
   output [31:0] srca;
   output [31:0] srcb;
   

   // Inputs
   input [31:0]  instr;
   input 	 memtoreg;
   input 	 alusrc;
   input 	 regdst;
   input 	 pcsrc;
   input 	 jmp;
   input [31:0]	 rd1;
   input [31:0]	 rd2;
   input [31:0]  aluresult;
   input [31:0]  readdata;
   input 	 clk;
   input 	 rst;
   


   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [31:0]		pc;
   // End of automatics

   /*AUTOWIRE*/

   logic [31:0] 	signImm;
   logic [31:0] 	pcbranch;
   logic [31:0] 	pcPlus4;
   logic [31:0] 	pcb;
 
   
   
   
   // inputs to control unit
   assign op = instr[31:26];
   assign funct = instr[5:0];

   // inputs to register file
   assign a1 = instr[25:21];
   assign a2 = instr[20:16];
   assign a3 = regdst ?  instr[15:11] : instr[20:16];
   assign wd3= memtoreg ? readdata : aluresult;

   // sign extension
   assign signImm = {{16{instr[15]}}, instr[15:0]};

   // pc branch
   assign pcbranch = (signImm << 2) + pcPlus4;
   
   // inputs to alu
   assign srca = rd1;
   assign srcb = alusrc ? signImm : rd2;

   // pc counter
   always@(posedge clk)
      if(rst)
	pc <= 0;
      else
	pc <= pcb;

   assign pcPlus4 = pc + 1;
   assign pcb = pcsrc ? pcbranch : pcPlus4;
   
endmodule // dpath
// Local Variables:
// verilog-library-directories:(".") 
// End:
