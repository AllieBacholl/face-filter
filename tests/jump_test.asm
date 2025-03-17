#===========================================================
# File: jump_test.asm
#
# Tests RV32I jump instructions:
#   1) JAL  (Jump And Link)
#   2) JALR (Jump And Link Register)
#
# Verifies:
#   - The target address is reached.
#   - x1 (ra) holds the return address.
#
# No j or jr instructions are used.
# Unconditional branches use "beq x0, x0, <label>".
#===========================================================

    .section .text
    .globl _start

_start:
    beq x0, x0, test_jal   # instead of j test_jal

#-----------------------------------------------------------
# test_jal:
# Use JAL to jump to jal_target; ra should get (test_jal+4)
#-----------------------------------------------------------
test_jal:
    jal   ra, jal_target
    beq   x0, x0, test_jalr  # instead of j test_jalr

#-----------------------------------------------------------
# jal_target:
# Verify ra == test_jal + 4; then branch unconditionally.
#-----------------------------------------------------------
jal_target:
    lui   t2, 0
    addi  t2, t2, test_jal + 4   # Hard-code expected address if known
    bne   ra, t2, fail
    beq   x0, x0, test_jal_return

test_jal_return:
    beq   x0, x0, test_jalr   # continue to next test

#-----------------------------------------------------------
# test_jalr:
# Load address of jalr_target into t0 and use JALR.
#-----------------------------------------------------------
test_jalr:
    lui   t0, 0
    addi  t0, t0, jalr_target   # load target address (fixed value)
    jalr  ra, t0, 0             # jump to jalr_target; ra gets test_jalr + 4
    beq   x0, x0, test_done

#-----------------------------------------------------------
# jalr_target:
# Expect ra to equal after_jalr address.
# Instead of jr, use jalr with x0 as destination.
#-----------------------------------------------------------
jalr_target:
    lui   t1, 0
    addi  t1, t1, after_jalr   # expected address of after_jalr
    bne   ra, t1, fail
    jalr  x0, t1, 0            # jump unconditionally to after_jalr

after_jalr:
    beq   x0, x0, test_jalr_return

test_jalr_return:
    beq   x0, x0, test_done

#-----------------------------------------------------------
# test_done:
# All tests passed.
#-----------------------------------------------------------
test_done:
    beq   x0, x0, pass

pass:
1:  beq   x0, x0, 1b

fail:
2:  beq   x0, x0, 2b
