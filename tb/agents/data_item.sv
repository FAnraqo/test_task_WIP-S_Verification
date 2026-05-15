class data_item extends uvm_sequence_item;
    
    rand logic [9:0] inp1;
    rand logic [9:0] inp2;
    rand logic       valid_i;

    logic outp;
    logic valid_o;

    `uvm_object_utils_begin(data_item)
        `uvm_field_int(inp1,    UVM_ALL_ON)
        `uvm_field_int(inp2,    UVM_ALL_ON)
        `uvm_field_int(valid_i, UVM_ALL_ON)
        `uvm_field_int(outp,    UVM_ALL_ON)
        `uvm_field_int(valid_o, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "data_item");
        super.new(name);
    endfunction

endclass
