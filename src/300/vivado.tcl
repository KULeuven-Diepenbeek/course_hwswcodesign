################################################################################
# Emerging technologies, Systems & Security
#
#   date: January 15th 2024
#   author: VlJo
################################################################################
# Script to generate a Vivado project for HW/SW codesign (100)
#
################################################################################

# set parameters
set pname "hwswcodesign_300"
set srcpath "/home/jvliegen/vc/github/KULeuven-Diepenbeek/course_hwswcodesign/src/300/hdl"
set projpath "/home/jvliegen/sandbox/course_hwswcodesign"
set part "xc7vx485tffg1761-2"
set board "xilinx.com:vc707:part0:1.3"

# delete older versions
cd $projpath
exec rm -Rf $pname

# create project
create_project $pname $projpath/$pname -part $part
set_property board_part $board [current_project]
set_property target_language VHDL [current_project]



# add VHDL source files
set fnames [glob -directory $srcpath -- "*.vhd"]
foreach fname $fnames {
    add_files $fname
}

# add verilog source files
set fnames [glob -directory $srcpath -- "*.v"]
foreach fname $fnames {
    add_files $fname
}

# add simulation source files
set fnames [glob -directory $srcpath/tb -- "*.vhd"]
foreach fname $fnames {
    add_files -fileset sim_1 $fname
}

# add constraint files
set fnames [glob -directory $srcpath/../xdc -- "*.xdc"]
foreach fname $fnames {
    add_files -fileset constrs_1 $fname
}


set_property STEPS.SYNTH_DESIGN.ARGS.ASSERT true [get_runs synth_1]
set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value {-mode out_of_context} -objects [get_runs synth_1]