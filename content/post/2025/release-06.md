---
title: "Tabby CAD Suite version 20250609 released!"
date: 2025-06-09
description : ""
image: /static-2023/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The June release of Tabby CAD Suite is now available for download. Notable changes in this version include:

* The default severity for several verific warnings has been downgraded to INFO, as they are commonly seen in projects and usually do not indicate a problem with the design:

    [VERI-1209] foo.sv:98: expression size 7 truncated to fit in target size 6 \
    [VERI-1142] foo.sv:55: system task 'display' is ignored for synthesis \
    [VERI-2418] foo.svh:503: parameter 'foo' declared inside package 'bar_pkg' shall be treated as localparam \

    If you would like to continue receiving any of these warnings, you can run the command `verific -set-warning VERI-XXXX` at the beginning of your script to change the severity level back to WARNING.

In other YosysHQ news:

* We have a new home for community discussion around Yosys - [https://yosyshq.discourse.group/](https://yosyshq.discourse.group/) Join us there for questions, support and discussion about our open source EDA tools.
* Our partner Linty has recently released [a new version](https://doc.linty-services.com/doc/release_notes.html#id3) of their linting platform that adds several new yosys-based rules and reports, mainly around clock and reset usage. Also check out their [free VSCode plugin](https://marketplace.visualstudio.com/items?itemName=LintyServices.linty-hdl-designer)!

Happy June,

The YosysHQ Team
