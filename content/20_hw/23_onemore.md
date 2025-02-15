---
title: '2.3 - One more thing ...'
weight: 23
pre: "<i class='fas fa-book'></i> "
---

The implementation of the RISC-V that is used in this course, is a **single-cycle implementation**. Nonetheless, in earlier courses you might have already seen how pipelining has a huge effect on the implementation. The major advantage of a single-cycle implementation is that it is rather simple to understand and implement. The major drawback is that is not as performant, but it going to get even <u>*worse*</u>.

In the previous section, it was shown that the BRAM needs **at least one clock cycle** to read from the memory. Unfortunately, this does not work for a single cycle implementation.

<!-- {signal: [
  {name: 'clock', wave: 'p......'},
  {name: 'program counter', wave: 'x3333x.', data: ['A0', 'A1', 'A2', 'A3']},
  {name: 'expected instruction', wave: 'x5555x.', data: ['inst0','inst1','inst2', 'inst3']},
  {name: 'BRAM output', wave: 'x.5555x', data: ['inst0','inst1','inst2', 'inst3']},
]} -->
![Timing issue with BRAM](/img/20/wavedrom_timing_issue_BRAM.png)

The easiest **"fix"** for this is disable the processor every other cycle.


<!-- {signal: [
  {name: 'clock', wave: 'p..........'},
  {name: 'chip enable', wave: '01010101010'},
  {name: 'program counter', wave: 'x3.3.3.3.x.', data: ['A0', 'A1', 'A2', 'A3']},
  {name: 'BRAM output', wave: 'x.5.5.5.5.x', data: ['inst0','inst1','inst2', 'inst3']},
]} -->
![Timing fix with BRAM](/img/20/wavedrom_timing_fix_BRAM.png)

Even from the width of waveforms above, the issue with this **fix** can be clearly seen: **the latency is doubled!**

<!-- Different types for notices are: info (yellow), tip (green), warning (red), note (blue)-->
{{% notice note %}}
Note that the same issue also occurs for the **data memory**, but the proposed *fix* immediately solves this issue as well.
{{% /notice %}}