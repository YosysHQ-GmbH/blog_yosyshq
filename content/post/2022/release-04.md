---
title: "Tabby CAD Suite version 20220406 released!"
date: 2022-04-06
description : "Co-simulation, new options for SBY, YosysHQ team is growing."
image: /static-2022/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The April release of Tabby CAD Suite is now available for download.

## Yosys

* The `sim` command now allows co-simulation with stimulus values from aiger and btor2 witness files as well as traces in VCD or FST format. 
* Co-simulation of designs with multiple clock domains was improved.

## SBY

* The `--keep-going` option was added to the smtbmc engine. With this option, the solver will continue to check the remaining properties even after an assertion fails. To use it, add the option between the engine and the solver in the `.sby` file:

        [engines]
        smtbmc --keep-going boolector

* The JUnit report produced by sby will now list the status individually for each property when the engine supports it (currently only with smtbmc).

## In other YosysHQ news

* We just welcomed 3 new people to the team; Jannis, Lofty and Krystine. They’ll be helping us to improve the formal and FPGA tooling, and improve our documentation.
* If you don’t already follow us on twitter - we post as [YosysHQ](https://twitter.com/YosysHQ). Whitequark just had a [great ‘ask me anything’ on digital logic](https://twitter.com/whitequark/status/1510525555191558150). 
* As a small company, we really appreciate being recommended to people - please let us know if you have any leads!

