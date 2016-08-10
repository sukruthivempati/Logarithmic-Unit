//******************** Design of Floating Point Logarithm Unit ******************************
`timescale 1ns / 1ps
module sample(Op_Q_95, Error_95, Done_95, Op_X_95, clk_95, reset_95, Enable_95);  
//*********************** Port Declarations **************************
 output reg [31:0] Op_Q_95;
 output reg Error_95, Done_95;

 input [31:0] Op_X_95;
 input clk_95, reset_95, Enable_95;
//*************************** Temporary variables Declaration *********************************
 
 reg [31:0] fil_coef_1, fil_coef_2, fil_coef_3, fil_coef_4, fil_coef_5, fil_coef_6, fil_coef_7;
 
 reg [33:0] x_sq, x_stage_1, x_stage_2, x_stage_3, x_stage_4, x_stage_5, x_stage_6, x_stage_7, x_stage_8, x_stage_9, x_stage_10, x_stage_11, x_stage_12, x_stage_28, x_stage_29, x_stage_30, x_stage_31;
 
 reg [33:0] x_stage_13, x_stage_14, x_stage_15, x_stage_16, x_stage_17, x_stage_18, x_stage_19, x_stage_20, x_stage_21, x_stage_22, x_stage_23, x_stage_24, x_stage_25, x_stage_26, x_stage_27, x_stage_32;
 
 reg [33:0] x_sq_stage_1, x_sq_stage_2, x_sq_stage_3, x_sq_stage_4, x_sq_stage_5,x_sq_stage_6, x_sq_stage_7, x_sq_stage_8, x_sq_stage_9, x_sq_stage_10, x_sq_stage_21, x_sq_stage_22, x_sq_stage_27, x_sq_stage_28;
 
 reg [33:0] x_sq_stage_11, x_sq_stage_12, x_sq_stage_13, x_sq_stage_14, x_sq_stage_15, x_sq_stage_16, x_sq_stage_17, x_sq_stage_18, x_sq_stage_19, x_sq_stage_20, x_sq_stage_23, x_sq_stage_24, x_sq_stage_25, x_sq_stage_26;
 
 reg [33:0] x_power3, x_power3_1, x_power3_2, x_power3_3, x_power3_4, x_power3_5, x_power3_6, x_power3_7, x_power3_8, x_power3_9, x_power3_10, x_power3_11, x_power3_12;
 
 reg [33:0] x_power3_13, x_power3_14, x_power3_15, x_power3_16, x_power3_17, x_power3_18, x_power3_19, x_power3_20, x_power3_21, x_power3_22, x_power3_23, x_power3_24;
 
 reg [33:0] x_power4, x_power4_1, x_power4_2, x_power4_3, x_power4_4, x_power4_5, x_power4_6, x_power4_7, x_power4_8, x_power4_9, x_power4_10, x_power4_11;
 
 reg [33:0] x_power4_12, x_power4_13, x_power4_14, x_power4_15, x_power4_16, x_power4_17, x_power4_18, x_power4_19, x_power4_20;
 
 reg [33:0] prod_1, prod_2, prod_3, prod_4, prod_5, prod_6, prod_7;
 
 reg [33:0] x_power5, x_power5_1, x_power5_2, x_power5_3, x_power5_4, x_power5_5, x_power5_6, x_power5_7, x_power5_8, x_power5_9, x_power5_10, x_power5_11, x_power5_12, x_power5_13, x_power5_14, x_power5_15, x_power5_16;
 
 reg [33:0] x_power6, x_power6_1, x_power6_2, x_power6_3, x_power6_4, x_power6_5, x_power6_6, x_power6_7, x_power6_8, x_power6_9, x_power6_10, x_power6_11, x_power6_12;
 
 reg [33:0] x_power7, x_power7_1, x_power7_2, x_power7_3, x_power7_4, x_power7_5, x_power7_6, x_power7_7, x_power7_8;
 
 reg [33:0] adder_1, adder_2, adder_3, adder_4, adder_5, adder_6, adder_temp1, adder_temp2, adder_temp3, adder_temp4, adder_temp5, adder_temp6;
 
 reg [33:0] x_power8, result_temp;
 
 reg [33:0] nx;
 
 wire [33:0] out_x_sq, x_power3_temp, x_power4_temp, x_power5_temp, x_power6_temp, x_power7_temp, x_power8_temp, prod1_temp, prod2_temp, prod3_temp, prod4_temp, prod5_temp;
 
 wire [33:0] prod6_temp, prod7_temp, nx_temp, adder1_temp, adder2_temp, adder3_temp, adder4_temp, adder5_temp, adder6_temp, result_temp1;
 
//*********************************** Instantiation of Flopoco Multiplier and Adder ***************************
//************************Power Calculation**********************
 FPMultiplier_8_23_8_23_8_23_uid2 M1(clk_95, reset_95, nx, nx, out_x_sq);
 FPMultiplier_8_23_8_23_8_23_uid2 M2(clk_95, reset_95, x_sq, x_stage_4, x_power3_temp);
 FPMultiplier_8_23_8_23_8_23_uid2 M3(clk_95, reset_95, x_power3, x_stage_8, x_power4_temp);
 FPMultiplier_8_23_8_23_8_23_uid2 M4(clk_95, reset_95, x_power4, x_stage_12, x_power5_temp);
 FPMultiplier_8_23_8_23_8_23_uid2 M5(clk_95, reset_95, x_power5, x_stage_16, x_power6_temp);
 FPMultiplier_8_23_8_23_8_23_uid2 M6(clk_95, reset_95, x_power6, x_stage_20, x_power7_temp);
 FPMultiplier_8_23_8_23_8_23_uid2 M7(clk_95, reset_95, x_power7, x_stage_24, x_power8_temp);
 
 //***********************Product of Input and Filter Coefficients****************
 FPMultiplier_8_23_8_23_8_23_uid2 M8(clk_95, reset_95, x_sq_stage_28, {2'b01,fil_coef_1}, prod1_temp);
 FPMultiplier_8_23_8_23_8_23_uid2 M9(clk_95, reset_95, x_power3_24, {2'b01,fil_coef_2}, prod2_temp);
 FPMultiplier_8_23_8_23_8_23_uid2 M10(clk_95, reset_95, x_power4_20, {2'b01,fil_coef_3}, prod3_temp);
 FPMultiplier_8_23_8_23_8_23_uid2 M11(clk_95, reset_95, x_power5_16, {2'b01,fil_coef_4}, prod4_temp);
 FPMultiplier_8_23_8_23_8_23_uid2 M12(clk_95, reset_95, x_power6_12, {2'b01,fil_coef_5}, prod5_temp);
 FPMultiplier_8_23_8_23_8_23_uid2 M13(clk_95, reset_95, x_power7_8, {2'b01,fil_coef_6}, prod6_temp);
 FPMultiplier_8_23_8_23_8_23_uid2 M14(clk_95, reset_95, x_power8, {2'b01,fil_coef_7}, prod7_temp);
 
 
 FPAdder_8_23_uid2 A1(clk_95, reset_95, {2'b01,Op_X_95}, {2'b01,32'hBF800000}, nx_temp);
 FPAdder_8_23_uid2 A2(clk_95, reset_95, prod_1, prod_2, adder1_temp);
 FPAdder_8_23_uid2 A3(clk_95, reset_95, prod_3, prod_4, adder2_temp);
 FPAdder_8_23_uid2 A4(clk_95, reset_95, prod_5, prod_6, adder3_temp);
 FPAdder_8_23_uid2 A5(clk_95, reset_95, prod_7, x_stage_32, adder4_temp);
 FPAdder_8_23_uid2 A6(clk_95, reset_95, adder_temp1, adder_temp2, adder5_temp);
 FPAdder_8_23_uid2 A7(clk_95, reset_95, adder_temp3, adder_temp4, adder6_temp);
 FPAdder_8_23_uid2 A8(clk_95, reset_95, adder_temp5, adder_temp6, result_temp1);
//************************* Combinational Block *************************
always@(*)
 begin
  if(reset_95)
   begin
//******************** Initialization of Filter Coefficients to zero when reset is high *********************
    fil_coef_1 = 32'h0;
    fil_coef_2 = 32'h0;    
    fil_coef_3 = 32'h0;
    fil_coef_4 = 32'h0;
    fil_coef_5 = 32'h0;
    fil_coef_6 = 32'h0;
    fil_coef_7 = 32'h0;
   end

  else begin
//*************************** Filter Coefficients Initialization when reset is low ***************************
    fil_coef_1 = 32'hBF000000;
    fil_coef_2 = 32'h3EAAAAAB;    
    fil_coef_3 = 32'hBE800000;
    fil_coef_4 = 32'h3E4CCCCD;
    fil_coef_5 = 32'hBE2AAAAB;
    fil_coef_6 = 32'h3E124925;
    fil_coef_7 = 32'hBE000000;
  end
 end
 
//************************** Sequential Block ***************************
always@(posedge clk_95 or posedge reset_95)
 begin
  if(reset_95)
    begin
	  if(!Enable_95)
	   begin
//************************** Resetting all the variables to zeroes ************************
      nx <= 34'd0;  
      x_sq <= 34'd0;
	
      x_power3 <= 34'd0;
      x_power4 <= 34'd0;
      x_power5 <= 34'd0;
      x_power6 <= 34'd0;
      x_power7 <= 34'd0;
      x_power8 <= 34'd0;
      
		x_stage_32 <= 34'h0;
      x_stage_31 <= 34'h0;
      x_stage_30 <= 34'h0;
      x_stage_29 <= 34'h0;
      x_stage_28 <= 34'h0;
      x_stage_27 <= 34'h0;
      x_stage_26 <= 34'h0;
      x_stage_25 <= 34'h0;
      x_stage_24 <= 34'h0;
      x_stage_23 <= 34'h0;
      x_stage_22 <= 34'h0;
      x_stage_21 <= 34'h0;
      x_stage_20 <= 34'h0;
      x_stage_19 <= 34'h0;
      x_stage_18 <= 34'h0;
      x_stage_17 <= 34'h0;
      x_stage_16 <= 34'h0;
      x_stage_15 <= 34'h0;
      x_stage_14 <= 34'h0;
      x_stage_13 <= 34'h0;
      x_stage_12 <= 34'h0;
      x_stage_11 <= 34'h0;
      x_stage_10 <= 34'h0;
      x_stage_9 <= 34'h0;
      x_stage_8 <= 34'h0;
      x_stage_7 <= 34'h0;
      x_stage_6 <= 34'h0;
      x_stage_5 <= 34'h0;
      x_stage_4 <= 34'h0;
      x_stage_3 <= 34'h0;
      x_stage_2 <= 34'h0;
      x_stage_1 <= 34'h0;
      
		x_sq_stage_28 <= 34'h0;
      x_sq_stage_27 <= 34'h0;
      x_sq_stage_26 <= 34'h0;
      x_sq_stage_25 <= 34'h0;
      x_sq_stage_24 <= 34'h0;
      x_sq_stage_23 <= 34'h0;
      x_sq_stage_22 <= 34'h0;
      x_sq_stage_21 <= 34'h0;
      x_sq_stage_20 <= 34'h0;
      x_sq_stage_19 <= 34'h0;
      x_sq_stage_18 <= 34'h0;
      x_sq_stage_17 <= 34'h0;
      x_sq_stage_16 <= 34'h0;
      x_sq_stage_15 <= 34'h0;
      x_sq_stage_14 <= 34'h0;
      x_sq_stage_13 <= 34'h0;
      x_sq_stage_12 <= 34'h0;
      x_sq_stage_11 <= 34'h0;
      x_sq_stage_10 <= 34'h0;
      x_sq_stage_9 <= 34'h0;
      x_sq_stage_8 <= 34'h0;
      x_sq_stage_7 <= 34'h0;
      x_sq_stage_6 <= 34'h0;
      x_sq_stage_5 <= 34'h0;
      x_sq_stage_4 <= 34'h0;
      x_sq_stage_3 <= 34'h0;
      x_sq_stage_2 <= 34'h0;
      x_sq_stage_1 <= 34'h0;
      
		x_power3_24 <= 34'h0; 
      x_power3_23 <= 34'h0;
      x_power3_22 <= 34'h0;
      x_power3_21 <= 34'h0;
      x_power3_20 <= 34'h0; 
      x_power3_19 <= 34'h0;
      x_power3_18 <= 34'h0;
      x_power3_17 <= 34'h0;
      x_power3_16 <= 34'h0;
      x_power3_15 <= 34'h0; 
      x_power3_14 <= 34'h0;
      x_power3_13 <= 34'h0;
      x_power3_12 <= 34'h0;
      x_power3_11 <= 34'h0;
      x_power3_10 <= 34'h0; 
      x_power3_9 <= 34'h0;
      x_power3_8 <= 34'h0;
      x_power3_7 <= 34'h0;
      x_power3_6 <= 34'h0;
      x_power3_5 <= 34'h0;
      x_power3_4 <= 34'h0;
      x_power3_3 <= 34'h0;
      x_power3_2 <= 34'h0;
      x_power3_1 <= 34'h0;
      
		x_power4_20 <= 34'h0;     
      x_power4_19 <= 34'h0; 
      x_power4_18 <= 34'h0; 
      x_power4_17 <= 34'h0;
      x_power4_16 <= 34'h0;     
      x_power4_15 <= 34'h0; 
      x_power4_14 <= 34'h0; 
      x_power4_13 <= 34'h0;
      x_power4_12 <= 34'h0;     
      x_power4_11 <= 34'h0; 
      x_power4_10 <= 34'h0; 
      x_power4_9 <= 34'h0;
      x_power4_8 <= 34'h0;     
      x_power4_7 <= 34'h0; 
      x_power4_6 <= 34'h0; 
      x_power4_5 <= 34'h0;
      x_power4_4 <= 34'h0; 
      x_power4_3 <= 34'h0; 
      x_power4_2 <= 34'h0; 
      x_power4_1 <= 34'h0;
      
		x_power5_16 <= 34'h0;     
      x_power5_15 <= 34'h0;
      x_power5_14 <= 34'h0;
      x_power5_13 <= 34'h0;  
      x_power5_12 <= 34'h0;     
      x_power5_11 <= 34'h0;
      x_power5_10 <= 34'h0;
      x_power5_9 <= 34'h0;     
      x_power5_8 <= 34'h0;
      x_power5_7 <= 34'h0;
      x_power5_6 <= 34'h0;     
      x_power5_5 <= 34'h0;
      x_power5_4 <= 34'h0;
      x_power5_3 <= 34'h0;
      x_power5_2 <= 34'h0;
      x_power5_1 <= 34'h0;
      
		x_power6_12 <= 34'h0;
      x_power6_11 <= 34'h0;
      x_power6_10 <= 34'h0;
      x_power6_9 <= 34'h0;
      x_power6_8 <= 34'h0;
      x_power6_7 <= 34'h0;
      x_power6_6 <= 34'h0;
      x_power6_5 <= 34'h0;
      x_power6_4 <= 34'h0;
      x_power6_3 <= 34'h0;
      x_power6_2 <= 34'h0;
      x_power6_1 <= 34'h0;
      
		x_power7_8 <= 34'h0;
      x_power7_7 <= 34'h0;
      x_power7_6 <= 34'h0;
      x_power7_5 <= 34'h0;
      x_power7_4 <= 34'h0;
      x_power7_3 <= 34'h0;
      x_power7_2 <= 34'h0;
      x_power7_1 <= 34'h0;
      
      prod_1 <= 34'h0;
      prod_2 <= 34'h0;
      prod_3 <= 34'h0;
      prod_4 <= 34'h0;
      prod_5 <= 34'h0;
      prod_6 <= 34'h0;
      prod_7 <= 34'h0;
      
      adder_1 <= 34'h0;
      adder_2 <= 34'h0;
      adder_3 <= 34'h0;
      adder_4 <= 34'h0;
      adder_4 <= 34'h0;
      adder_5 <= 34'h0;
      adder_6 <= 34'h0;
      
      adder_temp1 <= 34'h0;
      adder_temp2 <= 34'h0;
      adder_temp3 <= 34'h0;
      adder_temp4 <= 34'h0;
      adder_temp5 <= 34'h0;
      adder_temp6 <= 34'h0;
      result_temp <= 34'h0;
      Op_Q_95 <= 32'h0;
		Done_95 <= 1'b0;
		Error_95 <= 1'b0;
    end
	end 
  else begin
     if(Enable_95)
	    begin
		  
//****************************************** Pipelining ******************************      
      nx <= nx_temp;
      x_sq <= out_x_sq;
      
		x_stage_32 <= x_stage_31;
      x_stage_31 <= x_stage_30;
      x_stage_30 <= x_stage_29;
      x_stage_29 <= x_stage_28;
      x_stage_28 <= x_stage_27;
      x_stage_27 <= x_stage_26;
      x_stage_26 <= x_stage_25;
      x_stage_25 <= x_stage_24;
      x_stage_24 <= x_stage_23;
      x_stage_23 <= x_stage_22;
      x_stage_22 <= x_stage_21;
      x_stage_21 <= x_stage_20;
      x_stage_20 <= x_stage_19;
      x_stage_19 <= x_stage_18;
      x_stage_18 <= x_stage_17;
      x_stage_17 <= x_stage_16;
      x_stage_16 <= x_stage_15;
      x_stage_15 <= x_stage_14;
      x_stage_14 <= x_stage_13;
      x_stage_13 <= x_stage_12;
      x_stage_12 <= x_stage_11;
      x_stage_11 <= x_stage_10;
      x_stage_10 <= x_stage_9;
      x_stage_9 <= x_stage_8;
      x_stage_8 <= x_stage_7;
      x_stage_7 <= x_stage_6;
      x_stage_6 <= x_stage_5;
      x_stage_5 <= x_stage_4;
      x_stage_4 <= x_stage_3;
      x_stage_3 <= x_stage_2;
      x_stage_2 <= x_stage_1;
      x_stage_1 <= nx;
      
		x_sq_stage_28 <= x_sq_stage_27;
      x_sq_stage_27 <= x_sq_stage_26;
      x_sq_stage_26 <= x_sq_stage_25;
      x_sq_stage_25 <= x_sq_stage_24;
      x_sq_stage_24 <= x_sq_stage_23;
      x_sq_stage_23 <= x_sq_stage_22;
      x_sq_stage_22 <= x_sq_stage_21;
      x_sq_stage_21 <= x_sq_stage_20;
      x_sq_stage_20 <= x_sq_stage_19;
      x_sq_stage_19 <= x_sq_stage_18;
      x_sq_stage_18 <= x_sq_stage_17;
      x_sq_stage_17 <= x_sq_stage_16;
      x_sq_stage_16 <= x_sq_stage_15;
      x_sq_stage_15 <= x_sq_stage_14;
      x_sq_stage_14 <= x_sq_stage_13;
      x_sq_stage_13 <= x_sq_stage_12;
      x_sq_stage_12 <= x_sq_stage_11;
      x_sq_stage_11 <= x_sq_stage_10;
      x_sq_stage_10 <= x_sq_stage_9;
      x_sq_stage_9 <= x_sq_stage_8;
      x_sq_stage_8 <= x_sq_stage_7;
      x_sq_stage_7 <= x_sq_stage_6;
      x_sq_stage_6 <= x_sq_stage_5;
      x_sq_stage_5 <= x_sq_stage_4;
      x_sq_stage_4 <= x_sq_stage_3;
      x_sq_stage_3 <= x_sq_stage_2;
      x_sq_stage_2 <= x_sq_stage_1;
      x_sq_stage_1 <= x_sq;
      
		x_power3_24 <= x_power3_23; 
      x_power3_23 <= x_power3_22;
      x_power3_22 <= x_power3_21;
      x_power3_21 <= x_power3_20;
      x_power3_20 <= x_power3_19; 
      x_power3_19 <= x_power3_18;
      x_power3_18 <= x_power3_17;
      x_power3_17 <= x_power3_16;
      x_power3_16 <= x_power3_15;
      x_power3_15 <= x_power3_14; 
      x_power3_14 <= x_power3_13;
      x_power3_13 <= x_power3_12;
      x_power3_12 <= x_power3_11;
      x_power3_11 <= x_power3_10;
      x_power3_10 <= x_power3_9; 
      x_power3_9 <= x_power3_8;
      x_power3_8 <= x_power3_7;
      x_power3_7 <= x_power3_6;
      x_power3_6 <= x_power3_5;    
      x_power3_5 <= x_power3_4; 
      x_power3_4 <= x_power3_3;
      x_power3_3 <= x_power3_2;
      x_power3_2 <= x_power3_1;
      x_power3_1 <= x_power3;
      
		x_power4_20 <= x_power4_19;     
      x_power4_19 <= x_power4_18; 
      x_power4_18 <= x_power4_17; 
      x_power4_17 <= x_power4_16;
      x_power4_16 <= x_power4_15;     
      x_power4_15 <= x_power4_14; 
      x_power4_14 <= x_power4_13; 
      x_power4_13 <= x_power4_12;
      x_power4_12 <= x_power4_11;     
      x_power4_11 <= x_power4_10; 
      x_power4_10 <= x_power4_9; 
      x_power4_9 <= x_power4_8;
      x_power4_8 <= x_power4_7;     
      x_power4_7 <= x_power4_6; 
      x_power4_6 <= x_power4_5; 
      x_power4_5 <= x_power4_4;
      x_power4_4 <= x_power4_3;     
      x_power4_3 <= x_power4_2; 
      x_power4_2 <= x_power4_1; 
      x_power4_1 <= x_power4;
      
		x_power5_16 <= x_power5_15;     
      x_power5_15 <= x_power5_14;
      x_power5_14 <= x_power5_13;
      x_power5_13 <= x_power5_12;  
      x_power5_12 <= x_power5_11;     
      x_power5_11 <= x_power5_10;
      x_power5_10 <= x_power5_9;
      x_power5_9 <= x_power5_8;     
      x_power5_8 <= x_power5_7;
      x_power5_7 <= x_power5_6;
      x_power5_6 <= x_power5_5;     
      x_power5_5 <= x_power5_4;
      x_power5_4 <= x_power5_3;
      x_power5_3 <= x_power5_2;     
      x_power5_2 <= x_power5_1;
      x_power5_1 <= x_power5;
      
		x_power6_12 <= x_power6_11;
      x_power6_11 <= x_power6_10;
      x_power6_10 <= x_power6_9;
      x_power6_9 <= x_power6_8;
      x_power6_8 <= x_power6_7;
      x_power6_7 <= x_power6_6;
      x_power6_6 <= x_power6_5;
      x_power6_5 <= x_power6_4;
      x_power6_4 <= x_power6_3;
      x_power6_3 <= x_power6_2;
      x_power6_2 <= x_power6_1;
      x_power6_1 <= x_power6;
      
		x_power7_8 <= x_power7_7;
      x_power7_7 <= x_power7_6;
      x_power7_6 <= x_power7_5;
      x_power7_5 <= x_power7_4;
      x_power7_4 <= x_power7_3;
      x_power7_3 <= x_power7_2;
      x_power7_2 <= x_power7_1;
      x_power7_1 <= x_power7;
      
      adder_temp1 <= adder_1;
      adder_temp2 <= adder_2;
      adder_temp3 <= adder_3;
      adder_temp4 <= adder_4;
      adder_temp5 <= adder_5;
      adder_temp6 <= adder_6;
                  
//******************************** Power Unit *************************
      x_power3 <= x_power3_temp;  // x_power3 <= (x_sq * x_satge_4);
      x_power4 <= x_power4_temp;  //x_power4 <= (x_power3 * x_stage_8);
      x_power5 <= x_power5_temp;  //x_power5 <= (x_power4 * x_stage_12);
      x_power6 <= x_power6_temp;  //x_power6 <= (x_power5 * x_stage_16);
      x_power7 <= x_power7_temp;  //x_power7 <= (x_power6 * x_stage_20);
      x_power8 <= x_power8_temp;  //x_power8 <= (x_power7 * x_stage_24);
      
//**************************** Multiplication of Input and Filter Coefficients ********************
      prod_1 <= prod1_temp;  //prod_1 <= (x_sq_stage_28 * fil_coef_1);
      prod_2 <= prod2_temp;  //prod_2 <= (x_power3_24 * fil_coef_2);
      prod_3 <= prod3_temp;  //prod_3 <= (x_power4_20 * fil_coef_3);
      prod_4 <= prod4_temp;  //prod_4 <= (x_power5_16 * fil_coef_4);
      prod_5 <= prod5_temp;  //prod_5 <= (x_power6_12 * fil_coef_5);
      prod_6 <= prod6_temp;  //prod_6 <= (x_power7_8 * fil_coef_6);
      prod_7 <= prod7_temp;  //prod_7 <= (x_power8 * fil_coef_7);
      
//***************************** Addition of Products and Calculation of Output ********************************
      adder_1 <= adder1_temp;  //adder_1 <= prod_1 + prod_2;
      adder_2 <= adder2_temp;  //adder_2 <= prod_3 + prod_4;
      adder_3 <= adder3_temp;  //adder_3 <= prod_5 + prod_6;
      adder_4 <= adder4_temp;  //adder_4 <= prod_7 + x_stage_32;
      
      adder_5 <= adder5_temp;  //adder_5 <= adder_temp1 + adder_temp2;
      adder_6 <= adder6_temp;  //adder_6 <= adder_temp3 + adder_temp4;
      
      result_temp <= result_temp1; //result_temp <= adder_temp5 + adder_temp6;
		 if(result_temp[33:32] == 2'b10)
		    begin
		     Error_95 <= 1'b1;
		     Done_95 <= 1'b0;
		     Op_Q_95 <= 32'h0;   //result_temp[31:0];
		    end
		  else begin
		   Error_95 <= 1'b0;
		   Done_95 <= 1'b1;
         Op_Q_95 <= result_temp[31:0];
		end
		end
	end
 end
endmodule
