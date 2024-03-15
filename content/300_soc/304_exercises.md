---
title: '304 - Exercises'
weight: 304
---

#### Exercise 301

{{% centeredColumn 50 %}}
Try to get the example for the counter-enforced SoC to work.
{{% /centeredColumn %}}

#### Exercise 302

{{% centeredColumn 50 %}}
Make a <b>new</b> (as in: don't modify the dummy) component that can calculated the Hamming distance of two values.
<br/>
<br/>
Make a comparison like the table in 202 where you compare your pure software implementation of the Hamming distance with the codesign.
{{% /centeredColumn %}}

#### Exercise 303

{{% centeredColumn 50 %}}
Make a new component that calculates the sine of a positive angle. The angle is provided as natural number (no decimals), in degrees and can be up to 10 bits.
<br/>
<br/>
<b>To prevent decimal numbers</b>, the resulting value should be multiplied with 1'000'000. The remaining decimal digits can be dropped. Hence the result should fit in 20 bits.
<br/>
<br/>
<b>Negative numbers</b> should be represented in <a href="https://en.wikipedia.org/wiki/Two%27s_complement" target="_blank">two's complement</a>.

<br/><br/>Some examples:
<img src="/img/300/sinetable.png"/>

<center><b>PROTIP:</b> work <u>smart</u>, not <u>hard</u> !!</center>
{{% /centeredColumn %}}

#### Exercise 304

{{% centeredColumn 50 %}}
Make a <b>new</b> component that can calculated at matrix multiplication. This is (one of) the core operattion(s) in machine learning. Not to complicate things too much: **1)** only the matrix multiplication of two 2x2 matrices should be made; **2)** the elements are 8-bit in size; and **3)** the multiplication should be *modulo 256* (as in, only take the 8 least significant bits of the product).

For those who don't remember how matrix multiplicatiork, it goes like this.

<img src="/img/300/matrix_mul.png"/>

<br/>
Make a comparison like the table in 202 where you compared your pure software implementation of the Hamming distance with the codesign.
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
![Tree](/img/300/handin_tree.png)
{{% /column %}}
{{% /multiHcolumn %}}

{{% notice tip %}}
If you look at the structure of how you need to hand in assignments, you might spot something. These are all plain text files and there are not many of them. However, this will enable you to generate all data you need: binaries, hex-files, vivado projects, bitstreams, ... <br/>
In case you want to use some <b>version control</b> (like GitHub), it would make sense to track only these files.
{{% /notice %}}
