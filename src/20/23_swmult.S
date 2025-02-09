# Software multiplication. It returns the product of a0 and a1
sw_mult: 
    # Return a0, in case it is 0x0
    bne a0, zero, sw_mult_init
    jalr zero, 0(ra)
sw_mult_init:
    # Initialise t0 (=x-1) and t1 (=y)
    add t1, a1, zero
    addi t0, a0, -1
    # Return y if t0 is 0x0
    bne t0, zero, sw_mult_loop
    add a0, a1, zero
    jalr zero, 0(ra)
sw_mult_loop:
    # Add (t1 += a1) and substract (t0--)
    add t1, t1, a1
    addi t0, t0, -1
    # Check to see if the operation is done
    bne t0, zero, sw_mult_loop
    add a0, t1, zero
    jalr zero, 0(ra)