class random_sequence extends uvm_sequence #(data_item);
    `uvm_object_utils(random_sequence)
    function new(string name = "random_sequence"); super.new(name); endfunction

    virtual task body();
        data_item req;
        repeat(20) begin
            req = data_item::type_id::create("req");
            start_item(req);
            if (!req.randomize()) `uvm_error("SEQ", "Ошибка рандомизации!")
            finish_item(req);
        end
    endtask
endclass

class equal_sequence extends uvm_sequence #(data_item);
    `uvm_object_utils(equal_sequence)
    function new(string name = "equal_sequence"); super.new(name); endfunction

    virtual task body();
        data_item req;
        repeat(10) begin
            req = data_item::type_id::create("req");
            start_item(req);
            if (!req.randomize() with { inp1 == inp2; }) `uvm_error("SEQ", "Ошибка рандомизации!")
            finish_item(req);
        end
    endtask
endclass

class zero_sequence extends uvm_sequence #(data_item);
    `uvm_object_utils(zero_sequence)
    function new(string name = "zero_sequence"); super.new(name); endfunction

    virtual task body();
        data_item req;
        repeat(5) begin
            req = data_item::type_id::create("req");
            start_item(req);
            if (!req.randomize() with { inp1 == 0; inp2 == 0; valid_i == 1;}) `uvm_error("SEQ", "Ошибка рандомизации!")
            finish_item(req);
        end
    endtask
endclass

class max_sequence extends uvm_sequence #(data_item);
    `uvm_object_utils(max_sequence)
    function new(string name = "max_sequence"); super.new(name); endfunction

    virtual task body();
        data_item req;
        repeat(5) begin
            req = data_item::type_id::create("req");
            start_item(req);
            if (!req.randomize() with { inp1 == 1023; inp2 == 1023; valid_i == 1;}) `uvm_error("SEQ", "Ошибка рандомизации!")
            finish_item(req);
        end
    endtask
endclass
