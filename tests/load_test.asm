#=============================================================
# File: load_test.asm
#
# Tests the following RISC-V load instructions:
#   1) LB
#   2) LH
#   3) LW
#   4) LBU
#   5) LHU
#
# Each test checks sign-extension or zero-extension.
# If any test fails, branch to fail:, else branch to pass:.
#
# No li or la pseudo-instructions or j instructions.
# Unconditional branches use beq x0, x0.
#
# Data is assumed to be at fixed addresses.
#=============================================================

    .section .data
    .align 4

test_data_byte:      .byte   0x7F         # +127
test_data_half:      .half   0x7FFF       # +32767
test_data_word:      .word   0x7FFFFFFF   # +2147483647
test_data_byte_neg:  .byte   0x80         # -128
test_data_half_neg:  .half   0x8000       # -32768
test_data_word_neg:  .word   0x80000000   # -2147483648

    .section .text
    .globl _start

_start:
    ###################################################################
    # 1) LB test: positive byte (0x7F -> +127)
    ###################################################################
    # Suppose test_data_byte is at fixed address 0x2000.
    lui   t0, 0x2       # 0x2 << 12 = 0x2000
    addi  t0, t0, 0     # t0 = 0x2000
    lb    t1, 0(t0)
    lui   t2, 0
    addi  t2, t2, 127
    bne   t1, t2, fail

    ###################################################################
    # 2) LB test: negative byte (0x80 -> -128)
    ###################################################################
    # Suppose test_data_byte_neg is at 0x2004.
    lui   t0, 0x2
    addi  t0, t0, 4     # 0x2004
    lb    t1, 0(t0)
    lui   t2, 0
    addi  t2, t2, -128
    bne   t1, t2, fail

    ###################################################################
    # 3) LH test: positive half (0x7FFF -> +32767)
    ###################################################################
    # Suppose test_data_half is at 0x2010.
    lui   t0, 0x2
    addi  t0, t0, 0x10  # 0x2010
    lh    t1, 0(t0)
    lui   t2, 8         # 8<<12 = 32768
    addi  t2, t2, -1    # 32767
    bne   t1, t2, fail

    ###################################################################
    # 4) LH test: negative half (0x8000 -> -32768)
    ###################################################################
    # Suppose test_data_half_neg is at 0x2014.
    lui   t0, 0x2
    addi  t0, t0, 0x14  # 0x2014
    lh    t1, 0(t0)
    lui   t2, -8       # -8<<12 = -32768
    bne   t1, t2, fail

    ###################################################################
    # 5) LW test: positive word (0x7FFFFFFF -> +2147483647)
    ###################################################################
    # Suppose test_data_word is at 0x2020.
    lui   t0, 0x2
    addi  t0, t0, 0x20  # 0x2020
    lw    t1, 0(t0)
    lui   t2, 0x80000  # 0x80000<<12 = 2147483648
    addi  t2, t2, -1   # 2147483647
    bne   t1, t2, fail

    ###################################################################
    # 6) LW test: negative word (0x80000000 -> -2147483648)
    ###################################################################
    # Suppose test_data_word_neg is at 0x2024.
    lui   t0, 0x2
    addi  t0, t0, 0x24  # 0x2024
    lw    t1, 0(t0)
    lui   t2, -0x80000
    bne   t1, t2, fail

    ###################################################################
    # 7) LBU test: negative byte (0x80 -> 128)
    ###################################################################
    # Use address 0x2004 (as for test_data_byte_neg).
    lui   t0, 0x2
    addi  t0, t0, 4
    lbu   t1, 0(t0)
    lui   t2, 0
    addi  t2, t2, 128
    bne   t1, t2, fail

    ###################################################################
    # 8) LHU test: negative half (0x8000 -> 32768)
    ###################################################################
    # Use address 0x2014 (as for test_data_half_neg).
    lui   t0, 0x2
    addi  t0, t0, 0x14
    lhu   t1, 0(t0)
    lui   t2, 8         # 8<<12 = 32768
    bne   t1, t2, fail

    beq   x0, x0, pass

pass:
1:  beq   x0, x0, 1b

fail:
2:  beq   x0, x0, 2b
