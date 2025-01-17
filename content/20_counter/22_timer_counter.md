---
title: '2.2 - Timer/counter'
weight: 22
pre: "<i class='fas fa-book'></i> "
---



A typical microcontroller has a timer. Although this is a fairly basic component, it has many useful applications. Therefore, adding a timer to your RISC-V implementation is the first extension that will be made.

The exercise could be: **Print out a dot every microsecond, print a colon on the 8th and a semi-colon on every 16th.** The expected output from such a program would look like: **.......:.......;.......:.......;...**

## Hardware

A second way of making a solution for the aforementioned exercise can be made in hardware. Commercially available of the shelf (COTS) microprocessors typically have hardware-based timer/counter functionalities. Such a timer/counter (TCNT) has multiple waveform generator modes: Normal, Clear-Timer-on-Compare and Pulse Width Modulation. A possible architecture for such a timer is shown below.

![tcnt](/img/20/tcnt.png)

### How do you connect this hardware to the processor?

As you might have spotted already, the RISC-V (in the version we are using it) always works with *words* that are 32 bits in width: instruction-width, register-width, ALU-width, ... Hence, it is to be expected that hardware that will be attached to this RISC-V, will need a 32-bit interface. A standard approach to faciliate this is to put a **wrapper** around the customly build hardware.

{{% figure src="/img/20/tcnt_wrapped.png" title="Wrapped timer/couner" %}}

This *should* ring a bell from an ealier course: **System-on-Chip design and experimentation (3314)**. The technique that will be used is called: **Memory-mapped IO (MMIO)**. All the inputs and outputs of the wrapped timer are mapped onto 32-bit registers. The registers, that are present inside the wrapper, will then be linked to address in the 32-bit address space to which the processor can write and read from.

{{% multiHcolumn %}}
{{% column %}}
#### Inputs
Two registers are allocated for **commands**. One of these 32-bit registers will be directly wired to the **CMP** (compare) input of the Timer/Counter. The other register will control both 2-bit inputs **CS** and **WGM**. As the hardware designer it is your choice how these mappings are done. As an example, the two LSBs of the register (indexes 1 and 0) can be assigned to the clock select (CS) and the next two LSBs (indexes 3 and 2) can be assigned to the waveform generation mode (WGM).
{{% /column %}}
{{% column %}}
#### Outputs
Two registers are allocated for **status**. One of these 32-bit registers will be directly fed by the **TCNT** (timer value) output of the Timer/Counter. The other register will reflect the 3 single-bit outputs **CEQ**, **OFl** and **PWM**. As the hardware designer it is your choice how these mappings are done. As an example, the three LSBs of the register (indexes 2, 1 and 0) can be assigned to the pulse width modulation (PWM), the overflow (OFl) and the compare equal (CEQ).
{{% /column %}}
{{% /multiHcolumn %}}

{{% figure src="/img/20/wrapper_mapping.png" title="Register mapping in the wrapper" %}}

With the mapping of the IOs in the wrapper done, the final step needs to be taken: **map the registers in the memory space**. In all fairness, this has already been done in the first chapter. Writing to the output to facilitate *printing* was also done through *an address*: 0x80000000. The mapping of the registers of the TimerCounter will be appended to this. Note that a *gap* is left.

{{% multiHcolumn %}}
{{% column %}}
{{% figure src="/img/20/memory_map.png" title="Memory map" %}}
{{% /column %}}
{{% column %}}
### Driver
With the mapping as described here, the timer/counter is usable for the processor. To facilitate this, a driver is required. If you put some additional effort into writing a good driver, the resulting C-code that uses this hardware will be simplified.

To brute-force the counter to work (without a driver), a line of C-code like this will suffice:
```C
*((volatile unsigned int*)0x81000000) = 3;
```

While this will simply *work*, it does not read that user-friendly. Although **you** know what are doing **now**, other people do not. Chances are that even you will spotted scratching your head looking at this code, a few weeks from **now**.

Let's make it more friendly for others (and your future self).
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
#### tcnt.h
{{< include_file "/src/20/22_tcnt.h" "C" >}}
{{% /column %}}
{{% column %}}
#### tcnt.c
{{< include_file "/src/20/22_tcnt.c" "C" >}}
{{% /column %}}
{{% /multiHcolumn %}}

With the drivers as shown above, starting the Timer/counter becomes more clear:

```C
		TCNT_start();
```

## Now to tie the loose ends

{{% multiHcolumn %}}
{{% column %}}
With the situation as is, we have:

* a processor with a fixed memory map
  * one section is allocated for the printing
  * one section is allocated for the timer/counter
* <span style="color: red; font-style: italic">&lt;glue&gt;</span>
* a hardware wrapper around the timer/counter
* a hardware block that implements timer/counter

What we are left with is implementing the <span style="color: red; font-style: italic">&lt;glue&gt;</span>.
{{% /column %}}
{{% column %}}

The microprocessor (mainly) has two memory interfaces. One interface is a read-only memory interface that goes to **IMEM**. This impacts the instruction handling and is not useful for this task. The other interface is a read-write memory interface that goes to **BRAM**. This is the one that will be used.

{{% multiHcolumn %}}
{{% column %}}
The typical memory interface has the following interface:
* an n-bit data input
* a log<sub>2</sub>(n)-bit address input
* a write-flag
* an n-bit data output
{{% /column %}}
{{% column %}}
{{% figure src="/img/20/mem_iface.png" title="" %}}
{{% /column %}}
{{% /multiHcolumn %}}
{{% /column %}}
{{% /multiHcolumn %}}

When the microprocessor wants to perform <u>a read operation</u> from the memory, it presents the **address** and keeps the **write** low. The data on that address in the memory will appear on the **data_out**. When the microprocessor wants to perform <u>a write operation</u> to the memory, the **write** has to be high while the address is **applied**. The data that needs to be written is presented on the **data_in**.

{{% multiHcolumn %}}
{{% column %}}
![sim_design](/img/20/sim_design_1.png)
{{% /column %}}
{{% column %}}
Up until now, there were only 2 *subscribers* to the data memory channel: the data memory itself ... and the basic IO block. The **DMEM** having access to this channel should not come as a surprise. Maybe the **Basic IO** block is not that much of a surprise either. After all, it only *accepts* data. When the software wants to print something out, it writes to our agreed address: 0x80000000.

Data flowing in the other direction (from the DMEM channel into the processor) could only come from the DMEM.
{{% /column %}}
{{% /multiHcolumn %}}

When taking the same channel for the timer/counter inteface as well, it becomes a little more tricky. Sure, similarly to the Basic IO block, writing to the **TCNT wrapper** does not introduce any problems. The other way, reading from the timer/counter, does. Data through the memory interface channel, that goes into the microprocessor, now has **2 different sources**. Simply attaching these signals would introduce <u>double drivers</u>.

![sim_design](/img/20/sim_design.png)

<!-- ## Now it's your turn 

Use the timer component to solve: 
> **Print out a dot every microsecond, print a colon on the 8th and a semi-colon on every 16th.** -->