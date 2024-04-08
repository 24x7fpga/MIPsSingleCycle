module imem(/*AUTOARG*/
   // Outputs
   instr,
   // Inputs
   pc
   );
   // Outputs
   output [31:0] instr;

   // Inputs
   input [31:0] 	 pc;

   logic [31:0]  ram [63:0];

//   integer i;
//   initial begin
//     for (i=0; i<=63; i=i+1)
//       ram[i] = 8'h00;
//     $readmemh ("memfile.mem",ram);
//   end	

   initial
     $readmemh("memfile.mem", ram);

   assign instr = ram[pc];

endmodule // imem
// Local Variables:
// verilog-library-directories:(".") 
// End:
