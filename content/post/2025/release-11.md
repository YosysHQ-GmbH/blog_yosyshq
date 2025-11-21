---
title: "Tabby CAD Suite version 20251111 released!"
date: 2025-11-11
description : ""
image: /static-2023/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The November release of Tabby CAD Suite is now available for download. Notable changes in this version include:

* SBY: You can now set the number of timesteps that is used for the global clock period in the VCD trace with the option `cycle_width N` in `[options]`. This only applies to traces produced with the option `vcd_sim on`.
* The RTLIL parser and the pyosys bindings in Yosys have been rewritten. This should not introduce any functional changes, but improve execution time and maintainability.

In other YosysHQ news:

* The FOSSi Foundation recently announced the inaugural edition of [Down Underflow](https://fossi-foundation.org/downunderflow/2026), a conference dedicated to free and open source silicon for the southern hemisphere, following the pattern of the European [ORConf](https://fossi-foundation.org/orconf/2025) and North American [LatchUp](https://fossi-foundation.org/latch-up/2025) conference series which we have enjoyed attending. It will take place in Sydney on February 28, 2026. If you are near Australia or enjoy a bit of travel, be sure to check it out - registration is as always free!
* Video recordings from this year's FSiC conference in early July have finally been [uploaded](https://peertube6.f-si.org/). Catch up on the many interesting contributions presented!

Happy November,

The YosysHQ Team
