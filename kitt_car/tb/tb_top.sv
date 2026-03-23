`timescale 1ns / 1ps


module tb_top;

    // params
    parameter int WIDTH = 8;
    parameter int CLK_PERIOD = 5;

    logic clk;
    logic rst;
    logic data_in;
    logic [WIDTH-1:0] data_out;

    // dut
    top #(
        .WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .data_out(data_out)
    );

    // clock
    always #(CLK_PERIOD/2) clk = ~clk;
    
    // Helper task to drive data synchronously
    task shift_bit(input logic bit_in);
        @(posedge clk);
        #1; // Small skew to mimic real hardware setup time
        data_in = bit_in;
    endtask

    // test
    initial begin
        
        // Initialize Inputs
        rst = 1;
        data_in = 0;
        clk = 0;

        // Hold reset for a few cycles
        #(CLK_PERIOD * 2);
        rst = 0;
        
        // Task: Shift in a specific pattern (e.g., 0xA5 -> 10100101)
        // We'll feed bits one by one
        shift_bit(1);
        shift_bit(1);
        shift_bit(1);
        shift_bit(1);
        shift_bit(1);
        shift_bit(1);
        shift_bit(0);
        shift_bit(1);

        // Wait to see the full parallel output
        #(CLK_PERIOD * 5);
        
        $display("Simulation Finished. Final dout: %b", data_out);
        $finish;
    end

endmodule: tb_top
