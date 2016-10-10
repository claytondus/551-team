#!/bin/sh -f
xv_path="/home/cd/Xilinx/Vivado/2014.4"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim Lab1Sim_behav -key {Behavioral:sim_1:Functional:Lab1Sim} -tclbatch Lab1Sim.tcl -log simulate.log
