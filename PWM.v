module PWM_Generator_Verilog
 (
 clk, 
 increase_duty 
 decrease_duty, 
 PWM_OUT 
    );
 input clk;
 input increase_duty;
 input decrease_duty;
 output PWM_OUT;
 wire slow_clk_enable; 
 reg[27:0] counter_debounce=0 
 wire tmp1,tmp2,duty_inc;
 wire tmp3,tmp4,duty_dec;
 reg[3:0] counter_PWM=0;
 reg[3:0] DUTY_CYCLE=5; 
)
 always @(posedge clk)
 begin
   counter_debounce <= counter_debounce + 1;
   if(counter_debounce>=1) 
    counter_debounce <= 0;
 end
assign slow_clk_enable = counter_debounce == 1 ?1:0;
 
 DFF_PWM PWM_DFF1(clk,slow_clk_enable,increase_duty,tmp1);
 DFF_PWM PWM_DFF2(clk,slow_clk_enable,tmp1, tmp2); 
 assign duty_inc =  tmp1 & (~ tmp2) & slow_clk_enable;
DFF_PWM PWM_DFF3(clk,slow_clk_enable,decrease_duty, tmp3);
 DFF_PWM PWM_DFF4(clk,slow_clk_enable,tmp3, tmp4); 
 assign duty_dec =  tmp3 & (~ tmp4) & slow_clk_enable;
always @(posedge clk)
 begin
   if(duty_inc==1 && DUTY_CYCLE <= 9) 
    DUTY_CYCLE <= DUTY_CYCLE + 1;
   else if(duty_dec==1 && DUTY_CYCLE>=1) 
    DUTY_CYCLE <= DUTY_CYCLE - 1;
 end 

 always @(posedge clk)
 begin
   counter_PWM <= counter_PWM + 1;
   if(counter_PWM>=9) 
    counter_PWM <= 0;
 end
 assign PWM_OUT = counter_PWM < DUTY_CYCLE ? 1:0;
endmodule
module DFF_PWM(clk,en,D,Q);
input clk,en,D;
output reg Q;
always @(posedge clk)
begin 
 if(en==1)
  Q <= D;
end 
endmodule 
