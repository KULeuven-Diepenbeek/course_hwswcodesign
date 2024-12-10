---
title: '4 - Simulation'
weight: 14
---

In this course you will have to work both on the hardware and on the software. To facilitate this kind of designing, it will be useful to run simulation as smooth as possible. 

Before jumping to the testbench, it might useful to briefly refresh the concept of **synthesisable** hardware.


All hardware description languages (HDLs) have a lingo that is used to **describe** a hardware design. Typically, these HDLs also have parts of their language dedicated to verification. The parts of the HDL that describe components that can be *made* are the synthesisable subset of that language. 

{{% multiHcolumn %}}
{{% column %}}
Example of synthesiable code:
```vhdl
z <= x when y = '0' else '0';
```
{{% /column %}}

{{% column %}}
Example of non-synthesiable code:
```vhdl
process (y, x)
begin
    z <= '0'';
    wait until y = '0'
    z <= x;
end process;
```
{{% /column %}}
{{% /multiHcolumn %}}

Non-synthesisable code is used for testing/verification. A typical use for it is to describe *models* of component. 

{{% multiHcolumn %}}
{{% column %}}
{{< code_caption "basicIO_model.vhd" >}}
{{< include_file "/src/10/04_model_example.vhd" "vhdl" >}}
{{% /column %}}
{{% column %}}
This example shows the model for a basic input/output component. This code is non-synthesisable, but will be useful for testing. For the sake of completeness, the content and the working of this model are discussed below.

#### Text IO
The first part is the setting of the library and the usage of the packages. Note that there are includes for **text_io**. This is a first sign of the fact that this code will not synthesise.

#### Generics
In de entity definition, two **generics** are used. These generics are parameters that are defaulted to the set values. As a reminder it is mentioned that these **default values** are only used when they are not explicitly set upon instantiation.

#### Signals
Signals are made to interconnect things in this entity. Although it is not mandatory, this model ties signals to all the inputs and outputs. As a reminder for the hardware designer, the signals are suffixed with either **_i** for inputs or with **_o** for outputs.

Some simulators behave (slightly) different when *ports* are used in comparison to when *signals* are used. Another reason for outputs to add a signal is that these signals can be use interally as well, in contrast to out ports.

Finally, signals are declared between **architecture** and its **begin**. This is also the location where component declarations happen (which is *not* the case in this model).

{{% notice tip %}}
When you have to make a component declaration, simply copy-paste the entity of that component here. Then replace the keyword **entity** with the keyword **component**.
{{% /notice %}}

#### Behaviour
Between the begin and and of the architecture, the desired behaviour is described. In this case the following functionalities are implemented:

* The output port **writing_out_flag** will be high when the address is 0x8000_0000 and the WE (write enable) signal is high
* Upon reset, a file is opened for writing. The **filename** is given through a generic.
* When a write is done to address 0x8000_0000, a variable (**v_line**) is set with the incoming value. Subsequently the variable is written to the file handle.

With this description of the model (and the earlier C-example for printing), it should be clear what it is used for :wink:.
{{% /column %}}
{{% /multiHcolumn %}}

The testbench that will be used in this course will start with a description like shown below.

![sim_design](/img/10/sim_design.png)

With the testbench set up like shown above, a (relatively) fast way of developing-and-testing is facilitated.

{{% notice tip %}}
In case you are using Vivado to simulate your design, testing a new version of the firmware is easy. Simply **restart** the simulation, as in: hit the Restart button. When you also make modifications to your hardware design, you have to **relauch** te simulation. The latter takes more time than restarting.
{{% /notice %}}

## The proposed approach for developing and testing

Working in an organised way might look cumbersome, but it will definetly pay of on the long(er) run. The remainder of this section describes *one* way of working.

{{% multiHcolumn %}}
{{% column %}}
![org_fs](/img/10/org_fs.png)
{{% /column %}}
{{% column %}}
#### It all starts on the filesystem

The code that you will be writing can ultimately be seen as *as bunch of files*. It is recommended that you stick to a certain organisation. As with many things that will follow (in this course, or in 'live'), this might require an investment, but you will reap the fruits of this later and multiple times.

This image shows a way of organising:

* **project name**: this folder is simply the name of the project, or the exercise that you are working on;
* **doc**: it makes sense (as you undoubtedly know) to keep some documentation. This can be in the form of markdown files, for example;
* **firmware**: The folder that hold everything that has to do with *software*
    * **build**: an empty folder that will be used store intermediate files (e.g. object files)
    * **src**: a folder for the .h and .c files
    * Makefile: ... well, this is the Makefile for your .elf
* **hdl**: a folder for the hardware description files
    * **tb**: a folder for the non-synthesisable code
        * .vhd: non-synthesisable .vhd files
    * .vhd: synthesisable .vhd files
* **scripts**: a folder for scripts
    * **python**: python tools
    * **tcl**: project generation scripts
{{% /column %}}
{{% /multiHcolumn %}}

A fixed file structure, like the one described above, will ensure that:

* you can more **easily find your way**
* you can **(re-)generate** tool-dependant projects
* you have a text-file-only folder that is perfect for **version control**