---
title: '4.2 - Zicsr'
weight: 42
pre: "<i class='fas fa-book'></i> "
---

## Instructions

The RISC-V specifications describe how interrupts should be handled in RISC-V. This is covered (among other things) in an **extension**: **Zicsr**. RISC-V refers to an external asynchronous event that may cause a RISC-V core to execute an unexpected transfer of control as **interrupt**. Similarly, *an unusual condition* occurring at the run time (due to invalid instructions etc.) is referred to as **exceptions**. The term **trap** is used to collectively refer to interrupt or exception.

A separate address space of **4096 Control and Status registers** are associated with each hart. Six additional instructions are provided to interract with these registers.

{{% figure src="/img/40/zicsr_instructions.png" title="" %}}

These instructions perform **atomic** substitutions between the CSR register and either a register from the registerfile or an immediate value.

{{% figure src="/img/40/exchange.png" title="" %}}


| Register name | Description | 
|---|---|
| CSRRW rd, CSR_ID, rs1 | Write **rs1** to the register CRS_ID while reading the content of CRS_ID into **rd** |
| CSRRS rd, CSR_ID, rs1 | Write **CRS_ID <u>OR</u> rs1** to the register CRS_ID while reading the content of CRS_ID into **rd** |
| CSRRC rd, CSR_ID, rs1 | Write **CRS_ID <u>AND</u> not(rs1)** to the register CRS_ID while reading the content of CRS_ID into **rd** |
|||
| CSRRWI rd, CSR_ID, *value* | identical to CSRRW but with an immediate value in stead of **rs1** |
| CSRRSI rd, CSR_ID, *value* | identical to CSRRS but with an immediate value in stead of **rs1** (setting bits) |
| CSRRCI rd, CSR_ID, *value* | identical to CSRRC but with an immediate value in stead of **rs1** (clearing bits) |


## Registers

Although not all 4096 registers that are addressable are used, in this course even fewer registers are discussed. The most relevant registers for this course are enumerated here.

<div style="margin-left: 10%">
<ul>
<li> <b>CSR_MRO_mhartid</b> (address: 0xF14): This register holds the <b>ID</b> of the RISC-V core
<li> <b>CSR_MRW_mstatus</b> (address: 0x300): This register holds 32 bits of <b>status bits</b>
<li> <b>CSR_MRW_misa</b> (address: 0x301): This register an <b>identifier</b> of the ISA
<li> <b>CSR_MRW_mie</b> (address: 0x304): This register masks which <b>interrupts</b> are enabled
<li> <b>CSR_MRW_mtvec</b> (address: 0x305): This register holds the address of the <b>trap vector</b>
<li> <b>CSR_MRW_mstatush</b> (address: 0x310): This register holds another 32 bits of <b>status bits</b>
<li> <b>CSR_MRW_mscratch</b> (address: 0x340): This register hold the address for the <b>trap</b> handler
<li> <b>CSR_MRW_mepc</b> (address: 0x341): This register serves as backup register for the <b>program counter</b>
<li> <b>CSR_MRW_mcause</b> (address: 0x342): This register samples the <b>cause</b> of the interrupt
<li> <b>CSR_MRW_mip</b> (address: 0x344): This register hold <b>pending</b> requests
</ul>
</div>



<!-- 
While CSRs are primarily used by the privileged architecture, there are several uses in unprivileged code including for counters and timers, and for floating-point status.

The counters and timers are no longer considered mandatory parts of the standard base ISAs, and so the CSR instructions required to access them have been moved out of Chapter [rv32] into this separate chapter.


RISC-V supports two main trap handling mechanisms: **direct** and **vectored**. Based on the last 2 bits of the mtvec register (or stvec for ‘S’ mode), it could be either perform Direct handling (bit values – 00) or Vectored handling (bit values – 01).


Conditions for interrupt to M-mode

* current priv mode is M and the MIE-bit in **mstatus**-reg is set
* i-bit is set in **mip** and **mie**
* [if -e mideleg] and !mideleg(i)

These conditions for an interrupt trap to occur must be evaluated in a bounded amount of time from
when an interrupt becomes, or ceases to be, pending in mip, and must also be evaluated immediately
following the execution of an xRET instruction or an explicit write to a CSR on which these interrupt
trap conditions expressly depend (including mip, mie, mstatus, and mideleg).

mip(13) <= lcofip   -- (RO) '0' when Sscofpmf extension is not implemented
mip(11) <= meip     -- interrupt pending for machine-level external interrupts (RO) is set and cleared by a platform-specific interrupt controller
mip(9) <= seip      -- (RO) '0' when S-mode is not implemented
mip(7) <= mtip      -- interrupt pending for machine timer interrupts (RO) is cleared by writing to the memory-mapped machine-mode timer compare register.
mip(5) <= stip      -- (RO) '0' when S-mode is not implemented
mip(3) <= msip      -- interrupt pending for software interrupts (RO) is written by accesses to memory-mapped control registers,
mip(1) <= ssip      -- (RO) '0' when S-mode is not implemented

mie(13) <= lcofie   -- (RO) '0' when Sscofpmf extension is not implemented
mie(11) <= meie     -- interrupt enable for machine-level external interrupts
mie(9) <= seie      -- (RO) '0' when S-mode is not implemented
mie(7) <= mtie      -- interrupt enable for machine timer interrupts
mie(5) <= stie      -- (RO) '0' when S-mode is not implemented
mie(3) <= msie      -- interrupt enable for software interrupts 
mie(1) <= ssie      -- (RO) '0' when S-mode is not implemented



Multiple simultaneous interrupts destined for M-mode are handled in the following decreasing
priority order: MEI, MSI, MTI, SEI, SSI, STI, LCOFI.
machine-level external, software, timer
software-level external, software, timer -->