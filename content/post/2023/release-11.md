---
title: "Tabby CAD Suite version 20231107 released!"
date: 2023-11-07
description : ""
image: /static-2023/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The November release of Tabby CAD Suite is now available for download. Notable changes in this version include:

* Fixed problems with verific elaboration in VHDL that were introduced in the last release - you should no longer see spurious multiple driver warnings.
* Memory inference can now recognize (* rom_style = "..." *) attributes on data output and address signals (attributes on the data storage register still take precedence, but this allows forcing a style e.g. when inferring ROM from a case statement).

In other YosysHQ news:

* We just published a new guest blog post by Theophile Loubiere. He wrote a fun introduction to formal by using SBY to [solve a sudoku](/p/solving-sudoku-with-sby/).

Happy November,
The YosysHQ Team
