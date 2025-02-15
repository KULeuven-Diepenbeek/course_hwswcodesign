---
title: '2.1 - The current situation'
weight: 21
pre: "<i class='fas fa-book'></i> "
---


{{% multiHcolumn %}}
{{% column %}}
![RISC-V32i](/img/20/riscv32i.png)
{{% /column %}}
{{% column %}}
### Take a moment to assess what has been done so far.

1. An implementation has been made of a **RISCV32i**
2. Software has been written in **C**
3. Crosscompilation was done to obtain an **.elf** file
4. Python scripts are used to generate a **hex file**
5. A testbench has been run to check the **correctness** of both hardware and software
{{% /column %}}
{{% /multiHcolumn %}}

The main question that will posed in this course is: **"What's the performance and the cost?"**. When doing hardware/software codesign that is exactly the balance that is explored: Given a certain budget, what can be achieved? Before diving into different techique of how to influence this balance, precise measurements are required.

### Finding a balance

To determine a balance, a closer look must given to what is being weighted.


#### Software

The *currency* to determine what the cost is of software, the memory should be looked at. The more memory that is consumed, the higher the cost is. A quick search on the Internet ([RS](https://benl.rs-online.com/web/c/semiconductors/memory-chips/eeprom/)) learns that a 1kB memory comes at a price of € 0.22, while a 1MB costs € 1.00. In case your designing a product that will produced 100'000 times, the cost for the memory will thus be **either € 22'000 or € 100'000**.

The required size of the memory can be obtained easily. The cross-compiler has a tool to get the size: **riscv32-unknown-elf-size**.

{{% figure src="/img/20/elf_size.png" title="Outcome of the elf-size tool" %}}

In the example shown above the tool reports that 1961 bytes are required to be stored. If a **stack** of 512 bytes is added to this, a total memory size of 2473 bytes is required.

<!-- Different types for notices are: info (yellow), tip (green), warning (red), note (blue)-->
{{% notice info %}}
Note that this only shows the requirements for the **instruction memory**.
{{% /notice %}}


#### Hardware

Before determining how much hardware is required, a decision has to be made first: What is the targeted hardware? This can be an ASIC, made with a certain technology, or an FPGA from a certain vendor family. To keep things as simple as possible, this course limits this decision to: an **AMD FPGA of the 7-series**. Whereas for an ASIC the number of cells is a *currency*, the currency for an FPGA is a little more detailed.

{{% figure src="/img/20/fpga_resources.png" title="A summary of resource utilisation" %}}

A quick search through the [AMD 7-series family overview](https://docs.amd.com/v/u/en-US/ds180_7Series_Overview) learns that a Spartan XC7S6 would be *theoretically* capable of housing this implementation. A quick serach on the Internt ([Farnell](https://be.farnell.com/en-BE)) indicates that such an FPGA costs € 18.20. Note that this cuts "a few" for corners: Will this FPGA be able to route the design? What is the cost of the PCB on which this FPGA is put? Are there sufficient capable IO pins available?


Before this table can be obtained, the design has to be nurtured a bit. This is the focus of this chapter.

<!-- Different types for notices are: info (yellow), tip (green), warning (red), note (blue)-->
{{% notice tip %}}
As the target in this course is an FPGA, the required resources already includes the instruction memory. This required resources table is hence the main outcome of a design.
{{% /notice %}}