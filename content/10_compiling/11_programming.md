---
title: '1.1 - Programming the RISC-V'
weight: 11
pre: "<i class='fas fa-book'></i> "
---

In the third year of the Bachelor program, you have done the course unit **Computer architecture** (3435). In this course you made an implementation for a RISC-V processor. This course (of which you are currently reading the course material) starts with one of the earlier implementations you made: the **RV32I** implementation. The processor runs a *program* and the ins-and-outs of this will be the handover point between both courses.The implementation of the ISA is capable of executing instructions. These instructions are written in assembly. As you have implemented the processor itself, you will probably be familiar with the concept. 


{{% multiHcolumn %}}

{{% column %}}

## Assembly

An example is shown here that calculates the first *n* numbers of the Fibonacci row. Before setting of to calculate the famous sequence, all the registers in the **register file** are initialised on 0x0.

Next, some initialisations are done. These instructions ensure the temporary registers x5, x6, x29, x30, and x31 are set. 

Subquently a loop is started (as long as the content of x29 is not zero) which adds x5 and x6 into x7; then adds x6 and x7 into x5; and thirdly adds x7 and x5 into x6.
Before the loop is re-evaluated, the value in x29 is shifted right 1 position.

Running this program in a simulator will give you a waveform, similar to the one that is shown below.

### ... vs Machine code

Maybe the assembly code that is shown already adds a level of abstraction to what you used earlier. Let's take an example **add x7, x5, x6**. For a human (like yourself, I'd take it :wink:) this is somewhat understandable: *Add x5 to x6 and put the sum in x7*. Unfortunately, this is not what can be asked from the RISC-V implementation. Some *encoding* is required:

* add is an R-type instruction, with opcode **0110011**
* add is an R-type instruction, with funct3 **000**
* the sum is stored in x7 so rd is **00111**
* the first term is stored in x5, so rs1 is **00101**
* the second term is stored in x6, so rs2 is **00110**
* add is an R-type instruction, with funct7 **0000000**

If all these bits are concatenated, the 32-bit binary string is formed *0b0000000 00110 00101 000 00111 0110011*. Writing it hexadecimally, this becomes: **0x006283b3**. Many tools exist that help us automate this, however (e.g. [instruction encoder/decoders](https://luplab.gitlab.io/rvcodecjs/#q=007302b3&abi=true&isa=AUTO)).

{{% /column %}}
{{% column %}}
{{< include_file "/src/10/01_firmware.S" "S" >}}
{{% /column %}}
{{% column %}}
{{< include_file "/src/10/01_firmware.mc" "S" >}}
{{% /column %}}
{{% /multiHcolumn %}}

![fib](/img/10/sim_fib.png)

Adding layers of abstraction helps us (the human programmer) to write code more easily. Although assemly can barely be classified as *readable* it is still an improvement over machine code. The **ABI (Application Binary Interface)** fixes (some) naming conventions. Registers x5, x6 and x7 are temporary registers and can be labeled t0, t1, t2, respectively. Although it is not much, this again aids us humans to more easily understand the software: **add t2, t0, t1** vs **0x006283b3**.

{{% notice note %}}
Note the *endless* loop at the end. What is it for?
{{% /notice %}}

## Let's **C** another level of abstraction

Another level of abstraction can make programmer-live even more manageable. In this course you will be programming in a higher-level programming language: **C**.

{{% multiHcolumn %}}
{{% column %}}
{{< include_file "/src/10/01_fib.c" "c" >}}
{{% /column %}}
{{% column %}}
The example shown here, is written in C and is much more human-friendly. Four variables are declared and two of them are initialised. After printing these values, a loop is executed in which the Fibonacci sequence is calculated and printed. All printed values are 2-digit hexadecimal and they are seperated with a dash ('-').

The output of this program can be seen here:
![fib](/img/10/sim_c.png)
{{% /column %}}
{{% /multiHcolumn %}}



Before your implementation of the RISC-V core is capable of running this very simple code, there is still some work left. The remainder of this chapter will cover *'all you need to know'*. 