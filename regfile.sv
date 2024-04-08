module regfile (/*AUTOARG*/
   // Outputs
   rd1, rd2,
   // Inputs
   a1, a2, a3, wd3, we3, clk
   );
   // Outputs
   output [31:0] rd1;
   output [31:0] rd2;

   // Inputs
   input [4:0]   a1;     // rs
   input [4:0]   a2;     // rt
   input [4:0]   a3;     // rd 
   input [31:0]  wd3;    // data from memory
   input 	 we3;    // write enable
   input 	 clk;

   /*AUTOREG*/

   /*AUTOWIRE*/

   logic [31:0]  rf[31:0];
   
   always@(posedge clk)
     if(we3)begin
        rf[a3] <= wd3;
     end




   assign rd1 = (a1 != 0) & (we3) ? rf[a1] : a1;
   assign rd2 = (a2 != 0) ? rf[a2] : a2;
   

//   assign rd1 = (a1 != 0) ? rf[a1] : a1;
//   assign rd2 = (a2 != 0) ? rf[a2] : a2;

endmodule // regfile
// Local Variables:
// verilog-library-directories:(".") 
// End:

       
   
