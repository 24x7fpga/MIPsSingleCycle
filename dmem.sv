module dmem (/*AUTOARG*/
   // Outputs
   readdata,
   // Inputs
   clk, memwrt, addr, writedata
   );
   //outputs
   output [31:0] readdata;

   //inputs
   input 	 clk;
   input 	 memwrt;
   input [31:0]  addr;
   input [31:0]  writedata;

   /*AUTOREG*/

   /*AUTOWIRE*/

   logic [31:0]  ram[63:0];
   
   always@(posedge clk)
     if(memwrt)
       ram[addr] <= writedata;

   assign readdata = ram[addr];

endmodule // dmem 
// Local Variables:
// verilog-library-directories:(".") 
// End:


