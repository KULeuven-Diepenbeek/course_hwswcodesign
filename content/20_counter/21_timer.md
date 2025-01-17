---
title: '2.1 - Timer'
weight: 21
pre: "<i class='fas fa-book'></i> "
---

A typical microcontroller has a timer. Although this is a fairly basic component, it has many useful applications. Therefore, adding a timer to your RISC-V implementation is the first extension that will be made.

The exercise could be: **Print out a dot every microsecond, print a colon on the 8th and a semi-colon on every 16th.** The expected output from such a program would look like: **.......:.......;.......:.......;...**

## Software

The first way of making a solution for this exercise can be to make it in software.

The counter that is used for the for-loop can be reused. If the 4 LSBs are zero, it divisable by 16. In the other case when 3 LSBs are zero, it is divisable by 8 and for all other cases, the default character can be printed. The image below shows the output of this program and it indeed shows what was requested.

{{% multiHcolumn %}}
{{% column %}}
{{< code_caption "21_sw_timer_v1.c" >}}
{{< include_file "/src/20/21_sw_timer_v1.c" "c" >}}

![ss_sw1](/img/20/screenshot_sw1.png)
{{% /column %}}
{{% column %}}
**BUT** ... what with the timing? 
![ss_timer_nowait](/img/20/ss_timer_nowait.png)
The time between subsequent writes can be measured by inspecting the waveforms of the simulation. With **130 ns** between subsequent writes, the RISC-V implementation is too quick to meet the timing requirements of the exercise.
{{% /column %}}
{{% /multiHcolumn %}}

#### Introducing wait-like statements

<!-- ![ss_timer_nowait](/img/20/ss_timer_nowait.png) -->


{{% multiHcolumn %}}
{{% column %}}
The C-code can be altered so there is **wait** statement.

Note that the variable *i* is declared as a **volatile** variable. It implies that the value of this variable can be altered by another source. This results in **not** having the compiler optimise this part away.

With the for-loop in the wait function iterating 50 times, the duration between subsequent writes increases to 3210 ns.
![ss_timer_wait50](/img/20/ss_timer_wait50.png)

{{% /column %}}
{{% column %}}
{{< code_caption "21_sw_timer_v2.c" >}}
{{< include_file "/src/20/21_sw_timer_v2.c" "c" >}}
{{% /column %}}
{{% /multiHcolumn %}}

If the wait-loop is iterated 25 times, the duration drops again to 1710 ns. There is a linear relationship between the number of loop iterations (x) and the duration (y) that follows the equation: **y = a\*x + b**. Two points on this *curve* are known by counting waveforms: (50, 3210) and (25, 1710). This allows to solve the equation to ```y = 60*x+210```. When targeting a duration of 1000 ns (y=1000), x can be calculated to be 13.1666. Given only integers can be used, this would introduce an **error of 10 ns** =  1000 ns - 990 ns.

