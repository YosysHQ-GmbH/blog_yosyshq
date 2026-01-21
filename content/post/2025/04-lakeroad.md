---
title: "Lakeroad"
tags: ["blog"]
layout: default
---

# Better Technology Mapping with Lakeroad

*The Lakeroad paper is published [here.](https://arxiv.org/abs/2401.16526)
 The Lakeroad repo is available [here.](https://github.com/gussmith23/lakeroad)*

*Technology mapping*
  is the process of mapping a high-level design
  to the library of hardware primitives actually available
  on the underlying hardware platform.
For example, when targeting an FPGA,
  the technology mapping stage determines
  how to implement each portion of the design using
  LUTs, MUXes, DSPs, memories, and the other available primitives.

Modern FPGAs
  are increasingly heterogeneous,
  exposing more and more specialized primitives
  like DSPs (digital signal processors).
These primitives are highly configurable,
  with many possible valid (and invalid)
  configurations.

State of the art technology mappers
  are often implemented using
  pattern matching algorithms,
  which search for patterns in the hardware design
  which can be implemented using 
  specific configurations of primtives.
For example,
  [this file](https://github.com/YosysHQ/yosys/blob/7ebd9721656ba88f3cc25ef10882ed3e82e3c182/techlibs/xilinx/xilinx_dsp.pmg)
  implements some of Yosys's technology mapping logic
  for Xilinx DSPs.
The logic is written in pmgen: 
  Yosys's pattern matcher generator language.
While we do not have access
  to the source code of proprietary tools
  like Vivado and Quartus,
  engineers
  at these companies
  have implied to us that similar strategies are used
  within these tools.
One engineer mentioned 
  that their pattern matchers are implemented in
  "millions of lines of C code,"
  comprised mostly of complex, nested
  `if` statements.

As hardware primitives get more complex,
  pattern matching simply will not scale.
The DSP48E2---the DSP on the Xilinx UltraScale+ architecture---has nearly 100 ports and parameters.
Each separate configuration of ports and parameters
  corresponds to a different functioning of the  
  enable support for a large
variety of computations. The manual for the DSP48E2 alone
is 75 pages long, where considerable text details the complex
restrictions between the settings of the nearly 100 ports and
parameters.
  





TODO end note:

Note that,
  while we have so far mostly applied Lakeroad 
  to FPGA DSPs,
  the technology underlying Lakeroad
  is not FPGA or DSP specific.
If you have interesting primitives
  on your FPGA or in your ASIC
  which pose a challenge to
  current technology mappers,
  we woul love to see if Lakeroad can help you.
Feel free to reach out
  by posting on the [discussions page](https://github.com/gussmith23/lakeroad/discussions),
  or by opening an [issue](https://github.com/gussmith23/lakeroad/issues/new) 
  if you have a concrete problem.


TODO merge this in as a running example:

# Lakeroad and Churchroad Latch-Up 2025 Demo

**Lakeroad issues: <https://github.com/gussmith23/lakeroad/issues/new>**  
**Churchroad issues: <https://github.com/gussmith23/churchroad/issues/new>**

**Lakeroad** and **Churchroad** are open-source FPGA technology mappers which are competitive with proprietary technology mappers within tools like Vivado, especially when mapping to programmable primitives like DSPs. They are easily extensible to new FPGA architectures.

**Lakeroad** can map small designs to one or two DSPs. It is intended for use on small submodules within a larger design.

Lakeroad was first described in [this paper](https://arxiv.org/abs/2401.16526), and was [presented at ASPLOS 2024.](https://www.youtube.com/watch?v=2XgOWAtJ8vs)

**Churchroad** is a more general technology mapper and can handle larger designs than Lakeroad. Churchroad uses multiple calls to Lakeroad under the hood, and in the future, will also incorporate other technology mapping methods.

Churchroad was first described in [this workshop paper](https://arxiv.org/abs/2411.11036), and was [presented at WOSET 2024](https://www.youtube.com/watch?v=m8AwSktZeFE).

Lakeroad is currently more stable than Churchroad. Eventually, Churchroad will completely subsume Lakeroad.

This demo first describes the issue with existing technology mappers, and then demonstrates how Lakeroad fills those holes.

Before following the demo, be sure to clone it:
```sh
git clone https://github.com/gussmith23/2025-latchup-demo
cd 2025-latchup-demo
```

## What's the Problem?

Imagine you're building a hardware design targeting Xilinx UltraScale+ FPGAs. Your design includes the following hardware module:

[`./sub_mul.sv`](./sub_mul.sv):
```sv
module sub_mul(
  input clk,
  input  [15:0] a, b, d,
  output [15:0] out
);

  logic [31:0] stage0, stage1, stage2;

  always @(posedge clk) begin
    stage0 <= (d - a) * b;
    stage1 <= stage0;
    stage2 <= stage1;
  end

  assign out = stage2;

endmodule
```

You'd like to map this module to the UltraScale+ DSP:

![DSP48E2](assets/DSP48E2.png)

Rather than configuring the DSP yourself, you'd like to use Vivado to configure it automatically (a process often called "inference"). Thus, you run Vivado:

(see [`./using_vivado/synth_script.tcl`](./using_vivado/synth_script.tcl))
```sh
vivado -mode batch -source using_vivado/synth_script.tcl
```

However, when you go to map this design using Vivado, you find that it uses more than just a single DSP. See this table from the utilization report:

```
+----------+------+---------------------+
| Ref Name | Used | Functional Category |
+----------+------+---------------------+
| DSP48E2  |    2 |          Arithmetic |
+----------+------+---------------------+
```

An example of the full synthesized output can be seen at [`./vivado/vivado.out`](./vivado/vivado_out.sv).

Now what? Well, we could attempt synthesis with another tool, for example, the open-source compiler Yosys.

You can install Yosys on Ubuntu with:

```sh
sudo apt-get install yosys-dev
```
or on Mac:

```sh
brew install yosys
```

If you need to build it from source, you can do so fairly quickly:

```sh
git clone --recurse-submodules https://github.com/YosysHQ/yosys.git
cd yosys
# You can change this to wherever you'd like Yosys to be installed. Just note
# that the location should be on your PATH.
INSTALL_DIR=$HOME/.local
mkdir -p $INSTALL_DIR
# Remove or change the -j argument to not build in parallel.
PREFIX=$INSTALL_DIR make -j`nproc` install
export PATH="$INSTALL_DIR/bin:$PATH"
cd ..
which yosys
which yosys-config
```

We can now attempt synthesis with Yosys:

```sh
yosys -p "
  read_verilog -sv sub_mul.sv
  hierarchy -top sub_mul
  synth_xilinx -top sub_mul -family xcup
  xilinx_dsp
  write_verilog using_yosys/yosys_out.sv
  stat
"
```

While Yosys is able to use just one DSP, it also uses extra logic resources like CARRY4 and LUT2:

```
=== sub_mul ===

   Number of wires:                 33
   Number of wire bits:            334
   Number of public wires:           7
   Number of public wire bits:     129
   Number of ports:                  5
   Number of port bits:             65
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                104
     BUFG                            1
     CARRY4                          5
     DSP48E2                         1
     IBUF                           49
     LUT2                           16
     OBUF                           16
     SRL16E                         16
```

Without Lakeroad and Churchroad, the only option at this point would be to attempt to configure the DSP ourselves. Looking at [`./using_vivado/vivado_out.sv`](./using_vivado/vivado_out.sv) and [`./using_yosys/yosys_out.sv`](./using_yosys/yosys_out.sv), however, it should be clear that this would be very unpleasant!


And for an added bonus, these tools have other issues as well, beyond the mapping gaps shown above.
* **Lack of correctness guarantees:** tools like Vivado and Yosys do not provide any formal correctness guarantees.
* **Lack of extensibility:** while Yosys is extensible, tools like Vivado are closed-source and thus non-extensible.

## Lakeroad to the Rescue

Lakeroad is a technology mapper for programmable hardware primitives, meant more completely use all features of primitives like DSPs. 

To use Lakeroad, download a release from its releases page:
<https://github.com/gussmith23/lakeroad/releases/tag/v0.1.5>

Unzip the release, and for convenience, set the following variable:
```sh
export LAKEROAD_RELEASE_DIR="<path to extracted lakeroad>"
```

Then, add Lakeroad to your PATH:
```sh
export PATH="$LAKEROAD_RELEASE_DIR/bin:$PATH"
```

Mac users: run the `activate` script to un-quarantine the binaries.

Now, you should have Lakeroad available for use:

```sh
which lakeroad
lakeroad --help
```

Lakeroad releases come with a few examples in `$LAKEROAD_DIR/examples`. 

### Using Lakeroad from the Command Line

To map our design using Lakeroad, we can use the following command:
```sh
lakeroad \
 --verilog-module-filepath sub_mul.sv \
 --top-module-name sub_mul \
 --architecture xilinx-ultrascale-plus \
 --template dsp \
 --pipeline-depth 3 \
 --verilog-module-out-signal out:16 \
 --clock-name clk \
 --input-signal 'a:(port a 16):16' \
 --input-signal 'b:(port b 16):16' \
 --input-signal 'd:(port d 16):16' \
 --bitwuzla --stp --yices --cvc5 \
 --timeout 90 \
 --extra-cycles 2 \
 --out-format verilog \
 --module-name sub_mul \
> using_lakeroad/lakeroad_out.sv
```

And then, viewing the resource usage statistics with Yosys:

```sh 
yosys -p "read_verilog -sv using_lakeroad/lakeroad_out.sv; stat" 
```

```
=== sub_mul ===

   Number of wires:                  6
   Number of wire bits:            113
   Number of public wires:           6
   Number of public wire bits:     113
   Number of ports:                  5
   Number of port bits:             65
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                  1
     DSP48E2                         1
```

Woohoo! Lakeroad is able to use just a single DSP and no other resources.

### Using Lakeroad via Yosys

Lakeroad can integrate directly into Yosys-based flows---no need for calling an external command-line tool!

This step requires a correctly-installed Yosys, including the Yosys headers. You can check if Yosys is installed on your system with
```sh
which yosys-config
```

Lakeroad integrates into Yosys via a plugin. To build the Yosys plugin:

```sh
make -C $LAKEROAD_RELEASE_DIR/yosys-plugin
```

Instead of needing to call Lakeroad using the cumbersome command line interface, we can instead add a few simple annotations directly to our module:

[`./sub_mul.sv`:](./sub_mul.sv)
```sv
(* template = "dsp" *)
(* architecture = "xilinx-ultrascale-plus" *)
(* pipeline_depth = 3 *)
module sub_mul(
  (* clk *)
  input clk,
  (* data *)
  input  [15:0] a,
  (* data *)
  input  [15:0] b,
  (* data *)
  input  [15:0] d,
  (* out *)
  output [15:0] out
);

  logic [31:0] stage0, stage1, stage2;

  always @(posedge clk) begin
    stage0 <= (d - a) * b;
    stage1 <= stage0;
    stage2 <= stage1;
  end

  assign out = stage2;

endmodule
```

Now, we can simply utilize the `lakeroad` pass within Yosys itself, making sure we first load the plugin:

```sh
yosys -m "$LAKEROAD_RELEASE_DIR/yosys-plugin/lakeroad.so" -p "
  read_verilog -sv sub_mul.sv
  hierarchy -top sub_mul
  lakeroad -top sub_mul
  write_verilog using_lakeroad/lakeroad_via_yosys_out.sv
  stat
"
```

The results are the same as running Lakeroad from the command line:

```
=== sub_mul ===

   Number of wires:                  6
   Number of wire bits:            113
   Number of public wires:           6
   Number of public wire bits:     113
   Number of ports:                  5
   Number of port bits:             65
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                  1
     DSP48E2                         1
```

This makes Lakeroad even more convenient to use within existing flows.

## Churchroad

Currently, Lakeroad only supports very small modules---mostly modules mapping to a single DSP. To make Lakeroad more generally useful, we are building Churchroad, a tool which uses multiple calls to Lakeroad to synthesize a larger design.

Consider this simple multiply:
```sv
module mul(input [15:0] a, input [31:0] b, output [31:0] out);
  assign out = a * b;
endmodule
```

This design is too large to fit on a single DSP on Xilinx UltraScale+, and thus Lakeroad will struggle to map it.

We can synthesize the design with Yosys:

```sh
yosys -p "
  read_verilog -sv wide_mul.sv
  hierarchy -top mul
  synth_xilinx -top mul -family xcup
  xilinx_dsp
  stat
"
```

We'll see that Yosys again uses extra logic in the form of CARRY4 and LUT2:

```
=== mul ===

   Number of wires:                 15
   Number of wire bits:            381
   Number of public wires:           3
   Number of public wire bits:      80
   Number of ports:                  3
   Number of port bits:             80
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                101
     CARRY4                          4
     DSP48E2                         2
     IBUF                           48
     LUT2                           15
     OBUF                           32
```

Instead, let's use Churchroad to map the design.

You need Rust installed for this to work. You can install Rust with:
```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Now we can clone and build Churchroad. For future readers of this demo, you can check out Churchroad at [this tag](https://github.com/gussmith23/churchroad/releases/tag/2025-latch-up).

```sh
git clone https://github.com/gussmith23/churchroad
make -C churchroad/yosys-plugin
cargo build --manifest-path churchroad/Cargo.toml
```

Note that, like Lakeroad, Churchroad is also integrated as a plugin in Yosys.

```sh
RUST_LOG=churchroad=debug \
CHURCHROAD="cargo run --manifest-path churchroad/Cargo.toml -- " \
PATH="$LAKEROAD_RELEASE_DIR/deps/cvc5/bin/:$LAKEROAD_RELEASE_DIR/deps/bitwuzla/bin/:$PATH" \
yosys -m "churchroad/yosys-plugin/churchroad.so" -p "
 read_verilog wide_mul.sv
 hierarchy -top mul
 churchroad mul
 proc
 write_verilog using_churchroad/churchroad_out.sv
 stat"
```

Viewing the results, we see that Churchroad maps the design to two DSPs, producing a more efficient mapping than Yosys alone:

```
=== mul ===

   Number of wires:                 30
   Number of wire bits:            842
   Number of public wires:          17
   Number of public wire bits:     493
   Number of ports:                  3
   Number of port bits:             80
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                  2
     DSP48E2                         2
```

## In Conclusion

Lakeroad is a new FPGA technology mapper designed for programmable primitives like DSPs. Please use it on your design and submit GitHub issues when it breaks.

Churchroad is the successor to Lakeroad, and though it is currently only a prototype, it is showing early promise towards mapping larger designs needing many DSPs.

I plan to continue developing Lakeroad and Churchroad. Some future goals:
- **Support for more FPGA backends.** Lakeroad currently supports Xilinx 7-series and UltraScale+, Lattice ECP5, and some Intel FPGAs. If you have an interesting FPGA backend you'd like to map to, please contact me!
- **Support for ASIC/standard cell library mapping.**
- **Integrating other synthesis tools.** Ideally, Churchroad would combine new tools like Lakeroad with traditional tools like ABC, which are better for e.g. LUT mapping.

Thank you for trying Lakeroad and Churchroad!