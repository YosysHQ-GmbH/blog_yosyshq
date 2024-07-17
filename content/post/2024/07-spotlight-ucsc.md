---
title: "Community Spotlight - Teaching with Open Source Tools"
date: 2024-07-17T16:00:00+01:00
image: /static-2024/spotlight/hsc/hsc.png
tags: ["community spotlight"]
---

# Teaching with Open Source Tools

Welcome to another [community spotlight](/tags/community-spotlight/) article where we shine a light on open source EDA-related projects. If you want to [submit a project, please do so here](https://docs.google.com/forms/d/e/1FAIpQLSdIEgu6FJZam0-V3PMTjw-eDebJdg_JuIlN4MkLNDr4vs-a5A/viewform?usp=sf_link).

This post recounts experiences from using the Open Source Tools for teaching! Many people have wondered how stable the tools are and whether they can be used in classes. Here is one experience, from UC Santa Cruz!

# Dustin Richmond Bio: 

I am an Assistant Professor of Computer Science and Engineering in the
[Baskin School of Engineering](https://engineering.ucsc.edu/) at UC
Santa Cruz. I did my postdoc in the [Bespoke Silicon
Group](https://github.com/bespoke-silicon-group) at the Paul Allen
School of Computer Science at the University of Washington, and earned
my Ph.D. with the [Kastner Research Group](https://kastner.ucsd.edu/)
at the University of California, San Diego.

You can find more about my research and projects on [my
website](https://www.dustinrichmond.com/).

# What motivated you to use the open source tools in teaching?

I’ve always been curious about reducing barriers in hardware
education. One part of my PhD studied how to make hardware design
easier for non-hardware engineers and laypeople. This is a critical
challenge we’re facing today, as we face a workforce shortage in chip
design.

When I started at UCSC I asked: “What is stopping us from
training more hardware engineers?”. Or alternatively, ”How can we
scale hardware design education?”

This is not a universal opinion, but I personally can’t imagine
teaching hundreds of students per quarter (our goal) with vendor
tools. They’re excellent when you’re an expert, but I like to compare
them to a “Point and Click Adventure Game”. They’re complex! I’m not
saying the vendor tools are bad, they’re just complex to install,
maintain, use, and write tutorials. And when you’re trying to scale
limited teaching resources, that complexity has an opportunity cost.

Logically, that led to the open source tools. They’re less complex –
and more transparent.


# Describe the class that uses these tools.

The class I teach is the third course in the Computer Engineering
series, and the second in hardware design with Verilog. The first
course focuses purely on logic design with structural Verilog. This
course introduces behavioral Verilog, verification, and some advanced
digital design concepts.

We review structural verilog and then move quickly through always
blocks, memories, Look-up-Tables, DSPs, Synthesis, Place & Route,
Clocking, functional/formal verification. All of the assignments have
some sort of implementation demo on the FPGA we use.


# What tools do you use in your class?
Students use [Verilator](https://www.veripool.org/verilator/) and
[Icarus Verilog](https://github.com/steveicarus/iverilog) for
simulation, [Yosys](https://yosyshq.net/yosys/) for synthesis, and
[NextPNR](https://github.com/YosysHQ/nextpnr) for Placement, Route and
STA. Students also use
[Symbiyosys](https://yosyshq.readthedocs.io/projects/sby/en/latest/)
for formal verification. Students can also use Verilator for linting –
which I highly encourage. To view waveforms, we use
[Surfer](https://surfer-project.org/), or
[GTKWave](https://gtkwave.sourceforge.net/). To view schematics we use
[netlistsvg](https://github.com/nturley/netlistsvg) or the dot files
emitted by Yosys.

It’s not critical, but to eliminate tool installation overhead and
misconfigurations, this is all distributed in a Dockerfile. The
Dockerfile is ingested by [GitHub
Codespaces](https://github.com/features/codespaces), so students can
run the tools in the cloud via VSCode. To view waveforms, we use the
Surfer VSCode Plugin. The end result is an all-in-one interface using
VSCode with zero installation overhead.

For implementation, we use the [Icebreaker
Board](https://1bitsquared.com/products/icebreaker) with various PMOD
peripherals (HDMI, I2S2, Joystick, keypad, Seven-Segment, etc). Not a
large board, but we can do streaming audio/video processing.

Finally, I use [cocotb](https://www.cocotb.org/) for writing
testbenches that test student code. To parameterize tests, I use
[cocotb-test](https://github.com/themperek/cocotb-test). This all
feeds into an autograder, Gradescope, using a library called
[pytest_utils](https://github.com/ucsb-gradescope-tools/pytest_utils). We
have an open-source autograder at UCSC that I intend to switch to long
term.


# What is the most surprising thing you’ve learned?

The open source tools are stable, at least as stable as the vendor
tools. I think this is the most common worry – “If I switch, will it
explode?”. I can confidently say: **No**. And even better, when they do
explode, you (or a TA) can pretty quickly figure out why. We’ve even
had a colleague push through a Verilator pull request mid-quarter.


# What are some of the benefits of switching?

## Verification
How many people have written a testbench that breaks when they switch
computers? Or versions? Or vendors? The downside of using one tool for
simulation is that it is very easy to write testbenches in Verilog
that are secretly dependent on an internal simulation model. By using
two simulators we can highlight how Verilog is evaluated, and how a
good, tool-agnostic testbench is constructed.

In the class, students spend two weeks writing testbenches. I give
them working & buggy code that has been synthesized through Yosys
(another benefit). Using testbenches they write, they have to find the
working modules and assemble them into a working design.

## Speed
It takes less time to Synthesize, Place, and Route a design than it
takes to open some vendor tools. I think this is a critical aspect for
exploration. Waiting 5-minutes just to see a light flash is a
buzzkill.

## Introspection

This is a pretty universal theme in the tools. Since they’re open
source we can actually see what happens when we simulate, synthesize,
place and route, etc. We can even open the algorithms in class and dissect them.

With the Lattice FPGAs, it is easier to explain the architecture and
then extrapolate to more complex architectures like Intel and AMD.

This introspection extends to visualisation. We use yosys to generate
schematics and view the .dot files, or use netlistsvg. We can do this
at different steps in the flow to see the abstract circuit, and
progressively optimize it. We also do this during lab check-off to
ensure that students are synthesizing to memories instead of arrays of
registers (or something worse).

# What are some of the drawbacks?

## Lack of Legacy
The vendor tools have 40-odd years of legacy support. There are entire
message boards dedicated to solving issues encountered in every tool
vendor. When you do encounter an issue in the vendor tools, it is
likely many other people have encountered it, if not solved it.

This is changing, and the open source community is great and strong,
but 40 years is a lot of ground to make up.

## Student Resistance

Students read job postings, and they want to learn the tools they see
in job postings. Our class is titled “Logic Design with Verilog”, so
we can focus on the language, not the tools. But where do we draw that
line? We’re exploring ideas like using vendor tools in the final weeks
of the quarter, after they’ve learned the language, or pushing vendor
tools to a capstone.

This is an active area of discussion. Vendor tools should be part of a
computer engineering curriculum. How much? And when?

# How can the community support you?

Come visit UC Santa Cruz! The [Hardware Systems
Collective](https://hsc.ucsc.edu/) has a weekly seminar series and we
love hearing about cool open source projects.


# How can we get in touch?

Feel free to email! I am happy to share teaching materials, but
they're in repositories, but not in a public form yet.
