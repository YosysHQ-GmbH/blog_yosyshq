---
title: "Community Spotlight - AutoSVA"
date: 2023-05-10T13:26:31+01:00
image: /static-2022/spotlight/spotlight.png
tags: ["community spotlight"]
---

# AutoSVA

Welcome to another [community spotlight](/tags/community-spotlight/) article where we shine a light on open source EDA projects. If you want to [submit a project, please do so here](https://docs.google.com/forms/d/e/1FAIpQLSdIEgu6FJZam0-V3PMTjw-eDebJdg_JuIlN4MkLNDr4vs-a5A/viewform?usp=sf_link).

AutoSVA makes Formal Property Verification (FPV) more accesible for hardware designers.

# Marcelo Vera's Bio

![Marcelo Vera](/static-2023/spotlight/marcelo.jpeg)

Marcelo is a PhD candidate in the Department of Computer Science at Princeton University advised by Margaret Martonosi and David Wentzlaff. He received his BSE from University of Murcia. Marcelo is interested in hardware innovations that are modular, to make SoC integration practical. His research focuses on Computer Architecture, from hardware RTL design and verification to software programming models of novel architectures. 
He has previously worked in the hardware industry at Arm, contributing to the design and verification of three GPU projects, and at Cerebras Systems, creating High-Performance Computing kernels.
At Princeton, he has contributed in two academic chip tapeouts that aims to improve the performance, power and programmability of several emerging workflows in the broad areas of Machine Learning and Graph Analytics.

# What was your motivation in making AutoSVA?

AutoSVA was build with the goal of making Formal Property Verification (FPV) more accesible for hardware designers. AutoSVA brings a simple language to make annotations in the signal declaration section of a module interface. This enables us to generate FPV testbenches that check that transactions between hardware RTL modules follow their interface specifications. It does not check full correctness of the design but it automatically generate liveness properties (prevent duplicated responses, prevent requests being dropped) and some safety-relate properties of transactions, like data integrity, transaction invariants, uniqueness, stability...

# Why do you develop open source tools?

As the title of our paper suggests "Democratizing Formal Verification of RTL Module Interactions”
the motivation on making the tool was to make FPV more accesible for hardware designers without much prior knowledge in formal methods.
Thus, open-sourcing makes the most sense when the goal is to get people to use your tool.

# What are some of the challenges you face?

Hardware RTL projects can be very heterogeneous, I made the language and tool pretty flexible to take any Verilog or SystemVerilog, but I wouldn’t be surprise it the tool complained about some syntax or some include files. The tool also has a way to set inlcude paths on the tool command line, but you never know!

# What could the community do to support you?

I would be happy if the community would keep using it, find limitations, and extend the tool. There are plenty of opportunities to add functionality. I’m working myself on an extension to automatically find timing channels via hardware state left unflushed between context switches. Stay tuned for updates, Use the tool and contribute back, I’m happy to take pull requests!

# What is the best link for the project?

https://github.com/PrincetonUniversity/AutoSVA

# What is the best way for people to contact you?

* Email: movera@princeton.edu
* LinkedIn: https://www.linkedin.com/in/marcelo-orenes-vera-391390b8/

