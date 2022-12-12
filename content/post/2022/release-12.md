---
title: "Tabby CAD Suite version 20221205 released!"
date: 2022-12-12
description : ""
image: /static-2022/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The December release of Tabby CAD Suite is now available for download. Notable changes in this version include:

* We have improved support for SystemVerilog `config` elements. You can now have multiple configurations defined, and select which configuration to elaborate with `verific -import &lt;configname>`.
* We are working on improving the TCL integration in Yosys. There is now an interactive TCL shell mode: use `yosys -C` to enter the TCL shell. You can now also use the following command to get the output of a command returned to TCL without the use of an intermediate file: `set command_output [yosys tee -s result.string &lt;command>]`

# In other YosysHQ news

* We had another [great guest blogpost](https://blog.yosyshq.com/p/logic-primitive-transformations-with-yosys-techmap/) from Tom Verbeure. He wrote about how Yosys does techmapping, in particular logic primitive transformations.  If you’ve not read any of Tom’s other writing, he has a very [interesting index here](https://tomverbeure.github.io/). Two of our favourites are [Post-Simulation Waveform-Based RISC-V with GDB](https://tomverbeure.github.io/2022/02/20/GDBWave-Post-Simulation-RISCV-SW-Debugging.html) and [Cosimulating Verilog and VHDL with CXXRTL](https://tomverbeure.github.io/2020/11/04/VHDL_Verilog_Cosimulation_with_CXXRTL.html).
* We are starting a ‘[community spotlight](https://www.linkedin.com/feed/update/urn:li:activity:7006604942450810880)’ feature to help highlight useful open source EDA tools. If you have a tip, please let us know.
