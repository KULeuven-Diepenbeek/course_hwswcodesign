---
title: '1 - Programming the RISC-V'
weight: 11
---

In the third year of the Bachelor program, you have done the course unit  **Computer architecture** (3435). In this course you made an implementation for a RISC-V processor. This course (of which you are currently reading the course material) starts with one of the earlier implementations you made: the **RV32I** implementation. The processor runs a *program* and the ins-and-outs of this will be the handover point between both courses.


{{% multiHcolumn %}}

{{% column %}}

## Assembly

The implementation of the ISA is capable of executing instructions. These instructions are written in assembly. As you have implemented the processor itself, you will probably be familiar with the concept. 

An example is shown here that calculates the first *n* numbers of the Fibonacci row. Before setting of to calculate the famous sequence, all the registers in the **register file** are initialised on 0x0.

Next, some initialisations are done. These instructions ensure the temporary registers t0, t1, t4, t5, and t6 are set. 

Subquently a loop is started (as long as the content of t4 is not zero) which adds t0 and t1 into t2; then adds t1 and t2 into t0; and thirdly adds t2 and t0 into t1.
Before the loop is re-evaluated, the value in t4 is shifted right 1 position.

Running this program in a simulator will give you a waveform, similar to the one that is shown below.

### ... vs Machine code

Maybe the assembly code that is shown already adds a level of abstraction to what you used earlier. Let's take an example **add t0, t1, t2**. For a human (like yourself, I'd take it :wink:) this is somewhat understandable: *Add t1 to t2 and put the sum in t0*. Unfortunately, this is not what can be asked from the RISC-V implementation. Some *encoding* is required:

* add is an R-type instruction, with opcode **0110011**
* the sum is stored in t0, which is the same as x5, so rd is **00101**
* add is an R-type instruction, with funct3 **000**
* the first term is stored in t1, which is the same as x6, so rs1 is **00110**
* the second term is stored in t2, which is the same as x7, so rs2 is **00111**
* add is an R-type instruction, with funct7 **0000000**

If all these bits are concatenated, the 32-bit binary string is formed *0b00000000011100110000001010110011*. Writing it hexadecimally, this becomes: **0x007302b3**. Many tools exist that help us automate this, however (e.g. [instruction encoder/decoders](https://luplab.gitlab.io/rvcodecjs/#q=007302b3&abi=true&isa=AUTO)).

Adding layers of abstraction helps us (the human programmer) to write code more easily: **add t0, t1, t2** vs **0x007302b3**.

{{% notice note %}}
Note the *endless* loop at the end. What is it for?
{{% /notice %}}

{{% /column %}}
{{% column %}}
{{< include_file "/src/10/firmware.S" "S" >}}
{{% /column %}}
{{% /multiHcolumn %}}

![fib](/img/10/sim_fib.png)

## Let's **C** another level of abstraction

Another level of abstraction can make programmer-live even more manageable. In this course you will be programming in a higher-level programming language: **C**.

{{% multiHcolumn %}}
{{% column %}}
{{< include_file "/src/10/fib.c" "c" >}}
{{% /column %}}
{{% column %}}
The example shown here, is written in C and is much more human-friendly. Four variables are declared and two of them are initialised. After printing these values, a loop is executed in which the Fibonacci sequence is calculated and printed. All printed values are 2-digit hexadecimal and they are seperated with a dash ('-').

The output of this program can be seen here:
![fib](/img/10/sim_c.png)
{{% /column %}}
{{% /multiHcolumn %}}

Before your implementation of the RISC-V core is capable of running this **very simple** code, there is still some work left. The remainder of this chapter will cover *'all you need to know'*. 