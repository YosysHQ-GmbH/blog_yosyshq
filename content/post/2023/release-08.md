---
title: "Tabby CAD Suite version 20230807 released!"
date: 2023-08-07
description : ""
image: /static-2023/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The August release of Tabby CAD Suite is now available for download. Notable changes in this version include:

* The verific command now has a new option -lib to load all modules from the specified files as blackbox modules, disregarding their contents. This is useful especially for loading primitives from a simulation library, e.g.:

```
verific -sv -lib cells_sim.v
verific -work unisim -vhdl -lib unisim_VCOMP.vhd
```

 The files still need to be parseable by verific, so some limitations remain on the contents of the blackboxed modules, but it is possible to ignore some errors by first calling verific -set-warning VERI-XXXX for the corresponding error code.

In other YosysHQ news:

* Our newest blog post explores another one-line yosys solution, this time for a problem with [non-alphanumeric characters in netnames](/p/yosys-one-liners-rename/)
* YosysHQ was present at the Free Silicon Conference at Sorbonne University in Paris in July, check out the [recordings of Nina's talk online](https://peertube.f-si.org/videos/watch/b6ccf0de-06c3-42d3-897a-1e81cbe04ac1)

Happy August,
The YosysHQ Team
