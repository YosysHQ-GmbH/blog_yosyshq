---
title: "Tabby CAD Suite version 20240312 released!"
date: 2024-03-16
description : ""
image: /static-2023/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The March release of Tabby CAD Suite is now available for download. Notable changes in this version include:

* You can now query the proof status of properties in a design using `sby --status example.sby`. This works as soon as any SBY task was launched, so you can use it to query progress while SBY is still running in another terminal.
* The abc pdr solver now supports continuing to prove other properties after a counterexample is found using `abc --keep-going pdr` in engines.

In other YosysHQ news:

* Gabriel Gouvine contributed this [guest blog post on logic locking](/p/logic-locking-with-moosic/) with his Moosic plugin.

Happy March,
The YosysHQ Team
