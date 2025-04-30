---
title: '5.5 Optimalisations'
weight: 55
pre: "<i class='fas fa-pen'></i> "
---

The software-only implementation that has been made will serve as *a reference*. In the second phase of the project, this implementation should be improved, using HW/SW codesign techniques. Whichever technique you want to use is fine.

The goal is boost the **throughput**. A human eye needs between 20 and 30 frames to perceive succesive images as video. However, for many people it is possible to perceive up to 200 frames per second.

* calculate the encoding speed of your reference implementation. Note that you need to find the maximum clock frequency that your implementation can handle;
* pull out some tricks to **improve the througput**, with the **constraint** that the overal resource usage can not be more than double;
* make a detailed comparison between the reference implementation and the optimalisation.

To obtain the resource usage of a design, an implementation has to be done. The **Vivado** tool might run into issues with this as there might be too many input and/or outputs. To solve this, the automatic addition of IObuffers needs to be disabled. This can be done by adjusting a parameter in the synthesis tool (aka the one that adds these IObuf's).

This can be done through this change, in the syntheses settings:

> -mode out_of_context

{{% multiHcolumn %}}
{{% column %}}
![OOC1](/img/500/OOC_1.png)
{{% /column %}}
{{% column %}}
![OOC2](/img/500/OOC_2.png)
{{% /column %}}
{{% /multiHcolumn %}}