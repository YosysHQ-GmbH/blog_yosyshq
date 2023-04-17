---
title: "Yosys One Liners - AXI"
description: ""
tags: ["one liners"]
date: 2023-04-17T13:25:38+02:00
image: /static-2023/oneliners.jpeg
draft: false
---

The AXI spec says "On Manager and Subordinate interfaces, there must be no combinatorial paths between input and output signals." If we have a design containing an AXI Manager or Subordinate as netlist (i.e. post `proc`) and the AXI ports contain `axi_` we can check this automatically using this Yosys one liner:

    flatten; select -assert-none i:*axi_* %coe* o:*axi_* %cie* %i

If that fails we can use `show i:*axi_* %coe* o:*axi_* %cie* %i` to then see the combinational path (or using dump/printattrs/select -list instead of show when the design is too large for show).

Here `i:*axi_* %coe` selects the combinational output cone of all input ports containing `axi_` and `o:*axi_* %cie*` selects the combinational input cone of all output ports containing `axi_` and `%i` takes the intersection of those two selections, leaving you with only the combinational paths that start and end in such an input/output.

We also flatten the design, as selecting input/output cones doesn’t work across submodules.

If you want to find out more about the Yosys select command, [please read the documentation here](https://yosyshq.readthedocs.io/projects/yosys/en/latest/cmd/select.html).
