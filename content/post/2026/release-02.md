---
title: "Tabby CAD Suite version 20260204 released!"
date: 2026-02-04
description : ""
image: /static-2023/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The February release of Tabby CAD Suite is now available for download. Notable changes in this version include:

* Added an explicit `verific -sv2017` option. Previously SystemVerilog 2017 was only accessible via the `-sv` option, which always refers to the latest SystemVerilog standard available (currently still 2017).
* File lists can now contain VHDL files, and allow mixing of SystemVerilog and VHDL files. You can optionally specify the standard version to use for both languages in the command: `verific -f -vhdl2008 -sv2017 list.f`
* As there can be only one work library specified per verific command, if your design declares multiple libraries, you need to create a separate file list for each library.

In other YosysHQ news:

* ESA’s Comet Interceptor will be the first mission to visit a pristine comet arriving from the outer reaches of the Solar System -carrying material untouched since its formation. And the MIRMIS sensor has been [formally proven with our tools](https://www.linkedin.com/feed/update/urn:li:activity:7421548719919157248)! 
* Join the [Yosys User’s Group today at 18:00 CET](https://docs.google.com/document/d/13e8hERQ_eqLQrdtH1WXnGUXDtgyQ8oa_zZWXPHJCiN0/edit?tab=t.0#heading=h.gzmgo2cq3dws) to ask us questions about formal, roadmap or anything else!

Happy February,

The YosysHQ Team
