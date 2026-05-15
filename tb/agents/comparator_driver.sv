class comparator_driver extends uvm_driver #(data_item);
    `uvm_component_utils(comparator_driver)

    virtual data_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual data_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", {"Интерфейс не найден для: ", get_full_name()})
    endfunction

    virtual task run_phase(uvm_phase phase);
        vif.valid_i <= 0;
        vif.inp1_i  <= 0;
        vif.inp2_i  <= 0;
        wait(vif.rstn == 1'b1);

        forever begin
            @(posedge vif.clk);
            seq_item_port.try_next_item(req);
            
            if (req != null) begin
                vif.valid_i <= req.valid_i;
                if (req.valid_i) begin
                    vif.inp1_i <= req.inp1;
                    vif.inp2_i <= req.inp2;
                end
                seq_item_port.item_done();
            end else begin
                vif.valid_i <= 0; 
            end
        end
    endtask
endclass
