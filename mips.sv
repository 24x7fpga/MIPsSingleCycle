module mips(/*AUTOARG*/
   // Outputs
   aluresult, writedata, memwrt, pc,
   // Inputs
   instr, readdata, clk, rst
   );
   // Outputs
   output [31:0] aluresult;
   output [31:0] writedata;
   output 	 memwrt;
   output [31:0] pc;

   // Input
   input [31:0]  instr;
   input [31:0]  readdata;
   input 	 clk;
   input 	 rst;

   /*AUTOREG*/

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [4:0]		a1;			// From DATA_PATH of dpath.v
   wire [4:0]		a2;			// From DATA_PATH of dpath.v
   wire [4:0]		a3;			// From DATA_PATH of dpath.v
   wire [2:0]		aluctrl;		// From CONTROL_UNIT of ctrl.v
   wire			alusrc;			// From CONTROL_UNIT of ctrl.v
   wire [5:0]		funct;			// From DATA_PATH of dpath.v
   wire			jmp;			// From CONTROL_UNIT of ctrl.v
   wire			memtoreg;		// From CONTROL_UNIT of ctrl.v
   wire [5:0]		op;			// From DATA_PATH of dpath.v
   wire			pcsrc;			// From CONTROL_UNIT of ctrl.v
   wire [31:0]		rd1;			// From MIPS_REG of regfile.v
   wire [31:0]		rd2;			// From MIPS_REG of regfile.v
   wire			regdst;			// From CONTROL_UNIT of ctrl.v
   wire			regwrt;			// From CONTROL_UNIT of ctrl.v
   wire [31:0]		srca;			// From DATA_PATH of dpath.v
   wire [31:0]		srcb;			// From DATA_PATH of dpath.v
   wire [31:0]		wd3;			// From DATA_PATH of dpath.v
   wire			zero;			// From LOGIC_UNit of alu.v
   // End of automatics

   logic 		we3;
   
   ctrl CONTROL_UNIT (/*AUTOINST*/
		      // Outputs
		      .memtoreg		(memtoreg),
		      .memwrt		(memwrt),
		      .regdst		(regdst),
		      .regwrt		(regwrt),
		      .alusrc		(alusrc),
		      .pcsrc		(pcsrc),
		      .jmp		(jmp),
		      .aluctrl		(aluctrl[2:0]),
		      // Inputs
		      .zero		(zero),
		      .op		(op[5:0]),
		      .funct		(funct[5:0]));

   dpath DATA_PATH (/*AUTOINST*/
		    // Outputs
		    .pc			(pc[31:0]),
		    .wd3		(wd3[31:0]),
		    .op			(op[5:0]),
		    .funct		(funct[5:0]),
		    .a1			(a1[4:0]),
		    .a2			(a2[4:0]),
		    .a3			(a3[4:0]),
		    .srca		(srca[31:0]),
		    .srcb		(srcb[31:0]),
		    // Inputs
		    .instr		(instr[31:0]),
		    .memtoreg		(memtoreg),
		    .alusrc		(alusrc),
		    .regdst		(regdst),
		    .pcsrc		(pcsrc),
		    .jmp		(jmp),
		    .rd1		(rd1[31:0]),
		    .rd2		(rd2[31:0]),
		    .aluresult		(aluresult[31:0]),
		    .readdata		(readdata[31:0]),
		    .clk		(clk),
		    .rst		(rst));

   alu LOGIC_UNit (/*AUTOINST*/
		   // Outputs
		   .aluresult		(aluresult[31:0]),
		   .zero		(zero),
		   // Inputs
		   .srca		(srca[31:0]),
		   .srcb		(srcb[31:0]),
		   .aluctrl		(aluctrl[2:0]));
 
  regfile MIPS_REG (/*AUTOINST*/
		    // Outputs
		    .rd1		(rd1[31:0]),
		    .rd2		(rd2[31:0]),
		    // Inputs
		    .a1			(a1[4:0]),
		    .a2			(a2[4:0]),
		    .a3			(a3[4:0]),
		    .wd3		(wd3[31:0]),
		    .we3		(we3),
		    .clk		(clk));
  
   assign writedata = rd2;
   assign we3 = regwrt;
  
	     
 
 
endmodule // mips
// Local Variables:
// verilog-library-directories:(".") 
// End:
