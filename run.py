#!/usr/bin/env python3


import os
import sys
import glob

try:
    os.system("iverilog -g2012 -o tb_topModule tb_topModule.sv topModule.sv mips.sv imem.sv dmem.sv alu.sv regfile.sv ctrl.sv dpath.sv")
    print("iverilog command successful ;)")
except:
    print("iverilog command failed ;(")

try:
    os.system("vvp tb_topModule")
    print("vvp command successful ;)")
except:
    print("vvp command failed ;(")

try:
    os.system("gtkwave tb_topModule.vcd")
    print("gtkwave open ;)")
except:
    print("gtkwave failed to open ;(")
