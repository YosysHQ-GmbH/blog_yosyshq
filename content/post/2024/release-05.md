---
title: "Tabby CAD Suite version 20240508 released!"
date: 2024-05-08
description : ""
image: /static-2023/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The May release of Tabby CAD Suite is now available for download. Notable changes in this version include:

* The smtbmc engine can now output information on used assumptions in each step, to help debug failing cover properties. To enable this feature, add the `--track-assumes `option in the `[engines]` section like this: \
`smtbmc yices -- --track-assumes`

In other YosysHQ news:

* Our next Yosys Users Group meeting will be FPGA lightning talks! Join us on Monday, May 27th at 18:00 CEST [at this link](https://meet.jit.si/yosys-users-group). It is also still possible to [submit a talk](https://docs.google.com/forms/d/1gKbUfBqs5eMpPQztjnyAxx75a8SGbjkXN-BR2Nn1XF0/edit).
* Our latest [community spotlight is about Manta](https://blog.yosyshq.com/p/community-spotlight-manta/), a vendor-agnostic logic analyzer and virtual interface for FPGAs.

Happy May,

The YosysHQ Team
