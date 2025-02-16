---
title: '2.4 - Go as fast as you can'
weight: 24
pre: "<i class='fas fa-book'></i> "
---

This chapter has introduced the use of a digital clock manager. A nice feature that comes from using such a primitive is that you can set the desired clock frequency to a value that suits your implementation like a glove. Although that is a nice feature, the question arises: **"What is the maximal frequency?"**. As you (hopefully) know by know, the maximal frequency is determined by the critical path.

The **critical path** in digital circuit design refers to the longest sequence of dependent operations that determine the minimum clock period, and thus the maximum clock frequency. It is the path through the circuit that takes the most time to propagate a signal from one end to the other, encompassing all the logic gates and interconnections involved.

An easy way to find what the highest achievable is to simply try :wink: 

1. Set the output frequency of the CLKOUT0 port to 50 MHz;
1. Generate a bitstream;
1. Verify that the worst negative slack (WNS) is a positive number;
1. Tighten or loosen the constraint and repeat.

When reporting on the resource usage it does not suffice to "only give the number of slices and BRAMs". Making a design that is capable of running at 40 MHz will look different than a design that runs at 40 kHz. The resource usage will differ for both these designs. **Therefore it is important that the clock frequency for which the numbers hold is also report.** Additionaly, the **target** is also an important parameter that should be given. The results of an implemented design, at a certain clock frequency, will look different on an old VirtexII-Pro than on a 7-series UltaScale.

{{% multiHcolumn %}}
{{% column %}}
#### Hardware
| Design Ch2 PYNQ-Z2 | Slices <br/>(LUT, Reg, Slices) | BRAM | DSP | IO | MMCM |
|---|---|---|---|---|---|
| v1.0  (@ 50MHz)    | 1431 / 1072 / 588      | 4      | 0     | 6    | 1      |
| v1.0  (@ 25MHz)    | 1412 / 1072 / 635      | 4      | 0     | 6    | 1      |
{{% /column %}}
{{% column %}}
#### Software
| Design Ch2 PYNQ-Z2 | .text | .bss | stack |
|--------------------|-------|------|-------|
| v1.0  (@ 50MHz)    | 588   | 4    | 512   |
* imem usage: 1208B / (2048x4B) (14.7%)
{{% /column %}}
{{% /multiHcolumn %}}

