
QUARTUS_ROOT?= C:/intelFPGA_lite/17.0/quartus
DEVICE_FAMILY = cycloneive

PROJECT = fixed_test
TB = ./../../../rtl/vhdl/$(PROJECT)_tb.vhd
TB_MODULE = $(PROJECT)_tb

NET_LIST = $(PROJECT).vho

VCOM_ARGS = -quiet -2008 

VSIM_ARGS  = -quiet -t ps -sdftyp /dut=led_test_vhd.sdo +transport_int_delays +transport_path_delays -do "run -all"
GVSIM_ARGS = -quiet -t ps -sdftyp /dut=led_test_vhd.sdo +transport_int_delays +transport_path_delays -do "add wave *;run -all"

WORK = gate_work

V?=@
all: lib com sim
sim: 
	$(V)echo " "
	$(V)echo " -------   Starting Simulation!!!!!  --------------------"
	$(V)vsim -c $(VSIM_ARGS) $(WORK).$(TB_MODULE)
gsim: 
	$(V)echo " "
	$(V)echo " -------   Starting GUI Simulation!!!!!  --------------------"
	$(V)vsim $(GVSIM_ARGS) $(WORK).$(TB_MODULE)
com: $(NET_LIST) 
	$(V)echo " "
	$(V)echo " -------   Compiling testbench & netlist !!! ------------"
	$(V)vcom $(VCOM_ARGS)  -work $(WORK) $(NET_LIST) $(TB)
lib:
	$(V)echo " -------   Generate work directory if it does not exist!!! ----------"
	$(V)if [ -d $(WORK) ]; then vdel -lib $(WORK) -all && vlib $(WORK); fi
	$(V)if [ ! -d $(WORK) ]; then vlib $(WORK); fi

$(NET_LIST): 
	$(V)echo " "
	$(V)echo " ------- Generating netlist!!!!! -----------"
	$(V)make -C ./../../pnr/quartus/ netlist
clean:
	$(V)echo " "
	$(V)echo " ------- Clearing this folder!!!!! ---------"
	$(V)rm -rf *.vo *.sdo *.xrf *.sft transcript $(WORK) *.wlf *.csd verilog_libs *.vho *.sdo *.sft *.wlf *.tcl
# vsim -c -quiet -t ps "+transport_int_delays" "+transport_path_delays" -do "run -all" gate_work.led_test_tb
