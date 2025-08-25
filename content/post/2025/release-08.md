---
title: "Tabby CAD Suite version 20250807 released!"
date: 2025-08-07
description : ""
image: /static-2023/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The August release of Tabby CAD Suite is now available for download. Notable changes in this version include:

* SBY: it is now possible to symlink the files listed in the `[files]` section instead of copying them to the SBY task directory by invoking it with the `sby --link` option. This saves disk space when running many separate tasks on a large design.
* SBY: added the ability to cancel another task when a task finishes. This can be used e.g. to cancel a bounded model check when an unbounded proof succeeds. See documentation of the new `[cancelledby]` section [here](https://yosyshq.readthedocs.io/projects/sby/en/latest/reference.html#cancelledby-section).
* Yosys: Fixed a bug where verific flags would get reset incorrectly after import, setting different default settings for subsequent frontend invocations in the same run.

In other YosysHQ news:

* In our latest guest blog post, Matt Young introduces an Automated Triple Modular Redundancy EDA Flow for Yosys! [https://blog.yosyshq.com/p/tamara-towards-a-triple-modular-redundancy-pass-for-yosys/](https://blog.yosyshq.com/p/tamara-towards-a-triple-modular-redundancy-pass-for-yosys/) 

Happy August,

The YosysHQ Team
