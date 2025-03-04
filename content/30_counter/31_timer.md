---
title: '3.1 - SW Timer'
weight: 31
pre: "<i class='fas fa-book'></i> "
---

A typical microcontroller has a timer. Although this is a fairly basic component, it has many useful applications. Therefore, adding a timer to your RISC-V microcontroller is the first extension that will be made.

A textbook exercise could be: **Toggle a LED roughly every 500 ms and with each fourth period, toggle all the LEDS**.

## Software

The first way of making a solution for this exercise can be to make it in software.

Simply making loop that increments and resets on 4 will do the trick. The image below shows the output of this program and it indeed shows what was requested.

{{% multiHcolumn %}}
{{% column %}}
{{< include_file "/static/src/30/31_sw_timer_v1.c" "c" >}}
{{% /column %}}
{{% column %}}
**BUT** ... what with the timing? 
![ss_timer_nowait](/img/30/ss_timer_nowait.png)
The time during which the LEDS are off is half of the flashing period. In this example the period hence is 2 x **150 ns** = 3e<sup>-7</sup> s. The RISC-V implementation is too quick to meet the timing requirements of the exercise.
{{% /column %}}
{{% /multiHcolumn %}}

#### Introducing wait-like statements

{{% multiHcolumn %}}
{{% column %}}
The C-code can be altered so there is **wait** statement. Note that the variable *i* is declared as a **volatile** variable. It implies that the value of this variable can be altered by another source. This results in **not** having the compiler optimise this part away.

Through simulatio three different *configurations* can be obtained: (20, 194325), (25, 299025) and (10, 52650).
{{< include_file "/static/src/30/31_sw_timer_v2.c" "c" >}}

{{% /column %}}
{{% column %}}
![ss_timer_wait10](/img/30/ss_timer_wait10.png)
![ss_timer_wait20](/img/30/ss_timer_wait20.png)
![ss_timer_wait25](/img/30/ss_timer_wait25.png)
{{% /column %}}
{{% /multiHcolumn %}}


 There is a polynomial relationship between the three configurations. A bit of algebra can learn you the equation: ```y = 451.5*x² + 622.5*x + 1275```. When targeting a duration of 500'000'000 ns is targeted, **x** can be calculated to be 1052. Given only integers can be used, this would introduce a **small error** [(1051, 499'382'874) and (1052, 500'333'001)].

