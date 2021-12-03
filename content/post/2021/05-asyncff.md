---
title: "Why Asynchronous Load Flip-Flops Should Be Avoided"
description: "By Claire Xenia Wolf"
date: 2021-11-30
slug: async-load-ff
image: "/static-2021/asyncff.png"
draft: false
---

Code: https://github.com/YosysHQ-Docs/Blog-Async-Load-FFs

## Part 1: The Bad News

We have recently added support for asynchronous load flip-flops to Yosys for a customer project. However, we consider this a problematic feature in a (System-)Verilog synthesis tool, and thus I’d like to take this opportunity to explain why one should avoid using asynchronous load flip-flops in new (System-)Verilog designs.

### What are asynchronous load flip-flops

An asynchronous load flip-flop is a type of flip-flop with asynchronous reset for which the reset value is not a compile-time / synthesis-time constant.

```SystemVerilog
reg async_load_ff_q;
wire async_load_ff_reset_val = <dynamic_expression>;

always_ff @(posedge clock, posedge load)
    if (load) async_load_ff_q <= async_load_ff_reset_val;
    else      async_load_ff_q <= ...;
```

This distinguishes them from the more common asynchronous set (reset) flip-flops, for which the reset value is a compile-time (synthesis-time) constant.

```SystemVerilog
reg async_reset_ff_q;
localparam async_reset_ff_reset_val = <constant_expression>;

always_ff @(posedge clock, posedge reset)
    if (reset) async_reset_ff_q <= async_reset_ff_reset_val;
    else       async_reset_ff_q <= ...;
```

IEEE Std 1364.1-2002, the IEEE Standard for Verilog Register Transfer Level Synthesis, does allow such asynchronous load flip-flops in synthesis, but states that the synthesis results will only match the behavior of the original Verilog code under certain conditions.

### The problem with Verilog and asynchronous load flip-flops

The key insight is that the way an asynchronous reset is modelled using Verilog always blocks is not sensitive to the data signals providing the asynchronous load value. Thus, if the data signals are changing while the asynchronous reset is active, the new data is not loaded into the flip-flop when neither clock nor the asynchronous reset is toggling.

