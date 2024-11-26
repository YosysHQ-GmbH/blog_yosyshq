---
title: "Tabby CAD Suite version 20240709 released!"
date: 2024-07-09
description : ""
image: /static-2023/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The July release of Tabby CAD Suite is now available for download. This month's notable changes mainly affect the build process, so are not relevant if you download our binaries. For those of you subscribing to the YosysHQ Verific Patch and building from source:

* We have reorganized the build flags for compiling with Verific to try to support more flavors of Verific (more documentation to follow). We have tried to keep existing configurations working, but if you encounter any build issues when updating to the latest release, try a full clean (`make clean` and `make clean-abc`) and check if you need to set any of the new <code>[ENABLE_VERIFIC_*](https://github.com/YosysHQ/yosys/pull/4459)</code> flags in your <code>Makefile.conf</code>.
* The minimum supported C++ standard version has been updated to C++17. The compiler flags in the Makefile have been changed to reflect this, but if you are manually setting an older flag, you may need to update your configuration.

In other YosysHQ news:

* The recordings of the FPGA Lightning talks from our last Yosys Users Group meeting are now online! Check them out on [our youtube channel](https://www.youtube.com/@YosysHQ/videos).

Happy July,

The YosysHQ Team

