`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2017 00:03:09
// Design Name: 
// Module Name: teclado
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


module teclado(
 input clk,reset,rx_done_tick,
 input [7:0] keycodeout,
 output  reg a_code,b_code,c_code,d_code,up_code,down_code,left_code,right_code
// cambiar registros por "h, f y c" para hora, fecha y crono
 );


//declaracion de registros


reg [7:0] hexacode;
//reg a_code,b_code,c_code,d_code,up_code,down_code,left_code,right_code;
reg [7:0] offkey;
reg [7:0] keynext;

//Cuerpo

//carga de codigo en el registro de acuerdo a la tecla presionada

always @(posedge clk) begin
   if(reset) begin
            hexacode <= 8'h00;
       end
   else begin
          if((rx_done_tick) && (offkey != 8'hf0))
        begin
           hexacode <= keycodeout;
          end
       else if((rx_done_tick) && (keycodeout == 8'hf0))
               hexacode <= 0;
       else begin
           hexacode<=hexacode;
           end
   end
end


//deteccion tecla suelta
reg [1:0] contador;

//contador para habilitaciones

always@(posedge clk) begin
   if(reset) begin
               contador<=0;
             end
    else if((rx_done_tick) && (keycodeout != 8'hf0) )begin
                   contador<=contador+1;
                   end
    else if((rx_done_tick) && (keycodeout == 8'hf0))begin
                   contador<=0;
                   end
    else
           contador<=contador;
end

//detector de codigo F0 que significa que la tecla se solto

always @(posedge clk) begin
   if(reset) begin
           offkey <= 8'h00;
       end
   else begin
       if((rx_done_tick) && (keycodeout==8'hf0))begin
          offkey <= keycodeout[7:0];
          end
       else if(contador==1)begin
             offkey <= 8'h00;
           end
       else begin
               offkey <= offkey;
          end
   end
end


//      decodificacion de tecla

always @(posedge clk) begin
   if(reset) begin
         a_code<=0;down_code<=1'b0;
         b_code<=0;up_code<=1'b0;
         c_code<=0;left_code<=1'b0;
         d_code<=0;right_code<=1'b0;
       end
   else begin
       case(hexacode)
       8'h15: begin   //letra A
                   a_code<=1'b1;
                     end
       8'h1d: begin   //letra B
                   b_code<=1'b1;
                     end
       8'h24: begin   //letra C
                   c_code<=1'b1;
                     end
       8'h5a: begin   //letra D
                   d_code<=1'b1;
                            end
       8'h75: begin
              up_code<=1'b1;
              end
       8'h72: begin
               down_code<=1'b1;
               end
       8'h6B: begin
                left_code<=1'b1;
                end
       8'h74: begin
                right_code<=1'b1;
                end
       default: begin
                 a_code<=0;down_code<=1'b0;
                 b_code<=0;up_code<=1'b0;
                 c_code<=0;left_code<=1'b0;
                 d_code<=0;right_code<=1'b0;
               end
       endcase
         end
end

endmodule
//      salida final
/*
assign b = b_code;
assign a = a_code;
assign d = d_code;
assign c = c_code;
assign up = up_code;
assign down = down_code;
assign left = left_code;
assign rightis = right_code;
*/
