---
title: "Introducing the Colorlight 5A-75B board"
date: 2022-10-16T18:17:00+02:00
description : "A dive into a popular low-cost ECP5 development board by Chris Lasocki"
tags: ["blog"]
image: /static-2022/colorlight_5a75b.jpg
slug: Colorlight Part 1
draft: false
---

It seems that it was an accident - a generic part of a LED display has
become a low cost FPGA development board. The board in question is the
Colorlight 5A-75B, which is a so-called receiver card. Featuring a
Lattice ECP5 FPGA, supported by Yosys, it allows you to leverage a
fully open-source FPGA development toolchain. Priced on average at
20-25 USD, it is a very accessible board.

The Colorlight 5A-75B was originally a part of a modular LED display
standard. It's a receiver card, which means that it sits between the
computer controlling the show, and the LED panels themselves. It fulfills a
basic but crucial task of receiving the video signal and driving the
RGB panels accordingly. This takes a lot of bandwidth, so it is
equipped with a moderately fast ECP5 LFE5U25-F FPGA and two Gigabit
Ethernet interfaces. There is also a 16Mbit SDRAM for temporary
storage and a Flash memory of the same size for storing the
bitstream. It features 8 output ports of a known pinout (HUB75) and 5V
outputs. The board has caught attention of hardware hackers and
soon after was fully [reverse
engineered](https://github.com/q3k/chubby75) by q3k and others. A
schematic with pinouts is available, as well as other
documentation. A great amount of work has been done here and this is
what enables the Colorlight board to be used in the hacker spirit way.

Accidentally, this board design happens to be a great compromise
between feature-rich and IO-rich. The only on-board peripherals are the
basic or high speed ones, which would be hard to connect over the 0.1"
pin headers. It is also the only development board with a dual Gigabit
Ethernet interface in its price range. Since it's just an FPGA, the
16MBit SDRAM should be enough for most applications, while being easy
to implement a controller for.

Hacking the board
-----------------

With the on-board JTAG port, you just need to solder on
a 4 pin header and you are ready to upload your own bitstreams to the
ECP5 FPGA. This FPGA is fully supported by the [Yosys toolchain](https://github.com/YosysHQ/oss-cad-suite-build), from
the verilog compiler through place and route engine to the bitstream
generator, and along with an open source JTAG adapter like the Bus
Pirate (or anything else, really) it only takes a moment to send the
bitstream down and see your code run. There is a
great deal of user accessible IO broken out on the HUB75 headers.

The FPGA has a 25MHz clock directed to it, as well as one onboard LED
and a button, which is plenty enough for a Verilog "Hello, world!"
project - blinking the LED.  

The only downside of this board is lack of inputs by default - You
need to replace the 74HC245 output drivers with bidirectional level
shifters. However there exists a pin compatible level shifter IC,
SN74CBT3245A which can replace the default output driver providing 3v3
bidirectional IO. Other options, such as fabricating tiny PCBs that
replace the shifters with wires, or connecting the direction pin of the
output drivers to an IO pin are also a possibility. 

Summary
-------

The Colorlight 5A-75B is a good choice for those who want to try
open-source FPGA programming but do not wish to spend a significant
amount of money for a classic development board. The on-board
peripherals are enough for a first project to get acquainted with the
toolchain. Gigabit Ethernet and SDRAM could also come in handy in
future more advanced projects.

In the next post I will describe how to write, compile and upload a
Verilog project that will blink the onboard led of the 5A-75B board.

About the author
----------------

Chris "polprog" Lasocki ([@polprogpl](https://twitter.com/polprogpl))
is a long time electronics hacker and an aspiring physicist. FPGAs are
one of his hobbies and he is currently writing a thesis in that field.
His other interests include laser physics as well as embedded programming
projects. He runs a blog at [polprog.net](https://polprog.net).
