---
title: "Tabby CAD Suite version 20230208 released!"
date: 2023-02-08
description : ""
image: /static-2023/YOS_horiz.png
tags: ["release notes"]
draft: false
---

Tabby CAD Suite version 20230208 released!

The February release of Tabby CAD Suite is now available for download. Notable changes in this version include:

* SBY can now use Yosys’s builtin simulation command “sim” to generate counter-example traces. This can be enabled with the “vcd_sim on” option and will become the default in a later release.
* Using Yosys’s “sim” command, SBY now supports writing traces in gtkwave’s FST format in addition to the VCD format. FST files offer improved handling of signal names containing special characters, native compression and faster load times. This can be enabled with the “fst on” option

In other YosysHQ news:

* We have a new guest blog post from Victor Suarez Rovere and Juilan Kemmerer about a [fully open source “C to FPGA” toolchain](https://blog.yosyshq.com/p/3d-raytracing/).
* YosysHQ is working with Tillitis in the [development of their next FPGA based product](https://blog.yosyshq.com/p/tillitis-and-yosyshq/).

Happy February,
The YosysHQ Team
