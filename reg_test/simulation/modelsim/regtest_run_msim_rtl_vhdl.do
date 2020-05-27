transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Project/vhdl/reg_file.vhd}

vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/reg_test/../Project/vhdl/reg_test.vhd}
vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/reg_test/../Project/vhdl/reg_file.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  reg_test

add wave *
view structure
view signals
run 200 ns
