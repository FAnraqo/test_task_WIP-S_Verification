BANNER     = "*******************************************************************************"
VERILATOR  = verilator
COV_TOOL   = verilator_coverage
TOP_MODULE = top
SV_SOURCES = ../rtl/data_comparator.sv \
             ../tb/top.sv \
             ../sv/interface.sv

UVM_HOME       = /opt/1800.2-2017-1.0/src
UVM_PKG        = $(UVM_HOME)/uvm_pkg.sv
UVM_TESTNAME  ?= random_test
ALL_TESTNAMES = random_test equal_test zero_test max_test

OBJ_DIR  = obj_dir
LOG_DIR  = logs
CMP_LOG  = $(LOG_DIR)/verilator_compile.log
COV_DIR  = $(LOG_DIR)/coverage
COV_FILE = $(COV_DIR)/$(UVM_TESTNAME).cov

RUN_FLAGS = +uvm_set_action=*,UVM/COMP/NAME,UVM_WARNING,UVM_NO_ACTION

VERILATOR_FLAGS = --main \
                  --top-module $(TOP_MODULE) \
                  --binary \
                  --build \
                  --cc \
                  --Mdir $(OBJ_DIR) \
                  --error-limit 5 \
                  --hierarchical \
                  --coverage \
                  -j 2 \
                  -Wall \
                  --timescale 1ns/1ns

DISABLED_WARNINGS= -Wno-DECLFILENAME \
                   -Wno-CONSTRAINTIGN \
                   -Wno-MISINDENT \
                   -Wno-VARHIDDEN \
                   -Wno-WIDTHTRUNC \
                   -Wno-CASTCONST \
                   -Wno-WIDTHEXPAND \
                   -Wno-UNDRIVEN \
                   -Wno-UNUSEDSIGNAL \
                   -Wno-UNUSEDPARAM \
                   -Wno-SYMRSVDWORD \
                   -Wno-ZERODLY \
                   -Wno-CASEINCOMPLETE \
                   -Wno-SIDEEFFECT \
                   -Wno-fatal \
                   -Wno-REALCVT

INCDIRS = +incdir+"$(UVM_HOME)" \
          +incdir+../rtl \
          +incdir+../sv \
          +incdir+../tb \
          +incdir+../tb/agents \
          +incdir+../tb/env \
          +incdir+../tb/tests

DEFINES = +define+UVM_REPORT_DISABLE_FILE_LINE \
          +define+UVM_NO_DPI \
          +define+SVA_ON

.PHONY: build run_test run_regression

build: clean $(OBJ_DIR)/V$(TOP_MODULE)

run_test: clean $(OBJ_DIR)/V$(TOP_MODULE) run_one_test cov_report

run_regression: clean $(OBJ_DIR)/V$(TOP_MODULE) run_all_tests cov_report

$(OBJ_DIR)/V$(TOP_MODULE): $(SV_SOURCES)
	@echo ""
	@echo $(BANNER)
	@echo "Compiling..."
	@echo $(BANNER)
	@echo ""
	@mkdir -p $(LOG_DIR)
	$(VERILATOR) $(VERILATOR_FLAGS) $(DISABLED_WARNINGS) $(DEFINES) $(INCDIRS) $(UVM_PKG) $(SV_SOURCES) 2>&1 | tee $(CMP_LOG)

clean:
	@echo ""
	@echo $(BANNER)
	@echo "Delete _all_ generated files..."
	@echo $(BANNER)
	@echo ""
	rm -rf $(OBJ_DIR) $(LOG_DIR)

run_one_test:
	@echo ""
	@echo $(BANNER)
	@echo "Running test: $(UVM_TESTNAME)"
	@echo $(BANNER)
	@echo ""
	@mkdir -p $(LOG_DIR)
	./$(OBJ_DIR)/V$(TOP_MODULE) +UVM_TESTNAME="$(UVM_TESTNAME)" $(RUN_FLAGS) 2>&1 | tee $(LOG_DIR)/$(UVM_TESTNAME)_run.log

run_all_tests:
	@echo ""
	@echo $(BANNER)
	@echo "Running REGRESSION..."
	@echo $(BANNER)
	@echo ""
	@mkdir -p $(LOG_DIR)
	@for testname in $(ALL_TESTNAMES); do \
		echo "Starting $$testname..."; \
		./$(OBJ_DIR)/V$(TOP_MODULE) +UVM_TESTNAME="$$testname" $(RUN_FLAGS) 2>&1 | tee $(LOG_DIR)/$$testname_run.log; \
	done
	@echo "Regression finished. Check logs in $(LOG_DIR)"

cov_report:
	@echo ""
	@echo $(BANNER)
	@echo "Генерация отчета по покрытию (Coverage Report)..."
	@echo $(BANNER)
	@echo ""
	@mkdir -p $(LOG_DIR)/annotated
	verilator_coverage --annotate $(LOG_DIR)/annotated coverage.dat
	@echo ""
	@cat logs/annotated/data_comparator.sv
    