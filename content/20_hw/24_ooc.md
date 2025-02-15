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