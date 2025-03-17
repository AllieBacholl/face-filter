#=============================================================
# File: imm_test.asm
#
# Tests the following RV32I immediate instructions (32-bit):
#   1) ADDI
#   2) SLLI
#   3) SLTI
#   4) XORI
#   5) SRLI
#   6) SRAI
#   7) ORI
#   8) ANDI
#   9) AUIPC
#
# Uses LUI + ADDI (no li pseudo-instructions).
# Unconditional jumps are implemented as beq x0,x0.
#=============================================================

    .section .text
    .globl _start

_start:
    ###############################################################
    # 1) Test ADDI: t1 = 5, then t2 = t1 + 7 = 12
    ###############################################################
    lui   t1, 0
    addi  t1, t1, 5
    addi  t2, t1, 7
    lui   t3, 0
    addi  t3, t3, 12
    bne   t2, t3, fail

    ###############################################################
    # 2) Test SLLI: t1 = 1, then t2 = t1 << 3 = 8
    ###############################################################
    lui   t1, 0
    addi  t1, t1, 1
    slli  t2, t1, 3
    lui   t3, 0
    addi  t3, t3, 8
    bne   t2, t3, fail

    ###############################################################
    # 3) Test SLTI: t1 = 3; (3 < 5)? => t2 = 1
    ###############################################################
    lui   t1, 0
    addi  t1, t1, 3
    slti  t2, t1, 5
    lui   t3, 0
    addi  t3, t3, 1
    bne   t2, t3, fail

    ###############################################################
    # 4) Test XORI: t1 = 0x55, XOR 0x0F => t2 = 0x5A
    ###############################################################
    lui   t1, 0
    addi  t1, t1, 85         # 0x55
    xori  t2, t1, 15         # 15 = 0x0F
    lui   t3, 0
    addi  t3, t3, 90         # 0x5A = 90
    bne   t2, t3, fail

    ###############################################################
    # 5) Test SRLI: t1 = 240, >>4 => t2 = 15
    ###############################################################
    lui   t1, 0
    addi  t1, t1, 240
    srli  t2, t1, 4
    lui   t3, 0
    addi  t3, t3, 15
    bne   t2, t3, fail

    ###############################################################
    # 6) Test SRAI: t1 = -8, >>1 => t2 = -4
    ###############################################################
    lui   t1, 0
    addi  t1, t1, -8
    srai  t2, t1, 1
    lui   t3, 0
    addi  t3, t3, -4
    bne   t2, t3, fail

    ###############################################################
    # 7) Test ORI: t1 = 240, OR 0x0F => t2 = 255
    ###############################################################
    lui   t1, 0
    addi  t1, t1, 240
    ori   t2, t1, 15
    lui   t3, 0
    addi  t3, t3, 255
    bne   t2, t3, fail

    ###############################################################
    # 8) Test ANDI: t1 = 255, AND 0x0F => t2 = 15
    ###############################################################
    lui   t1, 0
    addi  t1, t1, 255
    andi  t2, t1, 15
    lui   t3, 0
    addi  t3, t3, 15
    bne   t2, t3, fail

    ###############################################################
    # 9) Test AUIPC: auipc t1, 0 gives PC at this instruction;
    #    Compare with computed address of test_auipc.
    ###############################################################
test_auipc:
    auipc t1, 0
    lui   t2, 0
    addi  t2, t2, test_auipc - _start  # If you know the offset, you can compute it
    # Alternatively, if your memory map is fixed, load the expected PC directly.
    # For this example, assume the expected value is computed externally.
    bne   t1, t2, fail

    beq   x0, x0, pass

pass:
1:  beq   x0, x0, 1b

fail:
2:  beq   x0, x0, 2b
