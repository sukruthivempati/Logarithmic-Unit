`timescale 1ns / 1ps
module sample_tb();

wire [31:0] Op_Q_95;
wire Error_95, Done_95;
reg [31:0] Op_X_95;
reg clk_95, reset_95, Enable_95;
sample S1(Op_Q_95, Error_95, Done_95, Op_X_95, clk_95, reset_95, Enable_95);   

initial
 begin
  $dumpfile("sample.vcd");
  $dumpvars(0,sample_tb);
   
reset_95 = 1'b1; Enable_95 = 1'b0; clk_95 = 1'b1;             
 #10 reset_95 = 1'b0; Enable_95 = 1'b1; Op_X_95 = 32'h3eaaaaab;
 Op_X_95 = 32'h3F800000; 
 //Op_X_95 = 32'h3e124925;
 
#1000 $finish;

 end 

always forever #5 clk_95 = ~clk_95;


endmodule

 
 
