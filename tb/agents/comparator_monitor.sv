class comparator_monitor extends uvm_monitor;
    `uvm_component_utils(comparator_monitor)

    virtual data_if vif;

    uvm_analysis_port #(data_item) ap_in;
    uvm_analysis_port #(data_item) ap_out;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap_in = new("ap_in", this);
        ap_out = new("ap_out", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual data_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", {"Интерфейс не найден для: ", get_full_name()})
    endfunction

    virtual task run_phase(uvm_phase phase);
        wait(vif.rstn == 1'b1);
        
        fork
            monitor_inputs();
            monitor_outputs();
        join
    endtask

    task monitor_inputs();
        data_item item;
        forever begin
            @(posedge vif.clk);
            if (vif.valid_i) begin
                item = data_item::type_id::create("item");
                item.valid_i = vif.valid_i;
                item.inp1    = vif.inp1_i;
                item.inp2    = vif.inp2_i;
                ap_in.write(item);
            end
        end
    endtask

    task monitor_outputs();
        data_item item;
        forever begin
            @(posedge vif.clk);
            if (vif.valid_o) begin
                item = data_item::type_id::create("item");
                item.valid_o = vif.valid_o;
                item.outp    = vif.outp_o;
                ap_out.write(item);
            end
        end
    endtask
endclass
