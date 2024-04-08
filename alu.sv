module alu(/*AUTOARG*/
   // Outputs
   aluresult, zero,
   // Inputs
   srca, srcb, aluctrl
   );
   // Outputs
   output [31:0] aluresult;
   output 	 zero;
   
   // Inputs
   input [31:0]  srca;
   input [31:0]  srcb;
   input [2:0] 	 aluctrl;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [31:0]		aluresult;
   // End of automatics

   /*AUTOWIRE*/

   
   assign zero = (aluctrl == 3'b110) && (aluresult == 32'h0) ? 1'b1 : 1'b0;
 
   always@(/*AUTOSENSE*/aluctrl or srca or srcb)begin
      casez(aluctrl)
	3'b010: aluresult = srca + srcb;
	3'b110: aluresult = srca - srcb;
	3'b000: aluresult = srca & srcb;
	3'b001: aluresult = srca | srcb;
	default: aluresult = 32'hxxxx_xxxx;
      endcase; // case (aluctrl)
   end

endmodule // alu
// Local Variables:
// verilog-library-directories:(".") 
// End:
	
