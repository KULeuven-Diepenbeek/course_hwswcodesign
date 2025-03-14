---
title: '54 Project'
weight: 54
draft: false
---

The project within this course will have you designing an SOC that encodes sensor data to a QOI encoded image. As it would not be realistic to build the entire system, a number of compents will only be simulated: 

* **APB_mem_model**: this is model for the memory containing the instructions and data
* **APB_print_model**: this is model for the SD-card storage. For the sake of simplicity, it is assumed that all writes to **0x8000000** will automatically be handled. This is similar as the print model that was seen earlier.
* **APB_sensor_model**: this model simulates the camera. When an image is taken, it is stored in RAW format. The sensor autonomously stores its data starting from **0x40000008** onwards. On **0x40000000** the sensor writes the width of the image and on **0x40000004** the height is written.

![Example image](/img/500/project.png)

## Goals

This project is to be achieved in two steps: 

1. a software-only version, and 
0. a HW/SW codesign.

This first version (SW-only) will set the playing level. Additionally, this will help you in understanding the encoding scheme. The result of the first version will be a working implementation. This will allow you to *run the numbers* (latency, resource usage, throughput, ...).

When the first version is done, you choose which optimisations you're going to make. After these optimisations are approved, you'll set of to make the HW/SW codesign. You can use which ever technique you think is best for obtaining your optimisations.

Below you can find a number of resources that might come in handy.

### Resources

{{% multiHcolumn %}}
{{% column %}}&nbsp;{{% /column %}}
{{% column %}}
* Link to the [QOI specification](https://qoiformat.org/qoi-specification.pdf)
* Example image in: ['sensor-data-format'](https://github.com/KULeuven-Diepenbeek/course_hwswcodesign/blob/master/src/project/data/example_image.dat), [png](https://github.com/KULeuven-Diepenbeek/course_hwswcodesign/blob/master/src/project/data/example_image.png), and in [qoi](https://github.com/KULeuven-Diepenbeek/course_hwswcodesign/blob/master/src/project/data/example_image.qoi)
{{% /column %}}
{{% column %}}&nbsp;{{% /column %}}
{{% /multiHcolumn %}}

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
