#=============================================================
# File: lui_test.asm
#
# Tests the RV32I LUI instruction.
# LUI loads an immediate into the upper 20 bits.
#
# For example, "lui t0, 0x12345" should load 0x12345000.
# If any test fails, branch to fail:, else branch to pass:.
#
# No li/la or unconditional j instructions are used.
#=============================================================

    .section .text
    .globl _start

_start:
    ###############################################################
    # Test 1: LUI with immediate = 0x00000, expecting 0x00000000
    ###############################################################
    lui   t0, 0x00000
    lui   t1, 0x00000
    bne   t0, t1, fail

    ###############################################################
    # Test 2: LUI with immediate = 0x00001, expecting 0x00001000
    ###############################################################
    lui   t0, 0x00001
    # Expected value: 0x00001000
    lui   t1, 0x00001
    bne   t0, t1, fail

    ###############################################################
    # Test 3: LUI with immediate = 0x12345, expecting 0x12345000
    ###############################################################
    lui   t0, 0x12345
    lui   t1, 0x12345
    bne   t0, t1, fail

    ###############################################################
    # Test 4: LUI with immediate = 0xFFFFF, expecting 0xFFFFF000
    ###############################################################
    lui   t0, 0xFFFFF
    lui   t1, 0xFFFFF
    bne   t0, t1, fail

    beq   x0, x0, pass

pass:
1:  beq   x0, x0, 1b

fail:
2:  beq   x0, x0, 2b
