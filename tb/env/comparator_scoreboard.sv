class comparator_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(comparator_scoreboard)

    // Специальные FIFO для приема данных от Монитора
    uvm_tlm_analysis_fifo #(data_item) input_fifo;
    uvm_tlm_analysis_fifo #(data_item) output_fifo;

    logic expected_queue[$];

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        input_fifo = new("input_fifo", this);
        output_fifo = new("output_fifo", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        fork
            process_inputs();
            process_outputs();
        join
    endtask

    virtual task process_inputs();
        data_item item;
        logic expected_res;
        forever begin
            input_fifo.get(item); 
            
            expected_res = (item.inp1 == item.inp2);
            
            expected_queue.push_back(expected_res);
        end
    endtask

    virtual task process_outputs();
        data_item item;
        logic expected_res;
        forever begin
            output_fifo.get(item); 
            
            if (expected_queue.size() > 0) begin
                expected_res = expected_queue.pop_front();
                
                if (item.outp === expected_res) begin
                    `uvm_info("SCOREBOARD", $sformatf("PASS: expected=%0b, actual=%0b", expected_res, item.outp), UVM_LOW)
                end else begin
                    `uvm_error("SCOREBOARD", $sformatf("FAIL: expected=%0b, actual=%0b", expected_res, item.outp))
                end
            end else begin
                `uvm_error("SCOREBOARD", "Получен выходной сигнал, но ожиданий в очереди нет (неожиданный valid_o)!")
            end
        end
    endtask
endclass
