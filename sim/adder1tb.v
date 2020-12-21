

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:02:06 12/21/2020
// Design Name:   float_adder
// Module Name:   C:/Users/khand/Documents/Custom Office Templates/falu_32_bit_adder/tbadd.v
// Project Name:  falu_32_bit_adder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: float_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tbadd;

	// Inputs
	reg [31:0] num1;
	reg [31:0] num2;

	// Outputs
	wire [31:0] result;
	wire overflow;

	// Instantiate the Unit Under Test (UUT)
	float_adder uut (
		.num1(num1), 
		.num2(num2), 
		.result(result), 
		.overflow(overflow)
	);

	initial begin
		// Initialize Inputs
		num1 = 32'b0100_0001_1011_1000_0000_0000_0000_0000;
		num2 = 32'b0100_0001_0010_0000_0000_0000_0000_0000;
    end
		// Wait 100 ns for global reset to finish
	initial begin 
        $dumpfile("dump.vcd"); 
      $dumpvars;
		// Add stimulus here

	end
 
      
endmodule

