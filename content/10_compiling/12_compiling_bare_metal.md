---
title: '1.2 - Compiling Bare Metal'
weight: 12
---

When you learned to write C, you might have been in touch with compiling already. In case you're a master at compiling and cross compiling, this section is a refresher. In the other case (which also includes those that only *clicked the Compile-button in an IDE*), this section will guide you through the most import aspects (for this course).

{{% multiHcolumn %}}
{{% column %}}
**Compiling** is typically used to describe the proces that converts the C sources into a binary that can be executed. When looking into detail what happens, it turns out to be a bit more complex than simply invoking *gcc*.
```bash
cli@hwswcd:~/$> gcc -o main.bin main.c
```
{{% /column %}}
{{% column %}}
![gcc_1](/img/10/compile_1.png)
{{% /column %}}
{{% /multiHcolumn %}}


{{% multiHcolumn %}}
{{% column %}}
![gcc_1](/img/10/compile_2.png)
{{% /column %}}
{{% column %}}
A more accurate use of **Compiling** is to indicate the part of the toolchain that converts source code into machine code. (Although this is not entirely correct, going into the details falls out of the scope of this course.) The output of the compilers are called **object files (.o)** which need to be stiched together by **Linking**.
```bash
cli@hwswcd:~/$> gcc -c main.c
cli@hwswcd:~/$> gcc -o main.bin main.o
```
{{% /column %}}
{{% /multiHcolumn %}}

When your entire program only consists out of a single file, it is (probably) not worth going into this much detail. Luckily tools exists that nicely hide this away for the programmer. In this course **Make** will be used. To use make, the programmer (as in: YOU) need to work with a Makefile. (Trust me, you'll be thankful for it.)

{{% multiHcolumn %}}
{{% column %}}
The **linker** is the tool that connects everything together and fills in the dots. This example shows a very simple C program that prints the *classical* message to the output. However there is not many code written, the linker has work to do. For example, what is this **printf()** function? Where is it coming from and what does it do exactly?
As you might know already, this comes from libraries that have done some boring, heavy lifting for you.
This is just a simple example of where the linker jumps in to hook-up everything together.
{{% /column %}}
{{% column %}}
{{< code_caption "main.c" >}}
{{< include_file "/src/10/02_main.c" "c" >}}
{{% /column %}}
{{% /multiHcolumn %}}

If the machine on which the compiler and linker are executed differs from the target machine that is to execute the program, the term **cross-compilation** is used. Probably you have already used a cross compiler before (unknowingly), or haven't you programmed an Arduino yet? Although you compiled-and-linked the code on your laptop, the program was executed by another processor.

All the code in this course will also be cross-compiled. The toolchain that is used is official RISC-V C and C++ cross-compiler. You can download and install it for yourself from [GitHub](https://github.com/riscv-collab/riscv-gnu-toolchain). For more information on installing this toolchain please use {{% google %}} (e.g. [here](https://mindchasers.com/dev/rv-getting-started)).

{{% notice warning %}}
Ofcourse you are warmly invited to get the toolchain up and running on your own machines. However, this is not always easy and it can be a dive into a rabbit hole. This cross-compiler is installed on **Roger**, especially for you!
{{% /notice %}}


## Bare metal
Bare metal programming is writing software that is *not running on an Operating System (OS)*. You probably have done this (maybe unknowingly) while programming an Arduino or another microprocessor. Running without an OS has one major disadvantage: there is no OS. This implies that everything a programmer needs, has to be provided. In the C-example of the previous section, one more function has been used: ```print_hex(x, y);```. Code for this function has to be provided too. 

{{% multiHcolumn %}}
{{% column %}}
{{< code_caption "print.h" >}}
{{< include_file "/src/10/02_print.h" "c" >}}
{{% /column %}}
{{% column %}}
{{< code_caption "print.c" >}}
{{< include_file "/src/10/02_print.c" "c" >}}
{{% /column %}}
{{% /multiHcolumn %}}

With these three functions, there is an opportunity to print a character, a string (as in: a list of characters), or a hexadecimal value. A logical question would be: **"Where is my character (or other variable) printed ?"**. The answer lies in this line: 
{{< highlight c >}}
*((volatile uint32_t*)OUTPORT) = ch;
{{< /highlight >}}

Let’s break this down for those whose C-skills are a bit rusty. The define **OUTPORT** makes sure that, everywhere in the code this *define* is substituted by the 32-bit number 0x80000000. 
During assignment, this value is type-cast to an unsigned 32-bit pointer ((volatile uint32_t*)). The keyword **volatile** states that the content of a variable can also be altered from another source. <u>This is important!!</u> Otherwise the optimisation of the C-compiler might optimise-out certain lines of C-code. Finally, that *address* is dereferenced ( <b>\*</b>(*\<address\>*) ) to target *the memory* that is located at the provided address.

To make the code even more readable, another define can be made that hides this low level C-code.


{{< code_caption "print.h" >}}
{{< include_file "/src/10/02_01_print.h" "c" >}}
{{< code_caption "print.c" >}}
{{< include_file "/src/10/02_01_print.c" "c" >}}


When it comes to compiling, more files are involved. When the linker looks at the generated object files, it can now **find** all the necessary functions.

![gcc_1](/img/10/compile_3.png)

Note that also the object files can be inspected. The compiler typically includes a tool for this. In case of the RISC-V crosscompiler this tool is invoked like this: ```riscv32-unknown-elf-objdump -D build/print.o```.

{{% multiHcolumn %}}
{{% column %}}
{{< code_caption "objdump of print.o" >}}
{{< include_file "/src/10/02_print.objdump" "S" >}}
{{% /column %}}
{{% column %}}
{{< code_caption "objdump of firmware.o" >}}
{{< include_file "/src/10/02_firmware.objdump" "S" >}}
{{% /column %}}
{{% /multiHcolumn %}}



## Booting

Typically, the one function that has to be present in every C-program is the main() function. This function is called by the OS to start of the program. As in bare metal programming there is no OS, some form of **booting-process** needs to be defined. **Assembly to the rescue!!**

{{% multiHcolumn %}}
{{% column %}}
A short assembly file can jump in and do that job. This assembly code will do the following:
* initialise all the registers of the **register file** to 0x0
* initialise the **stack pointer** (x2 - sp) to 4096 (=0x00001000)
* jump to the **main function** and *backup* the program counter (x1 - ra)
* create and **endless loop** to catch a returning main function

One thing to note is the line ```.global start```. This line makes the **start function** visible outside this assembly file. As this function is going to be called from outside, this line is NOT optional.

Then there is the line ```.section .init``` which is needed. This tells the compiler that the code that follows has to be compiled under a section with the name *init*. This will later be necessary for the linking.

This assembly file is compiled in a similar way as the c-files. An object file is generated which can be inspected. Note that **0 bytes** are allocated to the *.text* section and **88 bytes** are present in the *.init* section.

{{< code_caption "objdump of start.o" >}}
{{< include_file "/src/10/02_start.objdump" "S" >}}

{{% /column %}}
{{% column %}}
{{< code_caption "start.S" >}}
{{< include_file "/src/10/02_start.S" "S" >}}
{{% /column %}}
{{% /multiHcolumn %}}


