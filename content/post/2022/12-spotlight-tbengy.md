---
title: "Community Spotlight - Tbengy"
date: 2022-12-14T10:23:57+01:00
image: /static-2022/spotlight/spotlight.png
tags: ["community spotlight"]
---

# Tbengy

Welcome to the first in a series of short articles where we shine the light on open source EDA projects. If you want to [submit a project, please do so here](https://docs.google.com/forms/d/e/1FAIpQLSdIEgu6FJZam0-V3PMTjw-eDebJdg_JuIlN4MkLNDr4vs-a5A/viewform?usp=sf_link).

Tbengy by [Prasad Pandit](#connect-with-prasad-pandit) is a Python Tool for SV/UVM Testbench Generation and RTL Synthesis. The tool uses newly available capability of the Vivado tool by Xilinx to compile and run SV/UVM Testbench and syntheize RTL for Digilent FPGA Boards.

The project is hosted on Github under an MIT License: 

https://github.com/prasadp4009/tbengy

# Prasad Pandit's Bio

![prasad](/static-2022/spotlight/prasad.jpg)

I am a Hardware Engineer by profession which is my hobby as well. I enjoy tinkering with FPGAs, Arduinos and building IoT devices to make my life more easy. My interest revolves around making chips and building things with 3D printers.

# Motivation to make tbengy:

I have been developing and using small python scripts for personal use. During the pandemic, as we all know many people lost their jobs including engineers from the Semiconductor Industry. In the same time period, I got a chance to tinker with my FPGAs and was working on developing a tool that can help me create a project skeleton as well as scripts to test my design and verify them. When it comes to design compilation, whether it's VHDL, Verilog or Systemverilog we have a lot of open-source as well as commercial tools, problem comes when we want to compile UVM for verification. There isn't much scope for people other than using EDAPlayground or use Commercial tools which are not easily available. Also maintaining projects on EDAPlayground in a structured way is not supported.

While updating my Vivado, I read the release notes and found that the Webpack version (free version) now supports complete UVM 1.2 compilation and simulations. This gave me the idea to build a python tool "tbengy", which can run on any OS (Windows or Linux) and generates an easily editable and compilable UVM testbench in a structured manner and scripts which will help engineers interested in UVM verification to hone their skills on their machine. I also added support for a Blinky project which generates design, DV and synthesis scripts for all Digilent boards.

# Why open source?

I believe in open collaboration. Linux is the best example of what open source can bring to this world and that inspired me to be a part of this community. The Open source tools like MAGIC and OpenROAD which today makes it possible for anyone to design ASICs right from their own machine, this is another motivation for me to give more to this community.


# What are the challenges?

Being a hardware engineer, software is not my expertise. This became more evident to me when I created string templates in python where after some research I figured there are template libraries like Jinja2, which if used will help a lot in bringing the knowledge of hardware with use of more structured and efficient software in making better tools. 

# What could the community do to support you?

I found out that it's difficult to get your work reviewed in open source and tapping the right audience. I will be glad if experienced users both from hardware and software domain can review the tool and provide better direction as well as requirements will help in taking the tool to the next level.

# Connect with Prasad Pandit

* LinkedIn: https://www.linkedin.com/in/panditprasad/
* YouTube: https://www.youtube.com/@PrasadPandit
* Twitter: https://twitter.com/@tonystark_hdl
