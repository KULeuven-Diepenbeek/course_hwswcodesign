---
title: '3.5 - Exercises'
weight: 35
pre: "<i class='fas fa-pen'></i> "
---

## Practice makes perfect

Below are a number of programming exercises. 

{{% centeredColumn 75 %}}
#### Exercise 301
{{% /centeredColumn %}}

{{% centeredColumn 50 %}}
Repeat the example of the 2x2 matrix multiplication on you own implementation.
{{% /centeredColumn %}}


{{% centeredColumn 75 %}}
#### Exercise 302
<div class="assignment">ASSIGNMENT</div>
{{% /centeredColumn %}}

{{% centeredColumn 50 %}}
Extend the implementation to (exclusively) support 3x3 matrices: 1) verify correct working, 2) find the latency, and 3) determine the cost (#LUT, #FF, imem-size)

#### Example

| | <center>3x3 matrix multiplication <br/> SW-only</center>| <center>3x3 matrix multiplication <br/> with M extension</center> | Relative <br/>&nbsp; |
|---|---|---| :-: |
|# CC<sup>1</sup>|1887|285| <div class="result_gain">15%</div> |
|T (ns)|25|36| <div class="result_loss">144%</div>
|f<sub>clk</sub> (MHz)|40|27.78| <div class="result_loss">70%</div>
|Latency (µs)|47.175|10.260| <div class="result_gain">22%</div> |
|imem size (bytes)|2441|1908|<div class="result_gain">78%</div> |
|# LUT|1553|3501|<div class="result_loss">225%</div>
|# FF|1156|1156|<div class="result_neutral">100%</div>
|||
|Througput <br/>(matrix mult/s)|1/47175e-9 = 21k mm/s | 1/10260e-9 = 97k mm /s|<div class="result_gain">462%</div> |


<sup>1</sup> This counts <u>real clock cycles</u>. The 33% duty cycle induced by the chip enable is taken into account. The non-optimal usage of the processor is hence reflected in the outcome.
{{% /centeredColumn %}}