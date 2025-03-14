---
title: '404 - Exercises'
weight: 404
---

#### Exercise 401

{{% centeredColumn 50 %}}
Try to get the <b>example</b> to work.
{{% /centeredColumn %}}


#### Exercise 402

{{% centeredColumn 50 %}}
Determine how much time it takes for handling a single interrupt.
{{% /centeredColumn %}}

#### Exercise 403

{{% centeredColumn 50 %}}
Start from the example of the counter in [302](http://localhost:1313/hwswcodesign-course/300_soc/302_counter/). Have the peripheral trigger an interrupt when the count reaches **100'000'000**. Given that a clock cycle takes 10 ns. an interrupt should be triggered every (10 ns/CC x 100'000'000 CC) second. Meanwhile the processor is in an endless loop that prints something.
When the interrupt comes, handle it accordingly and reset the counter.
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
