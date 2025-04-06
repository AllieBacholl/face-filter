#---------------------------------------------------------
# File: load_test.asm
#---------------------------------------------------------
# Demonstrates:
#   lb  (load byte, sign-extended)
#   lbu (load byte, zero-extended)
#   lh  (load halfword, sign-extended)
#   lhu (load halfword, zero-extended)
#   lw  (load word)
#
# This file avoids the use of the pseudo-instruction "la" by
# manually loading addresses with "lui" and "addi".
#
# Data is placed starting at 0x10000.
#---------------------------------------------------------

    .section .data
    .org 0x10000         # Place the following data starting at 0x10000

myByte:  .byte  0x82    # 1 byte: 0x82 (should be sign-extended to 0xFFFFFF82)
myHalf:  .half  0xF234  # 2 bytes: 0xF234 (should be sign-extended to 0xFFFFF234)
myWord:  .word  0x1234ABCD  # 4 bytes: 0x1234ABCD

    .section .text
    .globl _start

_start:
    #-----------------------------------------------------
    # 1) lb: Load byte (sign-extended)
    #    Address of myByte is 0x10000
    #-----------------------------------------------------
    lui   x1, 0x10         # x1 = 0x10 << 12 = 0x10000
    lb    x2, 0(x1)        # x2 = sign-extended value from myByte
                           # Expected: 0xFFFFFF82

    #-----------------------------------------------------
    # 2) lbu: Load byte (zero-extended)
    #    Re-load address for myByte (0x10000)
    #-----------------------------------------------------
    lui   x3, 0x10         # x3 = 0x10000
    lbu   x4, 0(x3)        # x4 = zero-extended value from myByte
                           # Expected: 0x00000082

    #-----------------------------------------------------
    # 3) lh: Load halfword (sign-extended)
    #    Address of myHalf is 0x10000 + 2 = 0x10002
    #-----------------------------------------------------
    lui   x5, 0x10         # x5 = 0x10000
    addi  x5, x5, 2        # x5 = 0x10002 (address of myHalf)
    lh    x6, 0(x5)        # x6 = sign-extended value from myHalf
                           # Expected: 0xFFFFF234

    #-----------------------------------------------------
    # 4) lhu: Load halfword (zero-extended)
    #    Address of myHalf is 0x10002
    #-----------------------------------------------------
    lui   x7, 0x10         # x7 = 0x10000
    addi  x7, x7, 2        # x7 = 0x10002
    lhu   x8, 0(x7)        # x8 = zero-extended value from myHalf
                           # Expected: 0x0000F234

    #-----------------------------------------------------
    # 5) lw: Load word
    #    Address of myWord is 0x10000 + 4 = 0x10004
    #-----------------------------------------------------
    lui   x9, 0x10         # x9 = 0x10000
    addi  x9, x9, 4        # x9 = 0x10004 (address of myWord)
    lw    x10, 0(x9)       # x10 = value from myWord
                           # Expected: 0x1234ABCD

