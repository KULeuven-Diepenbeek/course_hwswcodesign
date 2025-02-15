---
title: '1.5 - Exercises'
weight: 15
pre: "<i class='fas fa-pen'></i> "
---

## Practice makes perfect

Below are a number of programming exercises. The aim is that you **1)** retrieve your RISC-V implementation **2)** prepare a working setup, and **3)** refresh your low-level C programming skills.

As a reminder ... a zip archive to get you started can be found
<a href="/src/hwswcd_template.zip" download>here</a>.


{{% centeredColumn 75 %}}
#### Exercise 101
{{% /centeredColumn %}}
{{% centeredColumn 50 %}}
For this exercise you should simply try to get the zip file to work on your own RISC-V.

As FPGA device, you can pick a <b>ZYNQ XC7Z020-1CLG400C</b>. An even better solution is to pick the <b>PYNQ-Z2 board</b> in case you have the board drivers installed.
{{% /centeredColumn %}}

{{% centeredColumn 75 %}}
#### Exercise 102
{{% /centeredColumn %}}
{{% centeredColumn 50 %}}
Add a <b>print_dec()</b> function.
{{% /centeredColumn %}}


{{% centeredColumn 75 %}}
#### Exercise 103
{{% /centeredColumn %}}
{{% centeredColumn 50 %}}
Write a firmware function <b>get_hamming_weight()</b> that calculates the Hamming weight of a value. 

Print the Hamming weight to the output.
{{< highlight C >}}
unsigned int get_hamming_weight(unsigned int x);
{{< /highlight >}}

Determine how long it takes (in clock cycles) to perform the calculation !!

{{% /centeredColumn %}}


{{% centeredColumn 75 %}}
#### Exercise 104
{{% /centeredColumn %}}

{{% centeredColumn 50 %}}
Write a firmware function <b>get_hamming_distance()</b> that calculates the Hamming distance between two values.

Print the Hamming distance to the output.
{{< highlight C >}}
unsigned int get_hamming_distance(unsigned int x, unsigned int y);
{{< /highlight >}}

Determine how long it takes (in clock cycles) to perform the calculation !!

{{% /centeredColumn %}}

<!-- #### Exercise 106

{{% centeredColumn 50 %}}
Write a firmware function <b>get_factorial()</b> that calculates the factorial of an unsigned integer.

Print the result to the output.
{{< highlight C >}}
unsigned int get_factorial(unsigned int x);
{{< /highlight >}}

Determine how long it takes (in clock cycles) to perform the calculation !!

{{% /centeredColumn %}} -->

{{% centeredColumn 75 %}}
#### Exercise 105
<div class="assignment">ASSIGNMENT</div>
{{% /centeredColumn %}}

{{% centeredColumn 50 %}}
Write a firmware function <b>convert()</b> that converts temperature from Fahrenheit to degrees Celsius. <u>The result may be rounded down to approximate the conversion.</u>. The conversion can be calulated using this equation: 

<center>
(<b>F</b> − 32) × 5/9 = &nbsp;<b>°C</b>
</center>

Print the result to the output.
{{< highlight C >}}
unsigned int convert(unsigned int x);
{{< /highlight >}}

Determine how long it takes (in clock cycles) to perform the calculation !!

{{% notice warning %}}
Be aware that the implementation of the RISC-V is **RV32I**!!
{{% /notice %}}

{{% /centeredColumn %}}
