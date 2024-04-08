module tb_topModule ();
   localparam t = 10;
   
   logic [31:0] writedata;
   logic [31:0] addr;
   logic 	memwrt;

   logic 	clk;
   logic 	rst;

   /*AUTOREG*/

   /*AUTOWIRE*/
   
   topModule DUT (/*AUTOINST*/
		  // Outputs
		  .writedata	(writedata[31:0]),
		  .addr			(addr[31:0]),
		  .memwrt		(memwrt),
		  // Inputs
		  .clk			(clk),
		  .rst			(rst));

   initial begin
      rst <= 1;
      #(t*2);
      rst <= 0;
   end

   initial clk = 1;
   always #(t/2) clk <= ~clk;

   always@(negedge clk)begin
      if(memwrt)begin
         if(addr == 6 & writedata == 4 ) begin
            $display("Simulation successful ;)");
            #(t/2);
            $finish;
         end else if(addr != 6) begin
            $display("Simulation failed ;(");
            #(t/2);
            $finish;
         end
      end
   end // always@ (negedge clk)
   
   initial begin 
      $dumpfile("tb_topModule.vcd"); 
      $dumpvars(0,tb_topModule); 
   end 

endmodule // tb_topModule
// Local Variables: 
// verilog-library-directories:(".") 
// End: 
