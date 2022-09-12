---
title: "Tabby CAD Suite version 20220512 released!"
date: 2022-05-12
description : "Formal tristate support, x handling, optimising adders."
image: /static-2022/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The May release of Tabby CAD Suite is now available for download.

## SBY

* The `tribuf` pass now supports a `-formal` option that converts inferred tri-state buffers within a module into equivalent non-tri-state logic for formal verification. It automatically adds assertions that detect multiple drivers driving the same net simultaneously. (When using tri-state I/O across modules, `tribuf -formal` should be preceded by a `flatten` pass).
* Several changes in the handling of `x` values during formal verification.  In particular, when using the Verific frontend, during the initial time step, value change expressions (`$rose`, `$fell`, `$changed`, `$stable`) are now always computed as if the argument changed from `x` to its initial value. This follows the SystemVerilog standard and ensures that any high (or low) signal starts at a step where `$rose` (or `$fell`) is true.

## In other YosysHQ news

* Teodor-Dumitru Ene [recently spoke about Open-Source Hardware Addition on SKY130](https://blog.yosyshq.com/p/optimising-adders/). He has made a Yosys plugin that allows the designer to choose what algorithm to use.
* We are very happy to announce that [Mullvad](https://mullvad.net/en/) are sponsoring the development of the open source tools. Thanks Mullvad, and if you need a VPN, be sure to check them out!


