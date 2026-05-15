//base_test
class base_test extends uvm_test;
    `uvm_component_utils(base_test)

    comparator_env env;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Окружение создается ОДИН РАЗ в базовом тесте
        env = comparator_env::type_id::create("env", this);
    endfunction
endclass

//random_test
class random_test extends base_test;
    `uvm_component_utils(random_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    virtual task run_phase(uvm_phase phase);
        random_sequence seq;
        phase.raise_objection(this);
        `uvm_info("TEST", "Запуск random_test...", UVM_LOW)
        seq = random_sequence::type_id::create("seq");
        seq.start(env.agent.sequencer);
        #100; // Ждем прохождения конвейера
        phase.drop_objection(this);
    endtask
endclass

//equal_test
class equal_test extends base_test;
    `uvm_component_utils(equal_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    virtual task run_phase(uvm_phase phase);
        equal_sequence seq;
        phase.raise_objection(this);
        `uvm_info("TEST", "Запуск equal_test...", UVM_LOW)
        seq = equal_sequence::type_id::create("seq");
        seq.start(env.agent.sequencer);
        #100;
        phase.drop_objection(this);
    endtask
endclass

//zero_test
class zero_test extends base_test;
    `uvm_component_utils(zero_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    virtual task run_phase(uvm_phase phase);
        zero_sequence seq;
        phase.raise_objection(this);
        `uvm_info("TEST", "Запуск zero_test...", UVM_LOW)
        seq = zero_sequence::type_id::create("seq");
        seq.start(env.agent.sequencer);
        #100;
        phase.drop_objection(this);
    endtask
endclass

//max_test
class max_test extends base_test;
    `uvm_component_utils(max_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    virtual task run_phase(uvm_phase phase);
        max_sequence seq;
        phase.raise_objection(this);
        `uvm_info("TEST", "Запуск max_test...", UVM_LOW)
        seq = max_sequence::type_id::create("seq");
        seq.start(env.agent.sequencer);
        #100;
        phase.drop_objection(this);
    endtask
endclass
