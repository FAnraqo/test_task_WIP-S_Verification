import uvm_pkg::*;

`include "data_item.sv"
`include "comparator_sequencer.sv"
`include "comparator_driver.sv"
`include "comparator_monitor.sv"
`include "comparator_agent.sv"
`include "comparator_scoreboard.sv"
`include "comparator_env.sv"
`include "comparator_seqs.sv"
`include "comparator_test_lib.sv"

module top;
    logic clk;
    logic rstn;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rstn = 0;
        #25 rstn = 1;
    end

    data_if vif(clk, rstn);

    data_comparator dut (
        .clk     (vif.clk),
        .rstn    (vif.rstn),
        .inp1_i  (vif.inp1_i),
        .inp2_i  (vif.inp2_i),
        .valid_i (vif.valid_i),
        .outp_o  (vif.outp_o),
        .valid_o (vif.valid_o)
    );

    initial begin
        uvm_config_db#(virtual data_if)::set(null, "*", "vif", vif);
        run_test();
    end
endmodule
