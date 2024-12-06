.global start

.section .init, "ax"

start:
  addi x1, zero, 0
  addi x2, zero, 0
  addi x3, zero, 0
  addi x4, zero, 0
  addi x5, zero, 0
  addi x6, zero, 0
  addi x7, zero, 0
  addi x8, zero, 0
  addi x9, zero, 0
  addi x10, zero, 0
  addi x11, zero, 0
  addi x12, zero, 0
  addi x13, zero, 0
  addi x14, zero, 0
  addi x15, zero, 0
  addi x16, zero, 0
  addi x17, zero, 0
  addi x18, zero, 0
  addi x19, zero, 0
  addi x20, zero, 0
  addi x21, zero, 0
  addi x22, zero, 0
  addi x23, zero, 0
  addi x24, zero, 0
  addi x25, zero, 0
  addi x26, zero, 0
  addi x27, zero, 0
  addi x28, zero, 0
  addi x29, zero, 0
  addi x30, zero, 0
  addi x31, zero, 0
  j fibonacci

fibonacci:
    lui t6, 0x80000
    addi t5, zero, 44
    addi t4, zero, 255

    addi t0, zero, 1
    addi t1, zero, 1
    
_loop_start_1:
    beq t4, zero, done
    add t2, t0, t1
    sw t2, 0(t6)
    sw t5, 0(t6)
    add t0, t1, t2
    sw t0, 0(t6)
    sw t5, 0(t6)
    add t1, t2, t0
    sw t1, 0(t6)
    sw t5, 0(t6)
    srli t4, t4, 1
    j _loop_start_1

done:
    j done
