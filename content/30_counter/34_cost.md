---
title: "3.4 - How much bang do you get for your buck?"
weight: 34
pre: "<i class='fas fa-book'></i> "
---

{{% multiHcolumn %}}
{{% column %}}
Now that the design is taking some size, it is time to start looking at the **cost**. You might have touched upon this earlier in this program. The triangle that is shown here allows you **to pick maximum 2** things to focus on.

* <span style="color: #00BF00; font-weight: bold;">Speed</span> (think clock frequency, throughput, latency)
* <span style="color: #0000BF; font-weight: bold;">Flexibility</span> (think 'only AES' vs 'every cryptographic algorithm ever invented')
* <span style="color: #BF0000; font-weight: bold;">Cost</span> (think euros, mm<sup>2</sup> of Silicon)
{{% /column %}}
{{% column %}}
{{% figure src="/img/30/triangle.png" title="" %}}
{{% /column %}}
{{% /multiHcolumn %}}

Generate the results of the implementation at this point. How many resources does the design require? What memory size is required? These metrics have been covered in the previous chapter. 

![Simulation Example](/img/30/screenshot_2x2.png)

From the waveform above, it can be learned that a 2x2 matrix multiplication takes 0x1b6 **clock cycles**. From the implementation results it is clear that a clock cycle takes 25 ns. 

A simple calculation learns that one 2x2 matrix multiplication has a latency of: 0x1b6 * 25 ns = 438 * 25 ns = 10'950 ns.



