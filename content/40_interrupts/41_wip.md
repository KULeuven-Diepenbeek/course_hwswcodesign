

RISC-V refers to an external asynchronous event that may cause a RISC-V core to execute an unexpected transfer of control as interrupt. Similarly, *an unusual condition* occurring at the run time (due to invalid instructions etc.) is referred to as **exceptions**. The term **trap** is used to collectively refer to interrupt or exception.

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
software-level external, software, timer