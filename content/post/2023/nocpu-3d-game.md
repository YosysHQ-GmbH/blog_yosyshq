# 3D raytraced game using fully open source “C to FPGA” toolchain
Sphery vs. Shapes is the world's first 3D raytraced game implemented completely as digital logic. This is all made possible by combining the OSS CAD Suite with CFlexHDL and PipelineC.


## Summary
In this article we present a tool flow that takes C++ code describing a raytraced game, and produces digital logic that can be implemented in off-the-shelf FPGAs (with no hard or soft CPU used). We aim for these tools to achieve a software friendly C-to-FPGA flow, making the development + simulation process exceptionally fast and easy, while providing high performance and low power hardware results.

Thanks to project Trellis, Yosys and nextpnr can complete an open source synthesis and place and route flow for ECP5 FPGAs. This was the final piece needed to complete our C->Bitstream workflow based on fully open source tools.

![image](https://user-images.githubusercontent.com/8551129/215363908-0625eb6e-a3db-485a-89e2-10267fca6b7c.png)
_Demo [video](https://www.youtube.com/watch?v=hn3sr3VMJQU) and full sources: https://github.com/JulianKemmerer/PipelineC-Graphics_


## FPGA as a raytracer
Interactive ray tracing hardware is novel in FPGA and our work serves as a perfect example that such complex data processing circuits can be developed, tested, and implemented in hardware all from a C language based flow that greatly eases the design process over traditional hardware description languages.

Ultra-fast compiled C based emulation and C++ based tools like Verilator allow for fast simulation with realtime debug. This quick workflow is essential, being able to compile-as-C and see the results of code changes executed in realtime is a requirement for developing an interactive game, something not possible with standard FPGA simulators.

The project generates each video pixel in hard-realtime “chasing the beam”, without a frame buffer and with zero jitter. Medium size Xilinx Artix 7 FPGAs have reached up to 1080p 60FPS (148.5MHz pixel clock). This article describes using an Lattice ECP5 FPGA to reach 480p 60FPS (25MHz pixel clock). Pipelining the entire ray tracer produces a position-to-color latency of a few microseconds at most. 1080p requires about ~400 pipeline stages, 480p requires ~70 stages - in both cases this pipelining is done automatically as part of the tool flow.

The Xilinx Artix 7 FPGA achieves about 70 GFLOP/s using less than 1 watt, thanks to the pipeline with dozens of hardware resources working in parallel. Using that 28nm Xilinx 7 series FPGA, power reduction was calculated to be about 50X less compared with a modern  7nm CPU running heavily vector optimized instructions.


## Workflow
The workflow allows writing algorithms involving complex types like structures, floating point types and operations on vectors of those, all keeping a clean and familiar syntax.

![image](https://user-images.githubusercontent.com/8551129/215365602-9d1493ef-e8f1-444e-b794-b9ba7a898a08.png)

The source code is first converted by the CflexHDL tool from C++ to C. Then this subset of C can be converted to VHDL by PipelineC. GHDL and Yosys are used to convert the output VHDL into netlists that nextpnr can use.


In addition to simple conversion to VHDL, PipelineC is primarily the mechanism for producing pipelined digital logic from the pure combinatorial logic derived from C code. PipelineC is aware of the FPGA timing characteristics of the specific device (by iterating with nextpnr) and adds pipelining as needed to meet timing. This avoids the tedious and error-prone task of manual pipelining that digital designers are familiar with. The flow reports a preliminary estimate of resources prior to synthesis and the amount of pipeline stages required to implement the user’s functionality.

To produce a final bitstream GHDL+Yosys are used to generate a flattened single Verilog file version of the design that can easily be incorporated into existing build flows for board specific bitstream support, ex. Litex Orange Crab.

Alternatively, the sources can be compiled and run “as C”, as a kind of  ultra-fast emulation/simulation (the game can be played in FullHD at 60FPS during debug on PC), or the Verilog sources can be processed by Verilator and graphically simulated by another tool we provided.

![image](https://user-images.githubusercontent.com/8551129/215365530-4c922851-9ad5-431d-b85e-fa4d94d0a197.png)

From inside the PipelineC-Graphics repository there is one command to go from C file to the final bitstream generation and load your FPGA board:  `make load`. See additional instructions on github.


## Hardware architecture
The project uses a fully open source board based on a Lattice ECP5 FPGA with 85K LUTs (the OrangeCrab board) plus a PMOD-compatible digital video connector for direct connection to a monitor by adapting 3.3V signals to the required CML levels (Machdyne DDMI), they publish schematics as well. For simplicity, only the positive polarity and ground were connected: it works since the differential levels are met, at least on our test setup. The integrated button on the FPGA board is used to play the game.

![image](https://user-images.githubusercontent.com/8551129/215365509-20f5e573-07dc-49b0-bcbc-73465a991a50.png)

This setup allowed 640x480 resolution (25MHz clock) instead of 1920x1080 (148.5MHz clock) as achieved with the original setup using a Xilinx 7 series FPGA device.

The FPGA design consists of two main blocks: a state machine computing frame-by-frame animation and a long pixel rendering pipeline.

![image](https://user-images.githubusercontent.com/8551129/215365576-37c2fbdb-069d-4d61-9b17-71be7b165314.png)

To meet 25MHz timing on the Lattice ECP5 FPGA the PipelineC tool created a pixel rendering pipeline of approximately ~70 stages. Below is a visual breakdown of how many stages each major function takes and roughly where/when in the pipeline it occurs:

![image](https://user-images.githubusercontent.com/8551129/215365466-eae48ae2-8c27-408c-919a-190692aa10d4.png)


The above pipeline uses operations on custom floating and fixed point types.
* Fixed Compare: 1 stage
* Fixed Addition/Subtraction: 2 stages
* Fixed Multiplication: 2 stages
* Float Compare: 2 stages
* Float Multiplication: 2 stages
* Float Addition/Subtraction: 3 stages
* Float Fast Reciprocal: 3 stages
* Float Fast Reciprocal Square Root: 3 stages
* Float Fast Square Root: 3 stages
* Float Fast Division: 4 stages
* Float3 Vector Dot Product: 5 stages
* Float3 Vector Normalize: 7 stages
* Ray Plane Intersection: 10 stages
* Ray Sphere Intersection: 22 stages

Float’s use a 14 bit mantissa instead of the typical 23 bits, and fixed point values are represented with a total of 22 bits: 12 for integer portion, 10 for the fractional bits. Those types areprovided by CflexHDL types and can the effects of reduced precision can be readily appreciated with the provided graphical simulation tool, so the optimal size is easy to determine by performing the fast simulations.

![image](https://user-images.githubusercontent.com/8551129/215368154-a9abd122-1308-4c15-b39b-7b19be07082d.png)
<br>_full precision vs. reduced precision_

Typical times for development/test cycles are as follows:
|                         | Build command   | Build time|  Speed @1080p |
|-------------------------|-----------------|-----------|---------------|
| Fast CPU simulation     | `make sim`      |        1s |     60-86 FPS |
| Precise CPU simulation  | `make gen`      |        5s |         40FPS |
| Logic simulation        | `make verilator`|  1min 50s | 50s per frame |


## Software architecture and components
All software and tools used in this project are Open Source. We integrated the following components:

* PipelineC for C to VHDL, autopipelining (uses pycparser)
* CflexHDL for C++ parsing, fixed point types and arbitrary width floating point types, and vector of these using operator overloading
* Clang’s cindex to help in parsing C++
* Verilator for logic level simulation
* Simulator based on the SDL libraries (used when compiling the raytracer, or after Verilator C++ generation)
* Yosys for Verilog parsing and synthesis
* NextPNR for place and route (project Trellis)
* GHDL for Yosys plugin for VHDL to Verilog conversion (used by Verilator and for synthesis)
* LiteX for Orange Crab SoC design, and its video core with serialized digital outputs (DVI)

## About Yosys+nextpnr integration
The first version of the project used a commercial FPGA board and closed-source synthesis tools. After Project Trellis reverse-engineered the ECP5 device there were only a few minor workarounds that were needed to complete the chain of “everything open source” with Yosys and nextpnr.

Part of PipelineC’s autopipelining iterations involve synthesizing the design purely as combinatorial logic (pre-pipelining). The share pass that Yosys uses by default for synth_ecp5 does not handle the massive combinatorial network that defines the ray tracer design very well. RAM usage (typically ~8GB max) quickly jumps past the 16+GB we had on our workstations. Disabling the share pass required editing the Yosys source code to remove the specific ECP5 run step.

The second issue we ran into was that in early versions of ECP5 place and route support, nextpnr was not able to pack LUTs+FFs into the shared primitive block as effectively as today. As such, early attempts failed to place and route the design while still having relatively plenty of resources remaining. But after the packing support improved, nextpnr began to produce fully placed and routed designs that could be further iterated on for pipelining. Related: often the nextpnr tool would end up in an infinite loop trying to fix a few remaining overused/unrouted wires - but recent changes seem to have reduced that issue as well.

Since the PipelineC tool generates VHDL, we needed to convert the final generated sources to Verilog (to be used in Verilator simulation and to generate the bitstream). This is done using the GHDL plugin for Yosys and the Yosys write_verilog command. Occasionally Yosys passes like opt and flatten  were needed during the import process in order to avoid spikes in RAM usage.

None of these issues were blockers for long. We credit success to the fantastic open source community that provided lots of help in forums and discussions.


## Conclusions

We showed a ready-to-use toolchain for hardware design that greatly accelerates development time by using fast simulators at different stages, based on a known programming language syntax. The code can be translated to a logic circuit or run on a off-the-shelf CPU. A example application requiring complex processing was demonstrated by writing a game that implements the usual math operations for raytracing applications, with a clean syntax for math ald all the alorithms. Since we apply an automatically calculated -and possibly long- pipeline, the system is capable of performing very well even compared to powerful modern CPUs, but using smaller and embeddable chips, at low power.


## About the authors
This work is a result of the tight interactions between Julian Kemmerer (@pipelinec_hdl; fosstodon.org/@pipelinec) and Victor Suarez Rovere (Twitter: [@suarezvictor](https://twitter.com/suarezvictor)) during almost a year. 

**Victor Suarez Rovere** is the author of [CflexHDL](https://github.com/suarezvictor/CflexHDL) tool used in this project (parser/generator and math types library) and of the Sphery vs. Shapes game. He’s a software and hardware developer and consultant experienced in Digital Signal Processing, mainly in the medical ﬁeld. Victor was awarded the ﬁrst prize in the Argentine National Technology contest, a gold medal from WIPO as "Best young inventor" and some patents related to a multitouch technology based on tomography techniques.

**Julian Kemmerer** is the author of the [PipelineC](https://github.com/](https://github.com/JulianKemmerer/PipelineC) tool (C-like HDL w/ auto-pipelining) used in this work. He earned a Masters degree in Computer Engineering from Drexel University in Philadelphia where his work focused on EDA tooling. Julian currently works as an FPGA engineer at an AI focused SDR company called Deepwave Digital. He is a highly experienced digital logic designer looking to increase the usability of FPGAs by moving problems from hardware design into a familiar C language look.

