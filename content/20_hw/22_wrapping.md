---
title: '2.2 - Wrapping it up'
weight: 22
pre: "<i class='fas fa-book'></i> "
---

Before the resource utilisation table can be extracted, a number of things need to be taken care of first.

### Clock and Reset

The two most important signals are **clock**. Without this signals there can be no synchronous design. In an FPGA this signal is taken care of very well to such extend that it even has its own routing network. To allow a signal access to this clocking network, dedicated buffers are available (e.g. BUFG, BUFR, BUFH). An in-depth overview of clocking in an AMD FGPA can be found in the user guides (e.g. [ug472](https://docs.amd.com/v/u/en-US/ug472_7Series_Clocking) for 7-series).

{{% multiHcolumn %}}
{{% column %}}
A good approach to clocking the FPGA is by using a mixed-mode clock manager (**MMCM**). The MMCM is a **device primitive** that takes in an external clock source and reset. It internally generates a **feedback clock** which can be parameterised. The internal design of the MMCM uses this feedback clock to tune itself to obtain a set frequency. With this internal configuration, other (up to 7!!) **internal clock signals** can be generated.

The MMCM generates a signal when an internal lock is achieved. This indicates that the output clocks are stable. If this signal is synchronised (e.g. by using a shift register) and inverted, this signal can be used as an **internal, synchronous, active-high reset**.

Note that two clock buffers are required in this design.

{{% /column %}}
{{% column %}}
![Example of MMCM usage](/img/20/mmcm.png)
{{% /column %}}
{{% /multiHcolumn %}}

The frequency of the internal clock (f<sub><i>clkout0</i></sub>) can be set using the frequnecy of the input clock (f<sub><i>clkin</i></sub>). There is a master division operation (D<sub><i>master</i></sub>) and a master multiplication operation (M<sub><i>master</i></sub>) that are applied for all clocks. These parameters shape the frequency of the VCO and must be **between 600MHz to 1200MHz** (for an FPGA with speed grade -1).

Additionaly, for each output clock of the MMCM, three parameters can be set: the duty cycyle, a specific phase shift and a specific divisor (D<sub><i>clkout0</i></sub>).
On the PYNQ-Z2 board, the following parameters would result in a **40 MHz clock**:

{{% multiHcolumn %}}
{{% column %}}
* f<sub><i>clkin</i></sub> = 125 MHz
{{% /column %}}
{{% column %}}
* D<sub><i>master</i></sub> = 1
{{% /column %}}
{{% column %}}
* M<sub><i>master</i></sub> = 8
{{% /column %}}
{{% column %}}
* D<sub><i>clkout<sub>0</sub></i></sub> = 25
{{% /column %}}
{{% /multiHcolumn %}}

{{% multiHcolumn %}}
{{% column %}}
<center><div style="border: 2px solid #54bceb; padding: 20px; margin-left: 10%; margin-right: 10%">f<sub><i>VCO</i></sub> = f<sub><i>clkin</i></sub> / D<sub><i>master</i></sub> * M<sub><i>master</i></sub></div></center>
{{% /column %}}
{{% column %}}
<center><div style="border: 2px solid #54bceb; padding: 20px; margin-left: 10%; margin-right: 10%">f<sub><i>CLKOUT<sub>0</sub></i></sub> = f<sub><i>VCO</i></sub> / D<sub><i>clkout<sub>0</sub></i></sub></div> </center>
{{% /column %}}
{{% /multiHcolumn %}}

An example of the VHDL code for the MMCM wrapper can be found <a href="/src/20/clock_and_reset_pynq.vhd" target="_blank">here</a>.

### Memories

{{% multiHcolumn %}}
{{% column %}}
To implement both the instruction and the data memory another **device primitive** will be used: the block RAM (**BRAM**). An FPGA typically has a number of dedicated memories that can be tailored to fit the design's need. More info on this primitive can be found in the user guides (e.g. [ug473](https://docs.amd.com/v/u/en-US/ug473_7Series_Memory_Resources)). For a 7-series FPGA, a BRAM is 36 kb(it!) in size. Also, these BRAMs are **dual-ported**. This means that there are two *access ports* to the same memory space. The 36 kb memory consists of 32 kb memory for data an 4kb for parity (out of scope for this course). One of the allowed proportions for this 32kb of memory is a width of 32 bits and a depth of 1024 addresses or a **1024x32-bit memory**. In the previous chapter an instruction memory (and data memory) of 2048x32-bit were expected, however. This can be made by using two BRAMs.

This image shows how two 1024x32-bit memories are combined to make one 2048x32-bit memory. The *glue logic* that is required needs to be repeated for the second port (port B).

The interface to this memory is the typical quartet: data in (**din**), address (**addr**), write enable (**we**) and data out (**dout**).
{{% /column %}}
{{% column %}}
![Example of 2kx32 BRAM](/img/20/bram.png)
{{% /column %}}
{{% /multiHcolumn %}}

A final remark on these BRAMs is that they need **at least 1 clock cycle** to produce the requested data on the output.

An example of the VHDL code for the BRAM wrapper can be found <a href="/src/20/two_k_bram.vhd" target="_blank">here</a>.


### Wrapping it up

{{% multiHcolumn %}}
{{% column %}}
![Example of 2kx32 BRAM](/img/20/wrapped.png)
{{% /column %}}
{{% column %}}
With the wrapped-up clock and reset signals, the wrapped-up memories, and the RISC-V processor, it time to wrap things together. The processor itself is written in synthesisable HDL. Both used primitives and the small wrapping code are also synthesisable. Therefore, this resulting design can be put on FPGA.

As you might have spotted already, there is no IO available in this implementation. A quick-and-dirty solution could be to simply add LEDs. Tapping on the data that goes to the data memory could be a way to sneak out data. Adding a simple bit of VHDL code could leverage this:
{{< include_file "/static/src/20/LED_parasite.vhd" "vhd" >}}
{{% /column %}}
{{% /multiHcolumn %}}

One essential file that is required still is the **constraint file**. This is file that ties input and outputs to dedicated pins of the FPGA. It might be that the file extension **.xdc** rings a bell.

As there are only 2 inputs and 4 outputs, the xdc to implement the wrapped design on a PYNQ-Z2 looks like shown here.
{{< include_file "/static/src/20/constraint.xdc" "C" >}}