---
title: "Tabby CAD Suite version 20241211 released!"
date: 2024-12-11
description : ""
image: /static-2023/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The December release of Tabby CAD Suite is now available for download. Notable changes in this version include:

* Fixed some recurring issues with `verific -lib` mode. You should no longer see errors when the module definitions to be loaded as blackboxes have contents that instantiate other, unknown modules. Also, parameter values on blackbox modules and their instantiations should now be imported correctly into Yosys again.
* Additional [functions for design inspection](https://github.com/YosysHQ/yosys/pull/4678) have been added to the TCL integration.
* The `setenv` command has been added to allow setting environment variables from within yosys scripts. This is useful e.g. to set variables used in file lists before loading them with `verific -f xxx.f`.

In other YosysHQ news:

* The [Moosic plugin](https://blog.yosyshq.com/p/logic-locking-with-moosic/) we wrote about at the start of the year is now [silicon proven](https://www.linkedin.com/posts/yosyshq_at-the-beginning-of-the-year-gabriel-gouvine-activity-7269730388191715329-Rp0H?utm_source=share&utm_medium=member_desktop)!
* We recently released initial [support for the NanoXplore NG-Ultra in nextpnr](https://github.com/YosysHQ-GmbH/prjbeyond-db). This was an activity funded under the [European Space Agency's Open Space Innovation Platform](https://activities.esa.int/4000141380).
* At our most recent YUG, [Katharina Ceesay-Seitz](https://www.linkedin.com/in/katharina-ceesay-seitz-ba521087/) presented her work on using formal verification for detecting microarchitectural information leakage - watch the recording [here](https://www.youtube.com/watch?v=Kxp-5kNMt40).

Happy December, and if you need a last minute gift idea - why not consider the gift of formal verification!
