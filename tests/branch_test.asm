#==============================================================
# File: branch_test.asm
#
# Tests these RV32I branch instructions:
#   1) BEQ
#   2) BNE
#   3) BLT
#   4) BGE
#   5) BLTU
#   6) BGEU
#
# Each branch is tested in two scenarios:
#   - Branch taken (should jump)
#   - Branch not taken (should fall through)
#
# If any test fails, branch to fail:.
# If all tests pass, branch to pass:.
#
# No li/la or unconditional jumps (j) are used.
# Unconditional branches are implemented with:
#    beq x0, x0, <label>
#==============================================================

    .section .text
    .globl _start

_start:
    ################################################################
    # 1) BEQ Test
    # Test 1A: Taken: t1=5, t2=5
    ################################################################
    lui   t1, 0
    addi  t1, t1, 5
    lui   t2, 0
    addi  t2, t2, 5
    beq   t1, t2, beq_taken
    beq   x0, x0, fail   # if not taken -> fail

beq_taken:
    # Test 1B: Not taken: t1=5, t2=6
    lui   t1, 0
    addi  t1, t1, 5
    lui   t2, 0
    addi  t2, t2, 6
    beq   t1, t2, fail   # should not branch
    beq   x0, x0, test_bne

    ################################################################
    # 2) BNE Test
    # Test 2A: Taken: t1=3, t2=5
    ################################################################
test_bne:
    lui   t1, 0
    addi  t1, t1, 3
    lui   t2, 0
    addi  t2, t2, 5
    bne   t1, t2, bne_taken
    beq   x0, x0, fail

bne_taken:
    # Test 2B: Not taken: t1=5, t2=5
    lui   t1, 0
    addi  t1, t1, 5
    lui   t2, 0
    addi  t2, t2, 5
    bne   t1, t2, fail
    beq   x0, x0, test_blt

    ################################################################
    # 3) BLT Test (signed)
    # Test 3A: Taken: t1 = -2, t2 = 3
    ################################################################
test_blt:
    lui   t1, 0
    addi  t1, t1, -2
    lui   t2, 0
    addi  t2, t2, 3
    blt   t1, t2, blt_taken
    beq   x0, x0, fail

blt_taken:
    # Test 3B: Not taken: t1 = 2, t2 = -3
    lui   t1, 0
    addi  t1, t1, 2
    lui   t2, 0
    addi  t2, t2, -3
    blt   t1, t2, fail
    beq   x0, x0, test_bge

    ################################################################
    # 4) BGE Test (signed)
    # Test 4A: Taken: t1 = 2, t2 = -3
    ################################################################
test_bge:
    lui   t1, 0
    addi  t1, t1, 2
    lui   t2, 0
    addi  t2, t2, -3
    bge   t1, t2, bge_taken
    beq   x0, x0, fail

bge_taken:
    # Test 4B: Not taken: t1 = -2, t2 = 3
    lui   t1, 0
    addi  t1, t1, -2
    lui   t2, 0
    addi  t2, t2, 3
    bge   t1, t2, fail
    beq   x0, x0, test_bltu

    ################################################################
    # 5) BLTU Test (unsigned)
    # Test 5A: Taken: t1 = 2, t2 = 0xFFFFFFFC
    ################################################################
test_bltu:
    lui   t1, 0
    addi  t1, t1, 2
    # Build 0xFFFFFFFC: For example, use -1 (0xFFFFFFFF) then add 4 less:
    lui   t2, -1           # t2 becomes 0xFFFFF000 when shifted
    addi  t2, t2, 4092     # 4092 decimal = 0xFFC -> t2 = 0xFFFFFFFC
    bltu  t1, t2, bltu_taken
    beq   x0, x0, fail

bltu_taken:
    # Test 5B: Not taken: t1 = 0xFFFFFFFC, t2 = 2
    lui   t1, -1
    addi  t1, t1, 4092     # t1 = 0xFFFFFFFC
    lui   t2, 0
    addi  t2, t2, 2
    bltu  t1, t2, fail
    beq   x0, x0, test_bgeu

    ################################################################
    # 6) BGEU Test (unsigned)
    # Test 6A: Taken: t1 = 0xFFFFFFFC, t2 = 2
    ################################################################
test_bgeu:
    lui   t1, -1
    addi  t1, t1, 4092     # t1 = 0xFFFFFFFC
    lui   t2, 0
    addi  t2, t2, 2
    bgeu  t1, t2, bgeu_taken
    beq   x0, x0, fail

bgeu_taken:
    # Test 6B: Not taken: t1 = 2, t2 = 0xFFFFFFFC
    lui   t1, 0
    addi  t1, t1, 2
    lui   t2, -1
    addi  t2, t2, 4092     # t2 = 0xFFFFFFFC
    bgeu  t1, t2, fail
    beq   x0, x0, pass

#------------------------------------------------------
# pass: Loop forever indicating success.
#------------------------------------------------------
pass:
1:  beq   x0, x0, 1b

#------------------------------------------------------
# fail: Loop forever indicating failure.
#------------------------------------------------------
fail:
2:  beq   x0, x0, 2b
