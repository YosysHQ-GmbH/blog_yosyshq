---
title: "Community Spotlight - Manta"
date: 2024-04-30T20:30:31+01:00
image: /static-2024/spotlight/manta/logo.png
tags: ["community spotlight"]
---

# Manta

Welcome to another [community spotlight](/tags/community-spotlight/) article where we shine a light on open source EDA-related projects. If you want to [submit a project, please do so here](https://docs.google.com/forms/d/e/1FAIpQLSdIEgu6FJZam0-V3PMTjw-eDebJdg_JuIlN4MkLNDr4vs-a5A/viewform?usp=sf_link).

Manta is a configurable and approachable tool for FPGA debugging and rapid prototyping. It works by letting you configure cores that you instantiate in your FPGA design, and operate from a host machine connected over either UART or Ethernet. These cores can provide a logic analyzer, or direct access to registers or memory on the FPGA. Manta is written in Python, which allows its host-side to code to run on nearly any platform (including the web!). The code on the FPGA side is written in Amaranth HDL which exports to vendor-agnostic Verilog-2001, allowing it to run on nearly any FPGA.

# Fischer Moseley's Bio

![Fischer Moseley](/static-2024/spotlight/manta/cart.jpg)

I'm a FPGA Engineer working at [NASA JPL](https://www.jpl.nasa.gov/), currently working on an orbital interferometer mission called [GRACE-C](https://grace.jpl.nasa.gov/news/154/us-germany-partnering-on-mission-to-track-earths-water-movement/). I joined the lab right after getting my Master's degree from EECS from MIT last year, where I helped teach the lab-based [FPGA Design Course](https://fpga.mit.edu/) and wrote the original version of Manta for my thesis. Oh, and I built the (above) electric shopping cart there too. It's awesome. And kinda dangerous.

I've worked on Formula cars, quantum computers, robots, and spacecraft, but I have yet to see a field with as much complexity and momentum behind it as the FPGA/SoC/ASIC space. I think there's a lot of work left to do with these devices, and I get a lot of joy from building the tools around them. Manta is one such tool, and I hope you find it useful!


# What motivated you to make Manta?

When we were preparing to teach the FPGA design class at MIT, we noticed that ARM platforms were gaining popularity with students, primarily in the form of Apple Silicon. This was a problem for our EDA tool (Vivado) which, despite our best tricks, was only usable on x86 platforms. To solve this, we developed a tool that ran Vivado remotely, allowing students to build their bitstreams without having the tools installed on their machine. This worked splendidly.

However, this meant that we couldn’t use Vivado’s built-in debugging tools such as the Integrated Logic Analyzer (ILA) or Virtual IO (VIO), as these tools require Vivado’s Hardware Manager to be running on the machine connected to the FPGA. This was a bit of a problem, as students would often connect their FPGAs to external devices for their [final projects](https://mitadmissions.org/blogs/entry/6-2050-field-programmable-gate-awesomeness/), and it was nearly impossible to guarantee that those were behaving exactly as they were modeled in simulation.

Manta was written to solve this problem. It provides the same functionality that the ILA and VIO cores provide (and more!) without requiring a specific architecture or OS.

# What makes you excited about Manta?

As I’ve been developing designs at JPL, hacking on personal projects, and engaging with the community, I’ve been amazed at how long Manta tends to stick inside a project. I thought that it would only be useful at the beginning of a project for getting a quick prototype done, or that it’d only be pulled out to hunt down the occasional bug. However, this hasn’t been the case from what I’ve seen. After it’s been included, it usually tends to stay in the design - either to quickly investigate a bug if it comes up again, or to serve as the permanent link between a FPGA and its host machine.

This makes me really excited about the need that Manta is fulfilling. But there’s two features that I’m also really excited about:

### Waveform Record/Playback

Manta’s Logic Analyzer allows you to save a captured waveform as a `.vcd` file, just like any other logic analyzer. However, unlike any other logic analyzer, it lets you save a captured waveform as a Verilog module. When included in a simulation testbench, this module will generate an exact replication of the captured waveform.

This is super handy for testing RTL when the exact sequence of inputs it’ll see on the FPGA isn’t well-known. For example, when testing a network stack deployed to a FPGA, I’ve found that some USB-Ethernet adapters aren’t entirely compliant with the RMII spec, and emit slightly malformed packets. This wasn’t modeled in my simulations, but by recording a few malformed packets and playing them in a testbench, I could quickly patch the network stack.

This is just one example, but it’s been extraordinarily useful for hunting down strange hardware bugs like these!

### Web Terminal

Since Manta can communicate with a host machine over UART, it’s possible to use the Web Serial API to run Manta in the browser, directly from the documentation site:

![Manta Web Terminal](/static-2024/spotlight/manta/web_terminal.png)

And here’s a quick demo of an earlier version in action:

{{< youtube fWI9ODbyA3w >}}

Everything here is run locally in your browser, no installation required! Nothing is sent to an external server either. I’m still putting this feature together and it’s not generally available just yet, but I’d love any feedback on it - especially if anyone can think of a proper use case for it. Right now I’m just building this feature to show that it’s possible, but I’m happy to direct development in a more productive direction if one exists.


# What are some of the challenges you face?

Getting the backend of the Web Terminal working was a huge challenge! Inside the Web Terminal Manta is being run in its native Python, which relies on blocking (synchronous) IO between the host and FPGA. Javascript in the browser typically uses non-blocking (asynchronous) IO, so this required some _gnarly_ tricks to get working. I had never written a line of Javascript prior to this, so getting this working has been extremely satisfying!

# What could the community do to support you?

Try Manta and talk about it! If there’s one thing the project needs right now, it’s a community around it. If folks are making cool projects with Manta, then that’ll grow organically. Even just starring the GitHub repo helps.

Financial contributions are also always appreciated and are possible by [sponsoring me](https://github.com/fischermoseley) on GitHub. Right now I’m looking to purchase some more FPGA development boards to run automated hardware-in-the-loop tests on. If anyone has any Altera, Microchip, ECP5, or Xilinx development boards handy that they’d consider donating, please reach out!

Lastly, contributions to the source code are extremely welcome. I’m looking to add cores for AXI, AHB3, Wishbone, and Avalon busses, and help contributing to those would be greatly appreciated.

# What is the best link for the project?

All of the source code is on [GitHub](https://github.com/fischermoseley/manta), which also serves the [documentation site](https://fischermoseley.github.io/manta/).

# What is the best way for people to contact you?

If you have ideas about Manta, please open a GitHub issue on the repo! Otherwise you can reach me directly at fischer.moseley [at] gmail.com.

Also if you like motorized shopping carts and other silly projects, feel free to check out [fischermoseley.com](https://fischermoseley.com) or my [YouTube](http://www.youtube.com/@fischerm) channel!