Consider the following SystemVerilog design ([dut.sv](https://github.com/YosysHQ-Docs/Blog-Async-Load-FFs/blob/main/dut.sv)):

```SystemVerilog
module dut (
    input clk1, clk2, arst,
    output reg [7:0] cnt1, cnt2
);
    always_ff @(posedge clk1 or posedge arst)
        if (arst)
            cnt1 <= 0;  // constant expression (async reset)
        else
            cnt1 <= cnt1 + 7;
    
    always_ff @(posedge clk2 or posedge arst)
        if (arst)
            cnt2 <= cnt1;  // dynamic expression (async load)
        else
            cnt2 <= cnt2 + 11;
endmodule
```

And the following test bench ([tb.sv](https://github.com/YosysHQ-Docs/Blog-Async-Load-FFs/blob/main/tb.sv)):

```SystemVerilog
module tb;
    reg clk1 = 0, clk2 = 0, arst = 0;
    wire [7:0] cnt1, cnt2;

    dut dut (clk1, clk2, arst, cnt1, cnt2);

    task do_clk1;
        clk1 = 1; #5; clk1 = 0; #5;
    endtask

    task do_clk2;
        clk2 = 1; #5; clk2 = 0; #5;
    endtask

    task do_arst;
        arst = 1; #5; arst = 0; #5;
`ifdef DOUBLE_ARST
        arst = 1; #5; arst = 0; #5;
`endif
    endtask

    initial begin
        #10;
        do_arst;              $display(cnt1, cnt2);
        repeat (5) do_clk1;   $display(cnt1, cnt2);
        do_arst;              $display(cnt1, cnt2, " <--");
        repeat (5) do_clk2;   $display(cnt1, cnt2);
        do_arst;              $display(cnt1, cnt2);
    end
endmodule
```

Running it without and with `-DDOUBLE_ARST` produces the following output:

```
$ make run0
iverilog -g2012 -o sim0 -s tb tb.sv dut.sv
./sim0
  0  x
 35  x
  0 35 <--
  0 90
  0  0

$ make run1
iverilog -g2012 -o sim1 -s tb -DDOUBLE_ARST tb.sv dut.sv
./sim1
  0  0
 35  0
  0  0 <--
  0 55
  0  0
```

In the first case with a single pulse on arst, the second counter is reset to the non-zero value of the first counter from before the reset pulse.

But a real-world asynchronous load flip-flop would of course behave like a transparent latch while the reset pulse is high, propagating the new (zero) value of the first counter to the second counter register. But this only happens in simulation when we pulse the reset signal a second time.

![Double-Async-Reset Waveform](/static-2021/asyncff.png)

This can lead to non-trivial simulation-synthesis mismatches that are hard to debug, and may result in a chip that does not function as expected.

Thus, asynchronous load flip-flops should be avoided in (System)Verilog designs, or at least it should be formally verified that the asynchronous load value of such a flip-flop can never change while the reset signal is active.

This is in line with IEEE Std 1364.1-2002 requirements for sequential logic verification:

> When asynchronous data is assigned, the asynchronous data shall not change during the period in which the asynchronous control (the condition under which the data is assigned) is active.
>
> _IEEE Std 1364.1-2002, Section 4.2_

It is worth noting that a similar problem exists with flip-flops that have both asynchronous set and reset: If both are asserted and then one is released after the other, the one that’s released later should take precedence over the one that’s released earlier. However, since the always block is not triggered by the falling edge of the set or reset signal, releasing just one of the two will have no effect on the flip-flop output. IEEE Std 1364.1-2002 also acknowledges this issue:

> The problem occurs when both reset and preset are asserted at the same time and reset is removed first. When reset is removed (posedge rst_n), the always block is not activated. This means that the output will continue to drive the reset output to ‘0’ until the next rising clock edge. A real flip-flop of this type would immediately drive the output to ‘1’ because the set_n signal is an asynchronous preset. This potentially could cause a mismatch between pre-synthesis and post-synthesis simulations using this model.
>
> _IEEE Std 1364.1-2002, Appendix B.6_

## Part 2: The Good News

In this section we discuss different design methods that avoid the use of behavioral Verilog code to model asynchronous load FFs.

### Instantiate (Vendor) Primitives

The best and easiest way of dealing with this issue is to instantiate FF primitives directly. This can either be vendor cells, or a user-defined module for which we chose different implementations for simulation and synthesis, one with correct simulation behavior, and one that is synthesizable, respectively.

The new DUT would look something like this ([dut_myff.sv](https://github.com/YosysHQ-Docs/Blog-Async-Load-FFs/blob/main/dut_myff.sv)):

```SystemVerilog
module dut (
    input clk1, clk2, arst,
    output reg [7:0] cnt1, cnt2
);
    myff ff1[7:0] (cnt1, cnt1 + 8'd  7, clk1, arst, 8'h 00),
         ff2[7:0] (cnt2, cnt2 + 8'd 11, clk2, arst,   cnt1);
endmodule
```

When instantiating a Vendor primitive one should always double-check that the vendor simulation library does model asynchronous loads correctly, for example using the techniques described in the next two sections.

### Simulation model using Verilog UDP

Verilog UDP primitives can be used to correctly model the behavior of asynchronous load flip-flops. But UDPs are not synthesizable, so we need to also provide a synthesizable implementation of an asynchronous load flip-flop ([myff_udp.sv](https://github.com/YosysHQ-Docs/Blog-Async-Load-FFs/blob/main/myff_udp.sv)):

```SystemVerilog
`ifdef SYNTHESIS
    module myff (
        output reg q,
        input d, clk, arst, rval
    );
        always @(posedge clk or posedge arst)
            if (arst) q <= rval;
            else      q <= d;
    endmodule
`else
    primitive myff (q, d, clk, arst, rval);
        input d, clk, arst, rval;
        reg q;
        output q;
        table
        // D C R V : Q : Q'
           ? ? 1 0 : ? : 0 ; // async reset
           ? ? 1 1 : ? : 1 ; // async set
           0 p 0 ? : ? : 0 ; // posedge clock, d=0
           1 p 0 ? : ? : 1 ; // posedge clock, d=1
           ? n 0 ? : ? : - ; // negedge clock
           * ? ? ? : ? : - ; // any data edge
           ? ? * ? : ? : - ; // any arst edge
           ? ? ? * : ? : - ; // any rval edge
        endtable
    endprimitive
`endif
```

Running our test-bench now yields the expected result, even when we pulse the asynchronous load signal only once:

```
$ make run2
iverilog -g2012 -o sim2 -s tb tb.sv dut_myff.sv myff_udp.sv
./sim2
  0  0
 35  0
  0  0 <--
  0 55
  0  0
```

### Simulation model using procedural assign and deassign

Another approach is to “fix up” the asynchronous load using procedural assign and deassign ([myff_ada.sv](https://github.com/YosysHQ-Docs/Blog-Async-Load-FFs/blob/main/myff_ada.sv)):

```SystemVerilog
module myff (
    output reg q,
    input d, clk, arst, rval
);
    always_ff @(posedge clk or posedge arst)
        if (arst) q <= rval;
        else      q <= d;
`ifndef SYNTHESIS
    always @(arst)
        if (arst) assign q = rval;
        else    deassign q;
`endif
endmodule
```

Running our test-bench on this version also yields the expected result:

```
iverilog -g2012 -o sim3 -s tb tb.sv dut_myff.sv myff_ada.sv
./sim3
  0  0
 35  0
  0  0 <--
  0 55
  0  0
```

Of course it’s also possible to use procedural assign and deassign directly in the design to “fix up” the behavior of asynchronous load flip-flops ([dut_ada.sv](https://github.com/YosysHQ-Docs/Blog-Async-Load-FFs/blob/main/dut_ada.sv)):

```SystemVerilog
module dut (
    input clk1, clk2, arst,
    output reg [7:0] cnt1, cnt2
);
    always_ff @(posedge clk1 or posedge arst)
        if (arst)
            cnt1 <= 0;
        else
            cnt1 <= cnt1 + 7;
    
    always_ff @(posedge clk2 or posedge arst)
        if (arst)
            cnt2 <= cnt1;
        else
            cnt2 <= cnt2 + 11;
    
`ifndef SYNTHESIS
    always @(arst)
        if (arst) assign cnt2 = cnt1;
        else    deassign cnt2;
`endif
endmodule
```

However, sprinkling procedural assign and deassign statements and ifndef-SYNTHESIS-blocks all over the design is much more error prone than implementing this work-around only once in a custom cell type that can then be instantiated wherever needed.

### The latch+flip-flop trick

The following technique is used on some FPGA architectures to emulate asynchronous-load flip-flops using latches and asynchronous-reset flip-flops only. It can be used to completely avoid asynchronous-load FFs while preserving the semantic of such elements ([myff_hack.sv](https://github.com/YosysHQ-Docs/Blog-Async-Load-FFs/blob/main/myff_hack.sv)):

```SystemVerilog
module myff (
    output q,
    input d, clk, arst, rval
);
    // a latch to store the async-load value
    reg latched_rval;
    always @*
        if (arst) latched_rval = rval;

    // a regular FF to store the clocked data value
    reg q_without_reset;
    always @(posedge clk)
        q_without_reset <= d;

    // an asynchronous-reset flip-flop to remember last event
    reg last_event_was_clock;
    always @(posedge clk or posedge arst)
        if (arst) last_event_was_clock <= 0;
        else      last_event_was_clock <= 1;
    
    // output either the latched reset value or clocked data value
    assign q = last_event_was_clock ? q_without_reset : latched_rval;
endmodule
```

Running our test-bench a last time gives the expected result for this solution as well:

```
iverilog -g2012 -o sim5 -s tb tb.sv dut_myff.sv myff_hack.sv
./sim5
  0  0
 35  0
  0  0 <--
  0 55
  0  0
```

This is a useful last resort solution for designs that absolutely require asynchronous-load flip-flop semantics, and where the risks associated with using different synthesis and simulation models for such a component are not acceptable.
