---
title: "Tabby CAD Suite version 20241105 released!"
date: 2024-11-05
description : ""
image: /static-2023/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The November release of Tabby CAD Suite is now available for download. Notable changes in this version include:

* String attributes are represented more efficiently in the in-memory RTLIL netlist, using a different implementation than bit vector attributes. We have observed reductions in peak memory usage of up to 30% for real world designs.
* For plugin maintainers, this means some breaking changes if you were directly accessing the `bits` member of an `RTLIL::Const`. The `bits` member has been removed. To access any attribute as a bit vector, use the `bits()` method instead, which returns a const iterator. To modify a `Const`, you can call `std::vector&lt;RTLIL::State>& get_bits()` which forces the implementation to a bit vector. To get the number of bits, use the new `Const::size()` method instead of `bits.size()`.

In other YosysHQ news:

* After a long summer break, [Yosys Users Group](/yug) meetings have resumed again. Our last meeting on October 29th had Katharina CeesaySeitz from ETH Zürich present her work on using special netlist transformations in a custom Yosys pass in combination with formal verification to detect microarchitectural information leakage via hardware timing side channels. If you'd like to be notified of our next YUG meeting, subscribe to our [newsletter](https://www.yosyshq.com/newsletter)! Watch her talk on our [Youtube channel](https://www.youtube.com/watch?v=Kxp-5kNMt40).

Happy November,

The YosysHQ Team
