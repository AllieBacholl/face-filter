#=============================================================
# File: rtype_test.asm
#
# Tests the following RV32I R-type instructions:
#   1) ADD
#   2) SUB
#   3) SLL
#   4) SLT
#   5) SLTU
#   6) XOR
#   7) SRL
#   8) SRA
#   9) OR
#   10) AND
#
# No li or la pseudo-instructions or unconditional jumps (j) are used.
# Unconditional branches are implemented as "beq x0, x0, <label>".
#=============================================================

    .section .text
    .globl _start

_start:
    ########################################################
    # 1) Test ADD: t1=5, t2=7 => t3 = 12
    ########################################################
    lui   t1, 0
    addi  t1, t1, 5
    lui   t2, 0
    addi  t2, t2, 7
    add   t3, t1, t2
    lui   t4, 0
    addi  t4, t4, 12
    bne   t3, t4, fail

    ########################################################
    # 2) Test SUB: t1=15, t2=7 => t3 = 8
    ########################################################
    lui   t1, 0
    addi  t1, t1, 15
    lui   t2, 0
    addi  t2, t2, 7
    sub   t3, t1, t2
    lui   t4, 0
    addi  t4, t4, 8
    bne   t3, t4, fail

    ########################################################
    # 3) Test SLL: t1=1, shift left by t2=4 => t3 = 16
    ########################################################
    lui   t1, 0
    addi  t1, t1, 1
    lui   t2, 0
    addi  t2, t2, 4
    sll   t3, t1, t2
    lui   t4, 0
    addi  t4, t4, 16
    bne   t3, t4, fail

    ########################################################
    # 4) Test SLT: t1=-3, t2=2 => t3 = 1 (since -3 < 2)
    ########################################################
    lui   t1, 0
    addi  t1, t1, -3
    lui   t2, 0
    addi  t2, t2, 2
    slt   t3, t1, t2
    lui   t4, 0
    addi  t4, t4, 1
    bne   t3, t4, fail

    ########################################################
    # 5) Test SLTU: t1=2, t2=5 => t3 = 1 (unsigned)
    ########################################################
    lui   t1, 0
    addi  t1, t1, 2
    lui   t2, 0
    addi  t2, t2, 5
    sltu  t3, t1, t2
    lui   t4, 0
    addi  t4, t4, 1
    bne   t3, t4, fail

    ########################################################
    # 6) Test XOR: t1=0x55, t2=0xAA => t3 = 0xFF (85 ^ 170 = 255)
    ########################################################
    lui   t1, 0
    addi  t1, t1, 85
    lui   t2, 0
    addi  t2, t2, 170
    xor   t3, t1, t2
    lui   t4, 0
    addi  t4, t4, 255
    bne   t3, t4, fail

    ########################################################
    # 7) Test SRL: t1=240, shift right by t2=4 => t3 = 15
    ########################################################
    lui   t1, 0
    addi  t1, t1, 240
    lui   t2, 0
    addi  t2, t2, 4
    srl   t3, t1, t2
    lui   t4, 0
    addi  t4, t4, 15
    bne   t3, t4, fail

    ########################################################
    # 8) Test SRA: t1=-8, shift right by t2=1 => t3 = -4
    ########################################################
    lui   t1, 0
    addi  t1, t1, -8
    lui   t2, 0
    addi  t2, t2, 1
    sra   t3, t1, t2
    lui   t4, 0
    addi  t4, t4, -4
    bne   t3, t4, fail

    ########################################################
    # 9) Test OR: t1=240, t2=15 => t3 = 255
    ########################################################
    lui   t1, 0
    addi  t1, t1, 240
    lui   t2, 0
    addi  t2, t2, 15
    or    t3, t1, t2
    lui   t4, 0
    addi  t4, t4, 255
    bne   t3, t4, fail

    ########################################################
    # 10) Test AND: t1=255, t2=15 => t3 = 15
    ########################################################
    lui   t1, 0
    addi  t1, t1, 255
    lui   t2, 0
    addi  t2, t2, 15
    and   t3, t1, t2
    lui   t4, 0
    addi  t4, t4, 15
    bne   t3, t4, fail

    beq   x0, x0, pass

pass:
1:  beq   x0, x0, 1b

fail:
2:  beq   x0, x0, 2b
