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


However, consider this ...

<!-- {signal: [
  {name: 'clock', wave: 'p..........'},
  {name: 'chip enable', wave: '01010101010'},
  {name: 'program counter', wave: 'x3.7.3.3.x.', data: ['A0', 'A1', 'A2', 'A3']},
  {name: 'imem output', wave: 'x.5.7.5.5.x', data: ['nop','lw t0,4(sp)','inst2', 'inst3']},
  
  {name: 'dmem address', wave: 'x...7.x....', data: ['sp+4']},
  {name: 'dmem output', wave: '2....7.2...', data: ['0x0','314','0x0']},
  {name: 't0', wave: 'x....4.....', data: ['0x0']},
  ],
  head: {text:
    ['tspan',
      ['tspan', {class:'info h3'}, 'dmem[*]=0;   dmem[sp+4]=314'],
    ]
  }
} -->
![Timing issue with BRAM bis](/img/20/wavedrom_timing_issue_BRAM_bis.png)

One clock cycle had to be artificially added for the *instruction memory*. If the instruction also involves the *data memory* **one more** clock cycle needs to be added.

<!-- {signal: [
  {name: 'clock', wave: 'p...............'},
  {name: 'chip enable', wave: '010.10.10.10.10.'},
  {name: 'program counter', wave: 'x3..7..3..3..x..', data: ['A0', 'A1', 'A2', 'A3']},
  {name: 'imem output', wave: 'x.5..7..5..5..x.', data: ['nop','lw t0,4(sp)','inst2', 'inst3']},
  
  {name: 'dmem address', wave: 'x....7..x.......', data: ['sp+4']},
  {name: 'dmem output', wave: '2.....7..2......', data: ['0x0','314','0x0']},
  {name: 't0', wave: 'x.....7.........', data: ['314']},
  ],
  head: {text:
    ['tspan',
      ['tspan', {class:'info h3'}, 'dmem[*]=0;   dmem[sp+4]=314'],
    ]
  }
} -->

![Timing fix with BRAM](/img/20/wavedrom_timing_fix_BRAM_bis.png)