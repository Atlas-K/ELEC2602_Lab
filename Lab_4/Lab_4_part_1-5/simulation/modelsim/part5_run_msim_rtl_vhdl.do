transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_4/Lab_4_part_1-5/vhdl/hex2sevenSeg.vhd}
vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_4/Lab_4_part_1-5/vhdl/fourHexDisplay.vhd}
vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_4/Lab_4_part_1-5/vhdl/fourBitReg.vhd}

vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_4/Lab_4_part_1-5/vhdl/testbench_fourHexDisplay.vhd}
vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_4/Lab_4_part_1-5/vhdl/hex2sevenSeg.vhd}
vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_4/Lab_4_part_1-5/vhdl/fourHexDisplay.vhd}
vcom -93 -work work {C:/Users/atlas/Desktop/ELEC2602/Lab/Lab_4/Lab_4_part_1-5/vhdl/fourBitReg.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  testbench_fourHexDisplay

add wave *
view structure
view signals
run 1000 ns
