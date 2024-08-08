module tb_PWM_Generator_Verilog;
 // Inputs
 reg clk;
 reg increase_duty;
 reg decrease_duty;
 // Outputs
 wire PWM_OUT;
PWM_Generator_Verilog PWM_Generator_Unit(
  .clk(clk), 
  .increase_duty(increase_duty), 
  .decrease_duty(decrease_duty), 
  .PWM_OUT(PWM_OUT)
 );
initial begin
 clk = 0;
 forever #5 clk = ~clk;
 end 
 initial begin
  increase_duty = 0;
  decrease_duty = 0;
  #100; 
    increase_duty = 1; 
  #100;
    increase_duty = 0;
  #100; 
    increase_duty = 1;
  #100;
    increase_duty = 0;
  #100; 
    increase_duty = 1;
  #100;
    increase_duty = 0;
  #100;
    decrease_duty = 1; 
  #100;
    decrease_duty = 0;
  #100; 
    decrease_duty = 1;
  #100;
    decrease_duty = 0;
  #100;
    decrease_duty = 1;
  #100;
    decrease_duty = 0;
 end
endmodule
