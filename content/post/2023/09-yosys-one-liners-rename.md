---
title: "Yosys One Liners - Rename"
date: 2023-06-12T16:52:39+02:00
tags: ["one liners"]
image: /static-2023/oneliners.jpeg
draft: false
---

Scenario: you're developing some Verilog RTL and after synthesis the ASIC tools you're using fail on the design! It won't accept square brackets in the input!

Here's the DUT:

    module test(
        input   wire [7:0] a,
        input   wire [7:0] b,
        output  wire [8:0] sum
    );

        assign sum = a + b;

    endmodule

    module gen(
        input   wire [23:0] a,
        input   wire [23:0] b,
        output  wire [26:0] c,
    );
        genvar i;
        generate
        for (i=0; i<=2; i=i+1) begin
            test test (
                .a      (a[i*8+:8]),
                .b      (b[i*8+:8]),
                .sum    (c[i*9+:9])
            );
        end
        endgenerate
    endmodule

And here we see the square brackets in the output:

    yosys -qp 'read_verilog generate.v; prep -top gen; write_verilog out.v'

    grep test out.v
        test \genblk1[0].test  (
        test \genblk1[1].test  (
        test \genblk1[2].test  (

Your challenge is to write a yosys one liner that renames the generated module names so they no longer contain square brackets.

Our solution is:

    yosys -p 'read_verilog generate.v; prep -top gen; rename -hide */c:*[*; rename -enumerate -pattern bracket_% */c:$auto$rename*; write_verilog out.v'

    grep test out.v 
        test bracket_0 (
        test bracket_1 (
        test bracket_2 (


If you want to find out more about the Yosys rename command, [please read the documentation here](https://yosyshq.readthedocs.io/projects/yosys/en/latest/cmd/rename.html).
