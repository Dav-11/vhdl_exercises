`timescale 1ns / 1ps

module tb_pwm_led;

  parameter int SYS_CLK_FREQ = 1000;
  parameter int PWM_FREQ = 100;
  parameter int BRIGHTNESS_LEVELS = 4;

  // 10ns (100MHz) clock for the toggle.
  parameter int CLK_PERIOD = 10;

  logic clk;
  logic rst;
  logic [2:0] brightness;
  logic pwm_out;

  // dut
  pwm_led #(
      .SYS_CLK_FREQ(SYS_CLK_FREQ),
      .PWM_FREQ(PWM_FREQ),
      .BRIGHTNESS_LEVELS(BRIGHTNESS_LEVELS)
  ) dut (
      .clk(clk),
      .rst(rst),
      .brightness(brightness),
      .pwm_out(pwm_out)
  );


  // clock
  always #(CLK_PERIOD / 2) clk = ~clk;

  /******************************
     * TASKS
     ******************************/

  task automatic do_reset();
    @(posedge clk);
    rst = 1;
    brightness = 0;
    repeat (2) @(posedge clk);
    rst = 0;
    @(posedge clk);
  endtask

  task automatic check_brightness(input logic [1:0] b);
    int PERIOD_TICKS = SYS_CLK_FREQ / PWM_FREQ;
    int expected_high = (int'(b) * (PERIOD_TICKS-1)) / BRIGHTNESS_LEVELS;

    // reset
    do_reset();

    // Update the input
    @(posedge clk);
    brightness = b;

    // Wait for the PWM counter to wrap to 0 to start a clean check
    // (Assuming your DUT counter wraps at MAX_COUNT-1)
    // If you don't care about the alignment, you can remove this wait.
    $display("Checking Brightness: %0d (Expected High: %0d cycles)", b, expected_high);

    for (int i = 0; i < PERIOD_TICKS; i++) begin
      @(posedge clk);
      //#1;  // Small delay to sample output after the clock edge

      if (i < expected_high) begin
        if (pwm_out !== 1'b1)
          $error("Time %t: PWM should be HIGH at tick %0d, but is LOW", $time, i);
      end else begin
        if (pwm_out !== 1'b0)
          $error("Time %t: PWM should be LOW at tick %0d, but is HIGH", $time, i);
      end
    end

    $display("Brightness %0d check complete.", b);
  endtask

  /******************************
     * TEST
     ******************************/

  initial begin

    // init input
    rst = 0;
    clk = 0;

    // Test some brightness

    // check_brightness(3'b000);  // OFF
    check_brightness(3'b001);
    // check_brightness(3'b010);
    // check_brightness(3'b011);
    // check_brightness(3'b100);  // FULL ON

    $display("Simulation Finished");
    $finish;

  end

endmodule : tb_pwm_led
;
