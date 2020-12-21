`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:18:33 12/21/2020
// Design Name:   fp_addsub
// Module Name:   C:/Users/khand/Documents/Custom Office Templates/falu_32_bit_adder/tb.v
// Project Name:  falu_32_bit_adder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fp_addsub
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb;

	// Inputs
	reg [31:0] datain_a;
	reg [31:0] datain_b;

	// Outputs
	wire [31:0] sum;

	// Instantiate the Unit Under Test (UUT)
	fp_addsub uut (
		.sum(sum), 
		.datain_a(datain_a), 
		.datain_b(datain_b)
	);

	initial begin
		// Initialize Inputs
		datain_a =32'b0100_0001_1011_1000_0000_0000_0000_0000;
		datain_b = 32'b0100_0001_0010_0000_0000_0000_0000_0000;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

