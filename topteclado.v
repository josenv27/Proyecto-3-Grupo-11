`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2017 00:05:32
// Design Name: 
// Module Name: topteclado
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


module topteclado(
  input clk,reset,
  input ps2d,ps2c, rx_en,
  output a,b,c,d,up,down,left,right

  );

    wire [7:0] dout;
    wire rx_done_tick;


         ps2  PS2(
             .clk(clk),.reset(reset),
             .ps2d(ps2d),.ps2c(ps2c), .rx_en(rx_en),
             .rx_done_tick(rx_done_tick),
             .dout(dout)
           );

          teclado  tecla(
              .clk(clk),
              .reset(reset),
              .rx_done_tick(rx_done_tick),
              .keycodeout(dout),
              .a_code(a),
              .b_code(b),
              .c_code(c),
              .d_code(d),
              .up_code(up),
              .down_code(down),
              .left_code(left),
              .right_code(right)
          );



endmodule


