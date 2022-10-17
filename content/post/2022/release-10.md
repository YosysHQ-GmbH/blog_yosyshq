---
title: "Tabby CAD Suite version 20221011 released!"
date: 2022-10-17
description : "Here-documents now supported with Verific"
image: /static-2022/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The October release of Tabby CAD Suite is now available for download.

The read and verific commands now support here-documents in scripts, the same way as read_verilog. This is useful e.g. to have small self-contained tests in a single file such as:

    read -sv <<EOT
    module top(input clk, output reg [1:0] q);
        wire [1:0] x = 2'b10;
        always @(posedge clk)
            q <= x & 2'b11;
    endmodule
    EOT
    prep -top top
    sim -clock clk -n 1 -w top
    select -assert-count 1 a:init=2'b10 top/q %i
