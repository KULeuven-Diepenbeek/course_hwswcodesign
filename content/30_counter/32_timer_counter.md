---
title: '3.2 - HW Timer'
weight: 32
pre: "<i class='fas fa-book'></i> "
---

A typical microcontroller has a timer. Although this is a fairly basic component, it has many useful applications. Therefore, adding a timer to your RISC-V microcontroller is the first extension that will be made.

A textbook exercise could be: **Toggle a LED roughly every 500 ms and with each fourth period, toggle all the LEDS**.

## Hardware

A second way of making a solution for the aforementioned exercise can be made in hardware. Commercially available of the shelf (COTS) microprocessors typically have hardware-based timer/counter functionalities. Such a timer/counter (TCNT) has multiple waveform generator modes: Normal, Clear-Timer-on-Compare and Pulse Width Modulation. A possible architecture for such a timer is shown below.

![tcnt](/img/30/tcnt.png)

### How do you connect this hardware to the processor?

As you might have spotted already, the RISC-V (in the version we are using it) always works with *words* that are 32 bits in width: instruction-width, register-width, ALU-width, ... Hence, it is to be expected that hardware that will be attached to this RISC-V, will need a 32-bit interface. A standard approach to faciliate this is to put a **wrapper** around the customly build hardware.

{{% figure src="/img/30/tcnt_wrapped.png" title="Wrapped timer/couner" %}}

This *should* ring a bell from an ealier course: **System-on-Chip design and experimentation (3314)**. The technique that will be used is called: **Memory-mapped IO (MMIO)**. All the inputs and outputs of the wrapped timer are mapped onto 32-bit registers. The registers, that are present inside the wrapper, will then be linked to address in the 32-bit address space to which the processor can write and read from.

{{% multiHcolumn %}}
{{% column %}}
#### Inputs
Two registers are allocated for **commands**. One of these 32-bit registers will be directly wired to the **CMP** (compare) input of the Timer/Counter. The other register will control both 2-bit inputs **CS** and **WGM**. As the hardware designer it is your choice how these mappings are done. As an example, the two LSBs of the register (indexes 1 and 0) can be assigned to the clock select (CS) and the next two LSBs (indexes 3 and 2) can be assigned to the waveform generation mode (WGM). The bit at index 8 will control the clear (**CLR**).
{{% /column %}}
{{% column %}}
#### Outputs
Two registers are allocated for **status**. One of these 32-bit registers will be directly fed by the **TCNT** (timer value) output of the Timer/Counter. The other register will reflect the 3 single-bit outputs **CEQ**, **OFl** and **PWM**. As the hardware designer it is your choice how these mappings are done. As an example, the three LSBs of the register (indexes 2, 1 and 0) can be assigned to the pulse width modulation (PWM), the overflow (OFl) and the compare equal (CEQ).
{{% /column %}}
{{% /multiHcolumn %}}

{{% figure src="/img/30/wrapper_mapping.png" title="Register mapping in the wrapper" %}}

With the mapping of the IOs in the wrapper done, the final step needs to be taken: **map the registers in the memory space**. In all fairness, this has already been done in the first chapter. Writing to the output to facilitate *printing* was also done through *an address*: 0x80000000. The mapping of the registers of the TimerCounter will be appended to this. Note that a *gap* is left.

{{% multiHcolumn %}}
{{% column %}}
{{% figure src="/img/30/memory_map.png" title="Memory map" %}}
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
{{< include_file "/static/src/30/22_tcnt.h" "C" >}}
{{% /column %}}
{{% column %}}
#### tcnt.c
{{< include_file "/static/src/30/22_tcnt.c" "C" >}}
{{% /column %}}
{{% /multiHcolumn %}}

With the drivers as shown above, starting the Timer/counter becomes more clear:

```C
		TCNT_start();
```

## Now to tie the loose ends

Up until now, there were only 2 *subscribers* to the data memory channel: the data memory itself and the basic IO block. In the exercises in the last chapter, the basic IO block was implemented as a register that drives the LEDs. <!-- The **DMEM** having access to this channel should not come as a surprise. Maybe the **Basic IO** block is not that much of a surprise either. After all, it only *accepts* data. When the software wants to print something out, it writes to our agreed address: 0x80000000. --> Data flowing in the other direction (**into** the processor) could only come from the DMEM.

When taking the same channel for the timer/counter inteface as well, it becomes a little more tricky. Sure, similarly to the Basic IO block, writing to the **TCNT wrapper** does not introduce any problems. The other way, reading from the timer/counter, does. Data through the memory interface channel, that goes into the microprocessor, now has **2 different sources**. Simply attaching these signals would introduce <u>double drivers</u>.


{{% multiHcolumn %}}
{{% column %}}
To solve this issue, a multiplexer is typically placed. Within the scope of this course, it will be assumed that <u>each peripherals has 256 addresses</u>. For the timer/counter this boils down to: **0x810000**<u>00</u> to **0x810000**<u>FF</u>. Given that a *word* takes 4 addresses, this means that a peripheral can use up to 64 32-bit registers.

With this approach each peripheral has a **BASE ADDRESS** (0x810000 for the timer/counter) that is 24 bits wide. The selection input of the added multiplexer can thus be the 24 MSBs of the address on the data bus.
{{% /column %}}
{{% column %}}
![mux](/img/30/mux.png)
{{% /column %}}
{{% /multiHcolumn %}}






<!-- ## Now it's your turn 

Use the timer component to solve: 
> **Print out a dot every microsecond, print a colon on the 8th and a semi-colon on every 16th.** -->

