module dffe_32(q, d, clk, en, rst);
   
   //Inputs
   input [31:0]d; 
	input clk, en, rst;
   
   //Internal wire
   wire rst;

   //Output
   output [31:0]q;
   
   //Register
   reg [31:0]q;

   //Intialize q to 0
   initial
   begin
       q = 32'h00000000;
   end

   //Set value of q on positive edge of the clock or clear
   always @(posedge clk or posedge rst) begin
       //If clear is high, set q to 0
       if (rst) begin
           q <= 32'h00000000;
       //If enable is high, set q to the value of d
       end else if (en) begin
           q <= d;
       end
   end
endmodule
