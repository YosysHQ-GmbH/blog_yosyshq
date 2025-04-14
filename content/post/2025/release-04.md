---
title: "Tabby CAD Suite version 20250409 released!"
date: 2025-04-09
description : ""
image: /static-2023/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The April release of Tabby CAD Suite is now available for download. Notable changes in this version include:

* Various improvements for speedier handling of liberty files: all passes that take liberty input files can now directly read compressed files; liberty parsing speed was improved; added the <code>[libcache](https://yosyshq.readthedocs.io/projects/yosys/en/latest/cmd/libcache.html)</code> command to enable caching parsed liberty files for repeat use in the same process.
* Fixed a bug that suppressed errors about use of unknown modules/entities when reading in files with `verific` after using `-lib` to load blackbox definitions.

In other YosysHQ news:

* A [new guest post by Rohith](/p/risc-v-formal-verification-framework-extension-for-synopsys-vc-formal/) presents his work to adapt our RISC-V Formal Verification IP for Synopsys VC Formal.
* Nina and Matt attended SEFUW and DATE respectively. It was good to see some of our customers and colleagues there.

Happy April,
The YosysHQ Team
