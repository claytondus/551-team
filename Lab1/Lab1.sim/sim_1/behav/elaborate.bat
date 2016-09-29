@echo off
set xv_path=C:\\Xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xelab  -wto 0592baa871654fc9a806dd2d46bbd028 -m64 --debug typical --relax -L xil_defaultlib -L secureip --snapshot Lab1Sim_behav xil_defaultlib.Lab1Sim -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
