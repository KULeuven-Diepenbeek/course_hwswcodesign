---
title: '5 - Exercises'
weight: 15
---

## Practice makes perfect

Below are a number of programming exercises. The aim is that you **1)** retrieve your RISC-V implementation **2)** prepare a working setup, and **3)** that you refresh you low-level C programming skills.
 <!-- In the exercises where inputs are required, these **inputs can be hardcoded** as we have no means of inputting data to the processor. -->

<!-- An example of the file structure can be seen [here](https://github.com/KULeuven-Diepenbeek/course_hwswcodesign/tree/master/src/100). -->


{{% centeredColumn 75 %}}
#### Exercise 101
{{% /centeredColumn %}}
{{% centeredColumn 50 %}}
For this exercise you should simply try to get the examples of this chapter to work.
<ol>
    <li>create a Vivado project</li>
    <li>import the picorv32.v description </li>
    <li>import the testbench and the memory model</li>
    <li>generate the .hex file</li>
    <li>run the simulation</li>
    <li>parse the output</li>
</ol>
As FPGA device, you can pick a <b>ZYNQ XC7Z020-1CLG400C</b>. An even better solution is to pick the <b>PYNQ-Z2 board</b> in case you have the board drivers installed.
{{% /centeredColumn %}}

#### Exercise 102
{{% centeredColumn 50 %}}
Complete the <b>print_dec()</b> function.
{{% /centeredColumn %}}

#### Exercise 103

{{% centeredColumn 50 %}}
Update the simulation so that the output address is <b>0x8000000</b>.
{{% /centeredColumn %}}

#### Exercise 104

{{% centeredColumn 50 %}}
Write a firmware function <b>get_hamming_weight()</b> that can calculate the Hamming weight of a value. 

Print the Hamming weight to the output.
{{< highlight C >}}
unsigned int get_hamming_weight(unsigned int x);
{{< /highlight >}}

Determine how long it takes (in clock cycles) to perform the calculation !!

{{% /centeredColumn %}}


#### Exercise 105

{{% centeredColumn 50 %}}
Write a firmware function <b>get_hamming_distance()</b> that can calculate the Hamming distance between two values.

Print the Hamming distance to the output.
{{< highlight C >}}
unsigned int get_hamming_distance(unsigned int x, unsigned int y);
{{< /highlight >}}

Determine how long it takes (in clock cycles) to perform the calculation !!

{{% /centeredColumn %}}

#### Exercise 106

{{% centeredColumn 50 %}}
Write a firmware function <b>get_factorial()</b> that calculates the factorial of an unsigned integer.

Print the result to the output.
{{< highlight C >}}
unsigned int get_factorial(unsigned int x);
{{< /highlight >}}

Determine how long it takes (in clock cycles) to perform the calculation !!

{{% /centeredColumn %}}

#### Exercise 107

{{% centeredColumn 50 %}}
Write a firmware function <b>convert()</b> that converts temperature from Fahrenheit to degrees Celsius. <u>The result may be rounded down to approximate the conversion.</u>.

Print the result to the output.
{{< highlight C >}}
unsigned int convert(unsigned int x);
{{< /highlight >}}

Determine how long it takes (in clock cycles) to perform the calculation !!

{{% notice note %}}
(<b>&nbsp;F</b> − 32) × 5/9 = &nbsp;<b>°C</b>
<br/>e.g. 32&nbsp;F&nbsp;=&nbsp;0&nbsp;°C
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;86&nbsp;F&nbsp;=&nbsp;30&nbsp;°C
{{% /notice %}}
{{% /centeredColumn %}}

<!-- ------------------------------------------------------------------------ -->
<hr/>
{{% multiHcolumn %}}
{{% column %}}
{{% notice warning %}}
**Handing in exercises**<br/><br/>
When you upload your assigments, check the following:<br/><br/>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#x2022; all your files are <i>archived</i> in <u>one single file</u> (.zip, .tar, ...)<br/>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#x2022; structurise your files in subfolders<br/>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#x2022; <b>firmware/</b> containing all the software: build files, binaries, ...<br/>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#x2022; <b>firmware/src/</b> containing all the source files (.c, .S, ...)<br/>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#x2022; <b>hdl/</b> containing all the hardware descriptions (.vhd, .v, .sv, ...)<br/>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#x2022; <b>hdl/tb/</b> containing all the simulation files (.vhd)<br/>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#x2022; files like a README.md, vivado_script.tcl, ...<br/>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#x2022; README.md: if you want to add some additional info<br/>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &#x2022; vivado.tcl: script to automate project creation in Vivado<br/>
{{% /notice %}}
{{% /column %}}
{{% column %}}
![Tree](/img/assignment_structure.png)
{{% /column %}}
{{% /multiHcolumn %}}

{{% notice tip %}}
If you look at the structure of how you need to hand in assignments, you might spot something. These are all plain text files and there are not many of them. However, this will enable you to generate all data you need: binaries, hex-files, vivado projects, bitstreams, ... <br/>
In case you want to use some <b>version control</b> (like GitHub), it would make sense to track only these files.
{{% /notice %}}
