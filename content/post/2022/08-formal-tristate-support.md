---
title: "Formal Tristate Support"
date: 2022-06-17T17:28:17+02:00
description : "Sby now supports trisates in formal proofs"
tags: ["blog"]
image: /static-2022/tristate.png
slug: Formal Trisate Support
draft: false
---

Sby, our formal verification tool has recently got better support for tristate circuits. A tristate output is one that can either drive the connected wire to a high or low logic level or be in a high impedance state where it does not drive the output. This allows directly connecting multiple tristate outputs as long as no two are driving the output simultaneously. With tribuf (tristate buffer) support turned on, sby will automatically create assertions for any tristate signals that can be driven via multiples outputs. If more than one tristate output can drive the same wire, such an  assertion will fail. For example:

    module module1 (input wire active, output wire tri_out);
        assign tri_out = active ? 1'b0 : 1'bz;
    endmodule

    module module2 (input wire active, output wire tri_out);
        assign tri_out = active ? 1'b0 : 1'bz;
    endmodule

    module top_fail (input wire clk, input wire active1, input wire active2, output wire out);
        module1 module1 (.active(active1), .tri_out(out));
        module2 module2 (.active(active2), .tri_out(out));
    endmodule

And an .sby file with a script section that includes:

    prep -top top_fail
    flatten; tribuf -formal

Will fail with a message like:

    Assert failed in top: tristates.v:3 ($tribuf_conflict$$flatten/module1.$verific$i6$tristates.v:3$9)

By ensuring that only one tristate module is active at once, for example

    module top_pass (input wire clk, input wire active1, output wire out);
        module1 module1 (.active(active1), .tri_out(out));
        module2 module2 (.active(!active1), .tri_out(out));
    endmodule

Sby will now finish with no errors. There is no need to add any assertion to the design, with the tribuf -formal command enabled in the [script] section of the sby file, the assertions are added automatically. Note that the flatten command is required when any module outputs can be tristate and that it has to precede the tribuf -formal command.

You can try the example out here: https://github.com/YosysHQ/sby/tree/master/docs/examples/tristate 
The sby file makes use of 2 different task sections.

I recently used this feature to prove the safety of the tristate bus for an ASIC design. The ASIC combines 13 smaller projects with 45 verilog files. Sby completes a full proof with a depth of 5 clock cycles in 10 seconds. You can take a look at the [project's repository](https://github.com/mattvenn/zero_to_asic_MPW6) and the [.sby file](https://github.com/mattvenn/zero_to_asic_mpw6/blob/mpw6/tribuf.sby).

This shows that verifying meaningful properties of a larger design doesn't have to take hours or even days. The time required to prove a property is not set by the overall design complexity. State of the art solvers are very good at cutting through a ton of logic to identify just the relevant parts. In solver terminology this is called an unsatisfiable core and on the hardware side this corresponds to a subcircuit that alone ensures that a property holds. That means you could change everything that is not part of this core circuit and the property would still hold. The complexity of this subcircuit is a much better indicator of the required solver effort.

If you are familiar with the cone of influence concept, where you find the relevant logic by following the circuit's structure, this might sound familiar. An important difference is that solvers do not only consider the structure but also the behavior implemented by a circuit, which is more precise. Thus for the same property, an unsatisfiable core circuit can be much smaller than the cone of influence.

For selecting between different projects within a single ASIC design, most of the projects' logic is not part of the unsatisfiable core. Only the logic responsible for selecting which tristate outputs are active together with the automatically added conflict checks needs to be considered. This is great because for medium to large projects with many source files, the solver can still provide an answer very quickly.

If you have experience with proving simple properties in large designs please let us know - we’re always interested in how people are using our tools.

