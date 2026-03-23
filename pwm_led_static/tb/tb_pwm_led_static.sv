`timescale 1ns / 1ps

module tb_pwm_led_static;

  parameter int SYS_CLK_FREQ = 1000;
  parameter int PWM_FREQ = 100;
  parameter int DUTY = 25;

  // Clock period for 1000Hz (1ms) -> 1,000,000ns.
  // But let's just use a standard 10ns (100MHz) clock for the toggle.
  parameter int CLK_PERIOD = 10;

  logic clk;
  logic rst;
  logic pwm_out;

  // dut
  pwm_led_static #(
      .SYS_CLK_FREQ(SYS_CLK_FREQ),
      .PWM_FREQ(PWM_FREQ),
      .DUTY_CYCLE_PERCENT(DUTY)
  ) dut (
      .clk(clk),
      .rst(rst),
      .pwm_out(pwm_out)
  );


  // clock
  always #(CLK_PERIOD / 2) clk = ~clk;

  /******************************
     * TASKS
     ******************************/

  task automatic do_reset();
    rst = 1;
    repeat (5) @(posedge clk);
    rst = 0;
    @(posedge clk);
  endtask

  /******************************
     * TEST
     ******************************/

  initial begin

    // init input
    rst = 1;
    clk = 0;

  end


endmodule : tb_pwm_led_static
;
