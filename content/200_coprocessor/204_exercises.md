---
title: '204 - Exercises'
weight: 204
---

#### Exercise 201

{{% centeredColumn 50 %}}
Try to get the example for the Hamming distance to work.
<br/>
<br/>
Make a comparison like the table in 202 where you compare your pure software implementation of the Hamming distance with the codesign.

{{% /centeredColumn %}}

#### Exercise 202

{{% centeredColumn 50 %}}
Transform the Hamming distance coprocessor to work on the <b>div</b> instruction in stead of the mul instruction.
{{% /centeredColumn %}}

#### Exercise 203

{{% centeredColumn 50 %}}
Make a new coprocessor that calculates the average of two integer numbers. If the result is non-integer, round it down. For example avg(32,16) = 24 and avg(3,4) = 3. Try to avoid using the <b>pcpi_wait</b> signal.

Compare a software-only version with a hardware/software codesign of the solution.

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
