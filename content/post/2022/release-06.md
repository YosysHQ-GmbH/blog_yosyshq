---
title: "Tabby CAD Suite version 20220610 released!"
date: 2022-06-10
description : "Memory inferencing overhaul."
image: /static-2022/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The June release of Tabby CAD Suite is now available for download.

## Yosys

* A big overhaul of memory inference in Yosys. The new pass `memory_libmap` supports a wider variety of memory patterns, such as single-port memories or asymmetric memories. It will also strictly respect verilog semantics in cases of address collision, adding emulation circuitry to ensure the synthesized behavior matches simulation.

To omit the emulation circuitry even in cases where it is required for correctness, you can add the `(* no_rw_check *)` attribute to the array declaration of the memory. To disable collision handling globally, calling memory with the `-no-rw-check` option is also possible (and the corresponding option has been added to all `synth` passes using the new `memory_libmap` pass).

