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


## Zicsr registers

Although not all 4096 registers that are addressable are used, in this course even fewer registers are discussed. The most relevant registers for this course are enumerated here.

<div style="margin-left: 10%">
<ul>
<li> <b>CSR_MRO_mhartid</b> (address: 0xF14): This register holds the <b>ID</b> of the RISC-V core
<li> <b>CSR_MRW_mstatus</b> (address: 0x300): This register holds 32 bits of <b>status bits</b>
<li> <b>CSR_MRW_misa</b> (address: 0x301): This register an <b>identifier</b> of the ISA
<li> <b>CSR_MRW_mie</b> (address: 0x304): This register masks which <b>interrupts</b> are enabled
<li> <b>CSR_MRW_mtvec</b> (address: 0x305): This register holds the address of the <b>context vector</b>
<li> <b>CSR_MRW_mstatush</b> (address: 0x310): This register holds another 32 bits of <b>status bits</b>
<li> <b>CSR_MRW_mscratch</b> (address: 0x340): This register hold the address for the <b>context space</b>
<li> <b>CSR_MRW_mepc</b> (address: 0x341): This register serves as backup register for the <b>program counter</b>
<li> <b>CSR_MRW_mcause</b> (address: 0x342): This register samples the <b>cause</b> of the interrupt
<li> <b>CSR_MRW_mip</b> (address: 0x344): This register hold <b>pending</b> requests
</ul>
</div>


## When an interrupt presents itself ...

When an interrupt presents itself the RISC-V needs to jump to the interrupt handler. However, when the interrupt is handled, the processor should continue where it left. This is achieved by the following steps

1. **[Program Counter]**: Load the program counter with a pointer to the <span style="background-color: #FFE6CC; color: #D79B00">&nbsp;trap vector&nbsp;</span>, while making a backup of the program counter in <b>CSR_MRW_mepc</b> register of the Zicsr. This requires a modification in the hardware.
0. **[Stack Pointer]**: The **context** of the processor is the state of all the registers. Before these registers can be backed up, one register needs to be freed. RISC-V uses the **stack pointer** for this. The current value is swapped with the <b>CSR_MRW_mscratch</b> register of the Zicsr.

 {{% centeredColumn 50 %}}
```S
    csrrw sp, mscratch, sp
```
 {{% /centeredColumn %}}


3. **[Regfile backup]**: With the stack pointer set, a backup of all 30 (!) registers can be made on the stack.
 {{% centeredColumn 50 %}}
```S
	sw x1,   0*4(sp)
	sw x3,   1*4(sp)
	sw x4,   2*4(sp)
    ...
	sw x31,   29*4(sp)
```
 {{% /centeredColumn %}}

 4. **[Cause]**: Fetch the cause of the interrupt from the **CSR_MRW_mcause** register, store it in **reg a0** and call the <span style="background-color: #F5F5F5; color: #666666">&nbsp;interrupt handler&nbsp;</span>.
 {{% centeredColumn 50 %}}
```S
    csrrc a0, mcause, zero
    jal ra, irq_handler
```
 {{% /centeredColumn %}}

 5. **[Restore Regfile]**: 
 {{% centeredColumn 50 %}}
 ```S
	lw x1,   0*4(sp)
	lw x3,   1*4(sp)
	lw x4,   2*4(sp)
    ...
	lw x31,   29*4(sp)
```
 {{% /centeredColumn %}}

6. **[Restore SP]**: The current value is swapped again  with the <b>CSR_MRW_mscratch</b> register of the Zicsr.

 {{% centeredColumn 50 %}}
```S
    csrrw sp, mscratch, sp
```
 {{% /centeredColumn %}}

 7. **[Return from Trap Vector]**: This can be done with a special instruction.

 {{% centeredColumn 50 %}}
```S
    mret
```
 {{% /centeredColumn %}}


{{% multiHcolumn %}}
{{% column %}}
{{% figure src="/img/40/memory_map_wo_irq.png" title="" %}}
{{% /column %}}
{{% column %}}
The software was organised as shown on the left. Upon reset, the initialisation was done in the <span style="background-color: #DAE8FC; color: #6C8EBF">&nbsp;start&nbsp;</span> section. Here, all registers get initialised, the stack pointer is set to 0x1000 and a jump is done to the <span style="background-color: #D5E8D4; color: #82B366">&nbsp;main&nbsp;</span> function. All other <span style="background-color: #F5F5F5; color: #666666">&nbsp;functions&nbsp;</span> are compiled and are linked somewhere in the instruction memory.

To allow for interrupts these sections have to move a little bit further down. This makes room for a <span style="background-color: #F8CECC; color: #B85450">&nbsp;reset vector&nbsp;</span> and a <span style="background-color: #FFE6CC; color: #D79B00">&nbsp;trap vector&nbsp;</span>.

The <span style="background-color: #F8CECC; color: #B85450">&nbsp;reset vector&nbsp;</span> is a very short set of instructions that mainly prepares the processor to <span style="background-color: #DAE8FC; color: #6C8EBF">&nbsp;do reset&nbsp;</span>. The reason for adding this section is that the processor can keep starting operation at address 0x0 and that the trap vector can start very early on a **fixed address**.

When an interrupt is present, the RISC-V should jump to the <span style="background-color: #FFE6CC; color: #D79B00">&nbsp;trap vector&nbsp;</span>. Here a backup-copy is made of all the registers to the stack, the interrupt handler is called, after which all registers are restored from the stack.
{{% /column %}}
{{% column %}}
{{% figure src="/img/40/memory_map_w_irq.png" title="" %}}
{{% /column %}}
{{% /multiHcolumn %}}

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

## Informing the compiler

As the firmware also includes Zicsr instructions now, the compiler has to be notified of this. In the Makefile, the flags for the compiler can do this trick. The parameter **arch** needs to be changed from **rv32i** to **rv32i_zicsr**.

{{% multiHcolumn %}}
{{% column %}}
```Makefile
...
ARCHITECTURE = rv32i
...
```
{{% /column %}}
{{% column %}}
```Makefile
...
ARCHITECTURE = rv32i_zicsr
...
```
{{% /column %}}
{{% /multiHcolumn %}}