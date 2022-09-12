---
title: "Tabby CAD Suite version 20220906 released!"
date: 2022-09-06
description : "Parallel formal proofs, ability to disable VCD dumps, new getting started guide."
image: /static-2022/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The September release of Tabby CAD Suite is now available for download.

## SBY

* SBY now runs multiple tasks in parallel. Additionally it now limits the number of concurrently running subprocesses to the available number of cores. The --sequential command line option allows you to opt out of running tasks in parallel and the -j N option sets the limit of concurrent subprocesses to N instead of the default. All this is optionally integrated with the make jobserver protocol to enforce the concurrent process limit across other processes launched by make. 
* There is a new SBY option vcd to enable or disable the generation of VCD traces. It defaults to on, but can be set to off when no traces are required to save runtime and disk space. VCD trace generation performance for the smtbmc engine is also improved in this release, so we recommend re-evaluating the performance before turning VCD trace generation off.  

## In other YosysHQ news

* We have recently overhauled the [SBY getting started guide](https://symbiyosys.readthedocs.io/en/latest/quickstart.html). Have a look if you need to onboard someone for SVA property checking!
