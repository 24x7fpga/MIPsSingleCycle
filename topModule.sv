module topModule(/*AUTOARG*/
   // Outputs
   writedata, addr, memwrt,
   // Inputs
   clk, rst
   );
   // Outputs
   output [31:0] writedata;
   output [31:0] addr;
   output 	 memwrt;

   // Inputs
   input 	 clk;
   input 	 rst;
   
   
  


   /*AUTOREG*/
   
   /*AUTOWIRE*/  
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [31:0]		aluresult;		// From PROCESSOR of mips.v
   wire [31:0]		instr;			// From INST_MEM of imem.v
   wire [31:0]		pc;			// From PROCESSOR of mips.v
   wire [31:0]		readdata;		// From DATA_MEM of dmem.v
   // End of automatics

 
   mips PROCESSOR (/*AUTOINST*/
		   // Outputs
		   .aluresult		(aluresult[31:0]),
		   .writedata		(writedata[31:0]),
		   .memwrt		(memwrt),
		   .pc			(pc[31:0]),
		   // Inputs
		   .instr		(instr[31:0]),
		   .readdata		(readdata[31:0]),
		   .clk			(clk),
		   .rst			(rst));

   imem INST_MEM (/*AUTOINST*/
		  // Outputs
		  .instr		(instr[31:0]),
		  // Inputs
		  .pc			(pc[31:0]));

   dmem DATA_MEM (/*AUTOINST*/
		  // Outputs
		  .readdata		(readdata[31:0]),
		  // Inputs
		  .clk			(clk),
		  .memwrt		(memwrt),
		  .addr			(addr[31:0]),
		  .writedata		(writedata[31:0]));

   assign addr = aluresult;
   
endmodule // topModule
// Local Variables:
// verilog-library-directories:(".") 
// End:
