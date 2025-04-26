#=============================================================
# File: store_tests.asm
#
# Tests the following RV32I store instructions:
#   1) SB (Store Byte)
#   2) SH (Store Half)
#   3) SW (Store Word)
#
# Procedure:
#   - Store known values into fixed memory addresses.
#   - Load them back (using LB/LH/LW) to verify correctness.
#   - If any mismatch occurs, branch to fail:
#   - Otherwise, branch to pass:.
#
# No li or la pseudo-instructions are used; only lui + addi.
# Fixed addresses are hard-coded:
#
#   mem_byte_pos:  0x1000
#   mem_byte_neg:  0x1004
#   mem_half_pos:  0x1010
#   mem_half_neg:  0x1014
#   mem_word_pos:  0x1020
#   mem_word_neg:  0x1024
#=============================================================

    .section .data
    .align 4

# Reserve space for store tests
mem_byte_pos:  .space 1
mem_byte_neg:  .space 1
mem_half_pos:  .space 2
mem_half_neg:  .space 2
mem_word_pos:  .space 4
mem_word_neg:  .space 4

    .section .text
    .globl _start

#-------------------------------------------------------
# _start: entry point
#-------------------------------------------------------
_start:

################################################################################
# 1) SB test: store a positive byte (127 = 0x7F) into mem_byte_pos (0x1000)
#    then load it back with LB and compare.
################################################################################
    # Load address 0x1000 into t0
    lui   t0, 0x1             # 0x1 << 12 = 0x1000
    addi  t0, t0, 0          # t0 = 0x1000

    # t1 = 127
    lui   t1, 0
    addi  t1, t1, 127

    # Store byte: SB t1 => mem_byte_pos
    sb    t1, 0(t0)

    # Read back with LB
    lb    t2, 0(t0)

    # Expected value = 127 in t3
    lui   t3, 0
    addi  t3, t3, 127
    bne   t2, t3, fail

################################################################################
# 2) SB test: store a negative byte (-128) into mem_byte_neg (0x1004)
#    then load it back with LB and compare.
################################################################################
    # Load address 0x1004 into t0
    lui   t0, 0x1             # 0x1 << 12 = 0x1000
    addi  t0, t0, 4          # 0x1000 + 4 = 0x1004

    # t1 = -128
    lui   t1, 0
    addi  t1, t1, -128

    # Store byte: SB t1 => mem_byte_neg
    sb    t1, 0(t0)

    # Read back with LB
    lb    t2, 0(t0)

    # Expected value = -128 in t3
    lui   t3, 0
    addi  t3, t3, -128
    bne   t2, t3, fail

################################################################################
# 3) SH test: store a positive halfword (32767) into mem_half_pos (0x1010)
#    then load it back with LH and compare.
################################################################################
    # Load address 0x1010 into t0
    lui   t0, 0x1             # 0x1 << 12 = 0x1000
    addi  t0, t0, 0x10        # 0x1000 + 0x10 = 0x1010

    # t1 = 32767: Compute as (8 << 12) - 1; 8<<12 = 32768
    lui   t1, 8              # t1 = 8 << 12 = 32768
    addi  t1, t1, -1         # t1 = 32767

    # Store half: SH t1 => mem_half_pos
    sh    t1, 0(t0)

    # Read back with LH
    lh    t2, 0(t0)

    # Expected value = 32767 in t3
    lui   t3, 8
    addi  t3, t3, -1
    bne   t2, t3, fail

################################################################################
# 4) SH test: store a negative halfword (-32768) into mem_half_neg (0x1014)
#    then load it back with LH and compare.
################################################################################
    # Load address 0x1014 into t0
    lui   t0, 0x1             # 0x1 << 12 = 0x1000
    addi  t0, t0, 0x14        # 0x1000 + 0x14 = 0x1014

    # t1 = -32768: Compute as -8 << 12 (since -8*4096 = -32768)
    lui   t1, -8             # t1 = -8 << 12 = -32768

    # Store half: SH t1 => mem_half_neg
    sh    t1, 0(t0)

    # Read back with LH
    lh    t2, 0(t0)

    # Expected value = -32768 in t3
    lui   t3, -8
    bne   t2, t3, fail

################################################################################
# 5) SW test: store a positive word (2147483647) into mem_word_pos (0x1020)
#    then load it back with LW and compare.
################################################################################
    # Load address 0x1020 into t0
    lui   t0, 0x1             # 0x1 << 12 = 0x1000
    addi  t0, t0, 0x20        # 0x1000 + 0x20 = 0x1020

    # t1 = 2147483647: Compute as (0x80000 << 12) - 1; 0x80000<<12 = 2147483648
    lui   t1, 0x80000        # t1 = 0x80000 << 12 = 2147483648
    addi  t1, t1, -1         # t1 = 2147483647

    # Store word: SW t1 => mem_word_pos
    sw    t1, 0(t0)

    # Read back with LW
    lw    t2, 0(t0)

    # Expected value = 2147483647 in t3
    lui   t3, 0x80000
    addi  t3, t3, -1
    bne   t2, t3, fail

################################################################################
# 6) SW test: store a negative word (-2147483648) into mem_word_neg (0x1024)
#    then load it back with LW and compare.
################################################################################
    # Load address 0x1024 into t0
    lui   t0, 0x1             # 0x1 << 12 = 0x1000
    addi  t0, t0, 0x24        # 0x1000 + 0x24 = 0x1024

    # t1 = -2147483648: Compute as -0x80000 << 12 = -2147483648
    lui   t1, -0x80000
    # (No addi needed; the lower 12 bits are zero)

    # Store word: SW t1 => mem_word_neg
    sw    t1, 0(t0)

    # Read back with LW
    lw    t2, 0(t0)

    # Expected value = -2147483648 in t3
    lui   t3, -0x80000
    bne   t2, t3, fail

################################################################################
# If we get here, all tests passed!
################################################################################
    beq   x0, x0, pass        # Unconditional branch to pass

#------------------------------------------------------
# pass: and fail: routines (using unconditional branches)
#------------------------------------------------------
pass:
1:  beq   x0, x0, 1b         # Loop forever indicating success

fail:
2:  beq   x0, x0, 2b         # Loop forever indicating failure
