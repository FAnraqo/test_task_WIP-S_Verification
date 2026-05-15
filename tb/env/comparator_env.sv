class comparator_env extends uvm_env;
    `uvm_component_utils(comparator_env)

    comparator_agent      agent;
    comparator_scoreboard scoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = comparator_agent::type_id::create("agent", this);
        scoreboard = comparator_scoreboard::type_id::create("scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        agent.monitor.ap_in.connect(scoreboard.input_fifo.analysis_export);
        agent.monitor.ap_out.connect(scoreboard.output_fifo.analysis_export);
    endfunction
endclass
