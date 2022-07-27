---
title: "Autotune"
date: 2022-07-27T14:41:35+02:00
description : "Autotune helps to find the fastest solver for your properties"
tags: ["blog"]
image: /static-2022/autotune.png
slug: Sby Autotune
draft: false
---

Sby, our frontend for formal verification, makes it easy to use Yosys with the various open source verification tools that are included in our CAD suites. Sby integrates these tools as engines and provides a unified interface. Additionally, many of the verification tools internally use lower-level tools like SAT and SMT solvers and allow the user to select between different supported solvers.

Most verification tasks can be performed by several of the supported engines and solvers. Depending on the specific verification task at hand, there can be large performance differences between them. Thus, it makes sense to try several engines and solvers to pick the best performing one.

With Sby, switching the engine or solver only requires changing a single line in the “[engines]” section of the .sby file. Still, the large number of engine and solver configurations made it impractical to manually try all of them for every verification task, so it was easy to leave performance on the table by sticking with a worse performing configuration.

To help you get the best performance out of Sby, we now introduced the --autotune option. If you add this option to your usual Sby invocation, it will go ahead and automatically try all recommended engine and solver combinations, producing a report that lists the best performing configurations. You can then copy a configuration from this report into your .sby file to use a faster engine for future sby invocations. From time to time, when updating the CAD suite, or making significant changes to your design, you can run autotune again to see if you are still using the best performing engine.

Sby  --autotune is also a lot smarter than just trying every configuration in sequence. It runs in parallel and knows how to use timeouts and retries so that a single slow engine that would take hours doesn’t keep Sby from quickly discovering a better configuration that finishes in seconds. When selecting the recommended engines and solvers, it also takes into account the design and settings in your .sby file to avoid known incompatibilities or performance issues.

More details on how to use and configure the automatic engine selection can be found in the [corresponding section of the Sby documentation](https://symbiyosys.readthedocs.io/en/latest/autotune.html). If you want to try out the new autotune feature yourself, but don’t have a suitable Sby project at hand, you can try it on the [small example project we prepared](https://github.com/YosysHQ/sby/tree/master/docs/examples/autotune).

As always, we're [interested to hear how you get on with our tools](https://www.yosyshq.com/contact)
