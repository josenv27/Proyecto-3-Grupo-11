`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2017 00:06:54
// Design Name: 
// Module Name: tbteclado
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tbteclado();

		// Inputs
	reg clk;
	reg reset;
	reg ps2d;
	reg ps2c;
	reg rx_en;

	// Outputs
	//wire [7:0] regdata;
	//wire [2:0] s;
	wire [7:0] dout;
	wire rx_done_tick;

	// Instantiate the Unit Under Test (UUT)
	ps2 tbps2 (
		.clk(clk),
		.reset(reset),
		.ps2d(ps2d),
		.ps2c(ps2c),
		.rx_en(rx_en),.rx_done_tick(rx_done_tick),
		//.led(regdata),
		.dout(dout)
	);
	always #10 clk=~clk;
	always #4000 ps2c=~ps2c;

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		ps2d = 1;
		ps2c = 0;
		rx_en = 1;

		// Wait 100 ns for global reset to finish
		#100 reset = 0;  #100 reset = 1;		  #100 reset = 0;
  
			#8000
			ps2d = 1;
			#80000 ps2d = 0; //inicio 
			//byte de datos
			#8000 ps2d = 1;
			#8000 ps2d = 0;
			#8000 ps2d = 0;
			#8000 ps2d = 0;
			#8000 ps2d = 0;
			#8000 ps2d = 0;
			#8000 ps2d = 1;
			#8000 ps2d = 1;
			//paridad
			#8000 ps2d = 0;
			//final
			#8000 ps2d = 1;
			#180000

		$stop;


	end
endmodule


